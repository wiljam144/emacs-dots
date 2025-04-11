;; -*- coding: utf-8; lexical-binding: t -*-

;; I use modified minimal theme from the repo.

(use-package indent-bars
  :ensure t
  :hook
  (prog-mode . indent-bars-mode)
  :config
  (setq
    indent-bars-color '(highlight :face-bg t :blend 0.6)
    indent-bars-pattern "."
    indent-bars-width-frac 0.15
    indent-bars-pad-frac 0.1
    indent-bars-starting-column 0
    indent-bars-zigzag nil
    indent-bars-color-by-depth nil
    indent-bars-highlight-current-depth nil
    indent-bars-display-on-blank-lines t))
