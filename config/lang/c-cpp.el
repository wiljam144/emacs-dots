;; -*- coding: utf-8; lexical-binding: t -*-

;; kernel developer moment.
(add-hook 'c-ts-mode-hook
          (lambda ()
            (setq-local c-ts-mode-comment-style 'plain)
            (setq-local indent-tabs-mode t)
            (setq-local c-ts-mode-indent-offset 8)
            (setq-local tab-width 8)
            (setq-local evil-shift-width 8)))

;; sane people config.
(add-hook 'c++-ts-mode-hook
          (lambda ()
            (setq-local c-ts-mode-comment-style 'plain)
            (setq-local indent-tabs-mode nil)
            (setq-local c++-ts-mode-indent-offset 4)
            (setq-local c-ts-mode-indent-offset 4)
            (setq-local tab-width 4)
            (setq-local evil-shift-width 4)))
