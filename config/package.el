;; -*- coding: utf-8; lexical-binding: t -*-

(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package nord-theme
  :ensure t)

;; BUILT IN
(load "~/.config/emacs/config/packages/hl-line.el")
(load "~/.config/emacs/config/packages/dired.el")

;; IMPORTANT
(load "~/.config/emacs/config/packages/treesit.el")
(load "~/.config/emacs/config/packages/projectile.el")
(load "~/.config/emacs/config/packages/vertico.el")
(load "~/.config/emacs/config/packages/corfu.el")
(load "~/.config/emacs/config/packages/eglot.el")

;; LANGS
(load "~/.config/emacs/config/lang/c-cpp.el")

;; QOL
(load "~/.config/emacs/config/packages/doom-modeline.el")
(load "~/.config/emacs/config/packages/indent-bars.el")
(load "~/.config/emacs/config/packages/visual-fill-column.el")
