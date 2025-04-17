;; -*- coding: utf-8; lexical-binding: t -*-

(defun wl/theme-darwin ()
  (progn
    (load-theme 'gruvbox-dark-hard t)
    ;; I don't want to know why the author of the theme decided
    ;; on such hideous line number bar background color.
    (set-face-attribute 'line-number nil :background "#222526")
    (set-face-attribute 'line-number-current-line nil :background "#222526")
    (with-eval-after-load 'hl-line
      (set-face-background 'hl-line "#27292a"))
    ;; I don't like indent-bars on my small MacBook screen.
    (with-eval-after-load 'indent-bars
      (remove-hook 'prog-mode-hook 'indent-bars-mode))))

(defun wl/theme-other ()
  (progn
    (load-theme 'nord t)
    (set-face-attribute 'default nil :background "#1c1d23")
    (with-eval-after-load 'hl-line
      (set-face-background 'hl-line "#22232a"))
    (with-eval-after-load 'indent-bars
      (setq indent-bars-color '(highlight :face-bg t :blend 0.6)))))

(if (eq system-type 'darwin)
    (wl/theme-darwin)
  (wl/theme-other))
