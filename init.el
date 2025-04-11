;; -*- coding: utf-8; lexical-binding: t -*-

;; Things to add:
;; - Treesitter, LSP support (evil-textobj-tree-sitter plugin)
;; - Autocompletion in code
;; - Some programming lang modes
;; - Explore org-mode, org-roam, hyperbole.
;; - Pretty dashboard.

;; When on new machines comment these lines for the first run.
(load-theme 'nord t)
(set-face-attribute 'default nil :background "#1c1d23")

(load "~/.config/emacs/config/defaults.el")
(load "~/.config/emacs/config/gui.el")
(load "~/.config/emacs/config/package.el")
(load "~/.config/emacs/config/keybinds.el")
