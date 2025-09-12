;; -*- coding: utf-8; lexical-binding: t -*-

(use-package eglot
  :ensure nil
  :config
  ;; I don't need LSP for Elisp since the built-in support is good.
  (defun wl/eglot-ensure-unless-elisp ()
    "Start eglot for current buffer unless it's an Emacs Lisp buffer."
    (unless (derived-mode-p 'emacs-lisp-mode)
      (eglot-ensure)))

  ;; Configure clangd for some nice things and most importantly,
  ;; to not auto-insert headers.
  (add-to-list 'eglot-server-programs
               '((c-ts-mode c++-ts-mode)
                 . ("clangd"
                    "-j=4"
                    "--log=error"
                    "--background-index"
                    "--clang-tidy"
                    "--cross-file-rename"
                    "--completion-style=detailed"
                    "--pch-storage=memory"
                    "--header-insertion-decorators=0")))

  :custom
  ;; My god, do I hate those.
  ;; Inlay hints are too noisy and distracting,
  ;; and I can format myself when i want with eglot-format
  (eglot-ignored-server-capabilities '(:inlayHintProvider :documentOnTypeFormattingProvider))

  :config
	(fset #'jsonrpc--log-event #'ignore)
	(setf (plist-get eglot-events-buffer-config :size) 0)
  :hook
  (prog-mode . wl/eglot-ensure-unless-elisp))

(use-package eglot-booster
  :after eglot
  :hook (eglot-mode . eglot-booster-mode))
