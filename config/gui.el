;; -*- coding: utf-8; lexical-binding: t -*-

(load "~/.config/emacs/config/fonts.el")

;; I'm an (emacs)-vim user afterall, so relative numbering it is.
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(column-number-mode)
(savehist-mode)

;; Remove UI clutter.
(scroll-bar-mode -1)
(tool-bar-mode -1)
(toggle-frame-maximized)
;; For MacOS I like the menu bar because it displays in the system top bar.
;; And not attached to the window.
(if (eq system-type 'darwin)
    (menu-bar-mode 1)
  (menu-bar-mode -1))
