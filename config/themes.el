;; -*- coding: utf-8; lexical-binding: t -*-

(defun wl/theme-darwin ()
  (progn
    (load-theme 'gruvbox-dark-hard t)
    ;; I don't want to know why the author of the theme decided
    ;; on such hideous line number bar background color.
    (set-face-attribute 'line-number nil :background "#222526")
    (set-face-attribute 'line-number-current-line nil :background "#222526")
    (with-eval-after-load 'hl-line
      (set-face-background 'hl-line "#27292a"))))

(defun wl/theme-other ()
  (progn
    (load-theme 'nord t)
    (set-face-attribute 'default nil :background "#1c1d23")
    (with-eval-after-load 'org
      (custom-set-faces
       '(org-block ((t (:background "#282a33" :extend t))))
       '(org-block-begin-line ((t (:background "#282a33" :extend t))))
       '(org-block-end-line ((t (:background "#282a33" :extend t))))
       '(org-indent ((t (:background "#1c1d23" :foreground "#1c1d23" :extend t))))
       '(org-hide ((t (:background "#1c1d23" :foreground "#1c1d23" :extend t))))))
    (with-eval-after-load 'hl-line
      (set-face-background 'hl-line "#22232a"))
    (with-eval-after-load 'indent-bars
      (setq indent-bars-color '(highlight :face-bg t :blend 0.6)))))

(if (eq system-type 'darwin)
    (wl/theme-darwin)
  (wl/theme-other))
