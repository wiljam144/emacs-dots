;; -*- coding: utf-8; lexical-binding: t -*-

(with-eval-after-load 'c-ts-mode
  ;; Indentation settings
  (setq c-ts-mode-indent-offset 4)
  (setq c-ts-mode-indent-style 'linux))

;; Configure C++ mode
(with-eval-after-load 'c++-ts-mode
  ;; Indentation settings
  (setq c++-ts-mode-indent-offset 4)
  (setq c++-ts-mode-indent-style 'stroustrup))