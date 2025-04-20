;; -*- coding: utf-8; lexical-binding: t -*-

;; kernel developer moment.
(add-hook 'c-ts-mode-hook
          (lambda ()
            (setq-local c-ts-mode-comment-style 'plain)
            ;; Use spaces, not tabs
            (setq-local indent-tabs-mode t)
            ;; Each indent step is 4 spaces
            (setq-local c-ts-mode-indent-offset 8)
            ;; Display tabs (if any) as 4 spaces wide
            (setq-local tab-width 8)))


;; sane people config.
(add-hook 'c++-ts-mode-hook
          (lambda ()
            (setq-local c-ts-mode-comment-style 'plain)
            ;; Use spaces, not tabs
            (setq-local indent-tabs-mode nil)
            ;; Each indent step is 4 spaces
            (setq-local c++-ts-mode-indent-offset 4)
            ;; Display tabs (if any) as 4 spaces wide
            (setq-local tab-width 4)))
