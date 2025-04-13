;; -*- coding: utf-8; lexical-binding: t -*-

(require 'cl-lib)
(require 'treesit)

(cl-defstruct treesit-recipe
  "Emacs metadata for a tree-sitter language grammar."
  lang ts-mode remap url ext)

(setq treesit-recipe-list 
  (list 
    (make-treesit-recipe
      :lang 'c
      :ts-mode 'c-ts-mode
      :remap 'c-mode
      :url "https://github.com/tree-sitter/tree-sitter-c"
      :ext '("c"))
    (make-treesit-recipe
      :lang 'cpp
      :ts-mode 'c++-ts-mode
      :remap 'c++-mode
      :url "https://github.com/tree-sitter/tree-sitter-cpp"
      ;; It is better to assume every .h is C++, because this will work with C
      ;; but if c-ts-mode was for .h then every .h header written in C++ will cause issues.
      :ext '("cpp" "hpp" "cc" "hh" "cxx" "hxx" "h"))
    (make-treesit-recipe
      :lang 'java
      :ts-mode 'java-ts-mode
      :remap 'java-mode
      :url "https://github.com/tree-sitter/tree-sitter-java"
      :ext '("java"))
    (make-treesit-recipe
      :lang 'python
      :ts-mode 'python-ts-mode
      :remap 'python-mode
      :url "https://github.com/tree-sitter/tree-sitter-python"
      :ext '("py"))))

(defun wl/install-treesit-grammar (lang)
  "Install tree-sitter grammar if not already installed."
  (interactive)
  (condition-case err
          (when (not (treesit-language-available-p lang))
            (message "Installing grammar for %s..." lang)
            (treesit-install-language-grammar lang)
            (message "Grammar for %s installed successfully!" lang))
        (error (message "Failed to handle grammar for %s: %s" lang (error-message-string err)))))

(defun wl/obtain-ext-regex (ext)
  (concat "\\."
          "\\("
          (mapconcat #'identity ext "\\|")
          "\\)"
          "\\'"))

(setq treesit-language-source-alist '())

(dolist (recipe treesit-recipe-list)
  (let ((lang (treesit-recipe-lang recipe))
        (ts-mode (treesit-recipe-ts-mode recipe))
        (remap (treesit-recipe-remap recipe))
        (url (treesit-recipe-url recipe))
        (ext (treesit-recipe-ext recipe)))
    (progn
      ;; Install missing grammar.
      (add-to-list 'treesit-language-source-alist `(,lang . (,url)))
      (wl/install-treesit-grammar lang)
      ;; Map extensions.
      (add-to-list 'auto-mode-alist (cons (wl/obtain-ext-regex ext) ts-mode))
      ;; Remap mode.
      (add-to-list 'major-mode-remap-alist (cons remap ts-mode)))))