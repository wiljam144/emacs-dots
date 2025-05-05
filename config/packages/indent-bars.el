;; -*- coding: utf-8; lexical-binding: t -*-

(if (not (eq system-type 'darwin))
    (progn
      ;; This function reloads indent-bars so that it can pull
      ;; new values from variables.
      (defun wl/restart-bars ()
        (when (bound-and-true-p indent-bars-mode)
          (indent-bars-mode -1)
          (indent-bars-mode 1)))

      (use-package indent-bars
        :ensure t
        :hook
        (after-change-major-mode . wl/restart-bars)
        (prog-mode . indent-bars-mode)
        :custom
        ;; I use modified minimal theme from the repo.
        (indent-bars-pattern ".")
        (indent-bars-width-frac 0.15)
        (indent-bars-pad-frac 0.1)
        (indent-bars-starting-column 0)
        (indent-bars-zigzag nil)
        (indent-bars-color-by-depth nil)
        (indent-bars-highlight-current-depth nil)
        (indent-bars-display-on-blank-lines t))))
