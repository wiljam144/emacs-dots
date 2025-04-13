;; -*- coding: utf-8; lexical-binding: t -*-

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :config
  (setq tab-always-indent 'complete
        text-mode-ispell-word-completion nil
        read-extended-command-predicate #'command-completion-default-include-p
        corfu-auto t
        corfu-auto-delay 0
        corfu-auto-prefix 1
        corfu-quit-no-match 'separator
        corfu-cycle t
        corfu-preselect 'prompt
        corfu-count 5)

  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ("M-h" . corfu-info-documentation)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))

  :hook
  (corfu-mode . (lambda ()
                  (setq-local completion-styles '(basic)
                              completion-category-overrides nil
                              completion-category-defaults nil))))