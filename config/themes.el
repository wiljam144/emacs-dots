;; -*- coding: utf-8; lexical-binding: t -*-

(defun wl/theme-darwin ()
  (progn
    (load-theme 'gruvbox-dark-hard t)))

(defun wl/theme-other ()
  (progn
    (load-theme 'nord t)
    (set-face-attribute 'default nil :background "#1c1d23")
    (with-eval-after-load 'hl-line 
      (set-face-background 'hl-line "#22232a"))))

(if (eq system-type 'darwin)
  (wl/theme/darwin)
  (wl/theme-other))