;; -*- coding: utf-8; lexical-binding: t -*-

(use-package nerd-icons
  :ensure t)

(use-package doom-modeline
  :after nerd-icons
  :ensure t
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-height 30))