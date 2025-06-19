;; -*- coding: utf-8; lexical-binding: t -*-

(use-package nerd-icons
  :ensure t)

(use-package doom-modeline
  :after nerd-icons
  :ensure t
  :custom
  (doom-modeline-height 30)
  :hook
  (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-enable-word-count t)
  (doom-modeline-indent-info t))
