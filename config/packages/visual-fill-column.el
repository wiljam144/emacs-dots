;; -*- coding: utf-8; lexical-binding: t -*-

(defun wl/toggle-continuation-fringe-indicator ()
  (interactive)
  (setq-default
   fringe-indicator-alist
   (if (assq 'continuation fringe-indicator-alist)
       (delq (assq 'continuation fringe-indicator-alist) fringe-indicator-alist)
     (cons '(continuation right-curly-arrow left-curly-arrow) fringe-indicator-alist))))

(defun wl/enable-visual-fill-column ()
  (progn
    (setq-local word-wrap t)
    (setq-local word-wrap-by-category t)
    (wl/toggle-continuation-fringe-indicator)
    (visual-line-mode)
    (visual-fill-column-mode)))

(use-package visual-fill-column
  :ensure t
  :hook
  (Info-mode . wl/enable-visual-fill-column)
  (woman-mode . wl/enable-visual-fill-column)
  (org-mode . wl/enable-visual-fill-column)
  (help-mode . wl/enable-visual-fill-column)
  :custom
  (visual-fill-column-center-text t))
