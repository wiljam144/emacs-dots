;; -*- coding: utf-8; lexical-binding: t -*-

(use-package visual-fill-column
  :ensure t
  :hook
  (Info-mode . visual-fill-column-mode)
  (woman-mode . visual-fill-column-mode)
  (org-mode . visual-fill-column-mode)
  (help-mode . visual-fill-column-mode)
  :config
  (setq visual-fill-column-center-text t))
