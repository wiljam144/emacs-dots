;; -*- coding: utf-8; lexical-binding: t -*-

(use-package hl-line
  :ensure nil
  :hook 
  (prog-mode . hl-line-mode)
  (dired-mode . hl-line-mode))
