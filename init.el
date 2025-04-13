;; -*- coding: utf-8; lexical-binding: t -*-

;; Things to add:
;; - Explore org-mode, org-roam, hyperbole. (maybe pretty dashboard using it)

;; When on new machines comment these lines for the first run.
(load-theme 'nord t)
(set-face-attribute 'default nil :background "#1c1d23")

(load "~/.config/emacs/config/defaults.el")
(load "~/.config/emacs/config/gui.el")
(load "~/.config/emacs/config/package.el")
(load "~/.config/emacs/config/keybinds.el")
