;; -*- coding: utf-8; lexical-binding: t -*-

(use-package org
  :ensure nil
  :hook
  (org-mode . visual-fill-column-mode)
  (org-mode . visual-line-mode)
  (org-mode . (lambda ()
                (setq-local word-wrap t)
                (setq-local word-wrap-by-category t)
                (setq-local visual-line-fringe-indicators '(nil right-curly-arrow))))
  :custom
  ;; org styling
  (org-startup-indented t)
  (org-hide-emphasis-markers t)
  (org-hide-leading-stars t)
  (org-pretty-entities t)
  (org-ellipsis "…")
  (org-auto-align-tags nil)
  (org-tags-column 0)
  (org-agenda-tags-column 0)
  ;; org organization
  (org-todo-keywords '((sequence "TODO" "WIP" "REVIEWING" "|" "DONE")))
  (org-log-done 'time)
  ;; org behaviour
  (org-insert-heading-respect-content t)
  (org-catch-invisible-edits 'show-and-error)
  ;; org src blocks
  (org-src-fontify-natively t)
  (org-edit-src-content-indentation 0)
  (org-src-lang-modes
   '(("python" . python-ts)
     ("c" . c-ts)
     ("c++" . c++-ts)
     ("java" . java-ts)))

  :custom-face
  (org-level-1 ((t (:inherit variable-pitch :weight bold :height 1.5))))
  (org-level-2 ((t (:inherit variable-pitch :weight bold :height 1.3))))
  (org-level-3 ((t (:inherit variable-pitch :weight bold :height 1.2))))
  (org-level-4 ((t (:inherit variable-pitch :weight bold :height 1.1))))
  (org-level-5 ((t (:inherit variable-pitch :weight bold))))
  (org-level-6 ((t (:inherit variable-pitch :weight bold))))
  (org-level-7 ((t (:inherit variable-pitch :weight bold))))
  (org-level-8 ((t (:inherit variable-pitch :weight bold)))))

;; this package is godsend, I swear.
(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :custom
  (org-modern-replace-stars "◉○◉○◉")
  (org-modern-star 'replace))
