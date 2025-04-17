;; -*- coding: utf-8; lexical-binding: t -*-

(setq wl/darwin-font-sizes
      '(:fixed 150
               :variable 170))

(setq wl/other-font-sizes
      '(:fixed 120
               :variable 140))

(defun wl/get-font-size (symbol)
  (if (eq system-type 'darwin)
      (plist-get wl/darwin-font-sizes symbol)
    (plist-get wl/other-font-sizes symbol)))

(custom-theme-set-faces
 'user
 `(default ((t :family "Fira Code" :height ,(wl/get-font-size :fixed))))
 `(fixed-pitch ((t (:family "Fira Code" :height ,(wl/get-font-size :fixed)))))
 `(variable-pitch ((t (:family "Literata" :height ,(wl/get-font-size :variable))))))
