;; -*- coding: utf-8; lexical-binding: t -*-

(use-package jinx
  :ensure t
  :custom
  (jinx-languages "en_GB")
  :hook
  (emacs-startup . global-jinx-mode))
