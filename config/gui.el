;; -*- coding: utf-8; lexical-binding: t -*-

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

(defun wl/fonts-darwin ()
  (progn
    (add-to-list 'default-frame-alist '(font . "Fira Code 15"))
    (set-face-attribute 'default t :font "Fira Code 15")))

(defun wl/fonts-other ()
  (progn
    (add-to-list 'default-frame-alist '(font . "Fira Code 12"))
    (set-face-attribute 'default t :font "Fira Code 12")))

(if (eq system-type 'darwin)
  (wl/fonts-darwin)
  (wl/fonts-other))
