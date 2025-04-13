;; -*- coding: utf-8; lexical-binding: t -*-

;; I call woman using this function. I temporarily suppress warnings
;; because for some reason woman complains about alias overriding values.
;; I tried to fix and failed, so here we are.
(defun wl/woman ()
  (interactive)
  (let ((warning-minimum-level :error)) ; Temporarily suppress warnings
    (call-interactively 'woman)))