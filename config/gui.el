;; -*- coding: utf-8; lexical-binding: t -*-

;; I'm an (emacs)-vim user afterall.
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(column-number-mode)
(savehist-mode)

;; Remove UI clutter.
(toggle-frame-maximized)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; For MacOS I like the tool bar because it displays in the system top bar.
;; And not attached to the window.
(if (eq system-type 'darwin)
    (tool-bar-mode 1)
    (tool-bar-mode -1))

;; Serif fonts for the win.
(add-to-list 'default-frame-alist '(font . "Fira Code 12"))
(set-face-attribute 'default t :font "Fira Code 12")
