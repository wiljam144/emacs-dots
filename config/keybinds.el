;; -*- coding: utf-8; lexical-binding: t -*-

;; I'm a vim refugee, because of that I use
;; evil mode, I also unbind all of the Emacs
;; key combos since they are of no use for me.

(visual-line-mode t)
(setq evil-respect-visual-line-mode t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil
        evil-respect-virtual-line-mode 1
        ;; I am morally against the existence of a way to enter
        ;; into inferior Emacs default bindings.
        evil-toggle-key "")
  :custom
  (evil-want-C-u-scroll t)
  (evil-want-fine-undo t)
  (evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (evil-set-leader nil (kbd "SPC")))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(defun wl/binds-nm (list)
  (dolist (bind list)
    (evil-define-key 'normal 'global (kbd (car bind)) (eval (cdr bind)))))

(defun wl/binds-in (list)
  (dolist (bind list)
    (evil-define-key 'insert 'global (kbd (car bind)) (eval (cdr bind)))))

(setq wl/bindings-nm
      ;; Buffer management.
      '(("<leader>B" . 'switch-to-buffer)
        ("<leader>." . 'next-buffer)
        ("<leader>," . 'previous-buffer)

        ;; Bookmarks.
        ("<leader>b s" . 'bookmark-set)
        ("<leader>b j" . 'bookmark-jump)

        ;; Dired.
        ("<leader>e" . 'wl/toggle-dired-sidebar)
        ("<leader>E" . 'wl/open-dired)

        ;; Help system.
        ("<leader>h i" . 'info)
        ("<leader>h a" . 'apropos)
        ("<leader>h v" . 'describe-variable)
        ("<leader>h f" . 'describe-function)
        ("<leader>h s" . 'describe-symbol)
        ("<leader>h m" . 'wl/woman)

        ;; Window management.
        ("<leader>w v" . 'evil-window-vsplit)
        ("<leader>w h" . 'evil-window-split)
        ("C-h" . 'windmove-left)
        ("C-l" . 'windmove-right)
        ("C-j" . 'windmove-down)
        ("C-k" . 'windmove-up)

        ;; Lisp.
        ("<leader>l b" . 'eval-buffer)
        ("<leader>l e" . 'eval-expression)

        ;; Projectile.
        ("SPC p" . 'projectile-command-map)

        ;; Org-mode.
        ("<leader>o e" .
         (lambda ()
           (interactive)
           (if (eq major-mode 'org-mode)
               (org-edit-src-code)
             (org-edit-src-exit))))

        ;; This binding is straight up stolen from Doom Emacs.
        ;; It's the best keybind I've written, it has so much functionality
        ;; so neatly packed in it.
        ("SPC SPC" .
         (lambda ()
           (interactive)
           (if (projectile-project-p)
               (projectile-find-file)
             (projectile-switch-project))))


        ;; To be honest I don't really like any of the
        ;; Emacs's terminal options, hence I use kitty in another DE window.
        ("<leader>`" .
         (lambda ()
           (interactive)
           (let ((filepath (if (buffer-file-name)
                               (file-name-directory (buffer-file-name))
                             "/home/wiljam")))
             (start-process "kitty" nil "kitty" filepath))))))

(setq wl/bindings-in
      ;; Indentation.
      '(("TAB" .
         (lambda ()
           (interactive)
           (if (string-match-p "-ts-" (symbol-name major-mode))
               (treesit-indent)
             (indent-according-to-mode))))))

(wl/binds-nm wl/bindings-nm)
(wl/binds-in wl/bindings-in)

;; This will infuriate a lot of people...
;; It is my personal act of defiance against the Emacs bindings
;; and a clear statement of loyalty to modal editing and the clearly superior vim bindings.
;; Hence, I perform this blasphemous incantation, forever corrupting
;; the Sacrum of this Emacs instance.
;;
;; (I don't think I got every binding tho, maybe someday this keymap will intercept
;; all of Emacs's bindings)

(defvar wl/intercept-keymap (make-sparse-keymap)
  "Keymap that intercepts and blocks all C- and M- key combinations.")

(defun wl/block-all-control-meta-keys ()
  "Block all control and meta key combinations by setting up an intercept keymap."
  (interactive)
  ;; Reset the keymap
  (setq wl/intercept-keymap (make-sparse-keymap))

  ;; Define a dummy function that does nothing
  (defun wl/ignore-key () (interactive))

  ;; Block all Control key combinations
  (dotimes (i 26)
    (let* ((char (+ ?a i)))
      ;; We need to filter m out, since RET is actually a C-m
      ;; and unbinding RET is not really what we want to do.
      (unless (= char ?m)
        (let ((key (kbd (format "C-%c" char))))
          (define-key wl/intercept-keymap key #'wl/ignore-key)))))

  ;; Block all Meta key combinations
  (dotimes (i 26)
    (let* ((char (+ ?a i))
           (key (kbd (format "M-%c" char))))
      (define-key wl/intercept-keymap key #'wl/ignore-key)))

  ;; Block common control combinations with numbers and symbols
  (dolist (key '("C-1" "C-2" "C-3" "C-4" "C-5" "C-6" "C-7" "C-8" "C-9" "C-0"
                 "C-`" "C-~" "C-!" "C-@" "C-#" "C-$" "C-%" "C-^" "C-&" "C-*"
                 "C-(" "C-)" "C--" "C-=" "C-+" "C-]" "C-\\" "C-|" "C-;" ;; C-[ not included because it is ESC.
                 "C-:" "C-'" "C-\"" "C-," "C-." "C-<" "C->" "C-/" "C-?" "C-_"))
    (define-key wl/intercept-keymap (kbd key) #'wl/ignore-key))

  (dolist (special-key '("SPC" "TAB" "ESC" "DEL" "<home>" "<end>" "<prior>" "<next>"
                         "<left>" "<right>" "<up>" "<down>" "<insert>" "<delete>"
                         "<tab>" "<backspace>"
                         "<f1>" "<f2>" "<f3>" "<f4>" "<f5>" "<f6>"
                         "<f7>" "<f8>" "<f9>" "<f10>" "<f11>" "<f12>"))
    (define-key wl/intercept-keymap (kbd (concat "C-" special-key)) #'wl/ignore-key))

  ;; Make sure our keymap is higher priority than all others
  (add-to-list 'emulation-mode-map-alists
               `((wl-intercept-mode . ,wl/intercept-keymap))))

;; Create a minor mode for our interceptor
(define-minor-mode wl-intercept-mode
  "Minor mode to intercept and block all C-M key combinations."
  :global t
  :init-value t)

(wl/block-all-control-meta-keys)
(wl-intercept-mode 1)

(setq emulation-mode-map-alists
      (append '(evil-mode-map-alist)
              (remove 'evil-mode-map-alist emulation-mode-map-alists)))

(add-to-list 'emulation-mode-map-alists
             `((wl-intercept-mode . ,wl/intercept-keymap))
             t)
