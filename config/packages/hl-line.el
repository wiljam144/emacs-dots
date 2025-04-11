;; -*- coding: utf-8; lexical-binding: t -*-

(use-package hl-line
  :ensure t
  :hook 
  (prog-mode . hl-line-mode)
  (dired-mode . hl-line-mode)
  :config
  ;; For usage with nord theme.
  (set-face-background 'hl-line "#22232a"))
