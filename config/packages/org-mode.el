;; -*- coding: utf-8; lexical-binding: t -*-

(use-package org
  :ensure nil
  :hook
  (org-mode . variable-pitch-mode)
  (org-mode . visual-fill-column-mode)
  (org-mode . visual-line-mode)
  :config
  (setq visual-fill-column-center-text t)
  (add-hook 'org-mode-hook (lambda ()
                           (setq-local word-wrap t)
                           (setq-local word-wrap-by-category t)
                           (setq-local visual-line-fringe-indicators '(nil right-curly-arrow))))

  ;; Make headers bigger.
  (custom-theme-set-faces
    'user
    '(org-level-1 ((t (:inherit variable-pitch :weight bold :height 1.5))))
    '(org-level-2 ((t (:inherit variable-pitch :weight bold :height 1.3))))
    '(org-level-3 ((t (:inherit variable-pitch :weight bold :height 1.2))))
    '(org-level-4 ((t (:inherit variable-pitch :weight bold :height 1.1))))
    '(org-level-5 ((t (:inherit variable-pitch :weight bold))))
    '(org-level-6 ((t (:inherit variable-pitch :weight bold))))
    '(org-level-7 ((t (:inherit variable-pitch :weight bold))))
    '(org-level-8 ((t (:inherit variable-pitch :weight bold)))))

  ;; Fixes fixed-pitch for some faces. (pun indented)
  (custom-theme-set-faces
    'user
    '(org-block ((t (:inherit fixed-pitch))))
    '(org-block-begin-line ((t (:inherit fixed-pitch))))
    '(org-block-end-line ((t (:inherit fixed-pitch))))
    '(org-code ((t (:inherit (shadow fixed-pitch)))))
    '(org-document-info ((t (:inherit fixed-pitch))))
    '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
    '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
    '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
    '(org-property-value ((t (:inherit fixed-pitch))) t)
    '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
    '(org-table ((t (:inherit fixed-pitch))))
    '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
    '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

  (setq org-src-fontify-natively t)
  (setq org-src-preserve-indentation t)
  (setq org-src-lang-modes
        '(("python" . python-ts)
          ("c" . c-ts)
          ("c++" . c++-ts)
          ("java" . java-ts))))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
