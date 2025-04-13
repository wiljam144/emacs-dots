;; -*- coding: utf-8; lexical-binding: t -*-

(use-package eglot
  :ensure nil
  :config
  (add-hook 'prog-mode-hook 'eglot-ensure)
  ;; My god, do I hate those.
  (add-to-list 'eglot-ignored-server-capabilities :inlayHintProvider))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
    '((c-ts-mode c++-ts-mode) 
      . ("clangd"
          "-j=4"
          "--malloc-trim"
          "--log=error"
          "--background-index"
          "--clang-tidy"
          "--cross-file-rename"
          "--completion-style=detailed"
          "--pch-storage=memory"
          "--header-insertion=never"
          "--header-insertion-decorators=0"))))
