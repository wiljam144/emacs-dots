;; -*- coding: utf-8; lexical-binding: t -*-

;; GC size of 100mb seems like a fair compromise.
(setq gc-cons-threshold 100000000)
(setq max-specpdl-size 5000)

;; I don't need more information about GNU Emacs and the GNU system.
(defun display-startup-echo-area-message () (message ""))

(setq
 ;; The GNU agitprop is nice, but useless.
 inhibit-startup-screen t
 ;; Double space is a war crime.
 sentence-end-double-space nil
 ;; Never dare to ding at me.
 ring-bell-function 'ignore
 ;; Save existing clipboard into kill-ring, before replacing it.
 save-interprogram-paste-before-kill t
 ;; Minibuffer is for prompts, not the GUI.
 use-dialog-box nil
 ;; Fix undo commands affecting the mark.
 mark-even-if-inactive nil
 ;; use y/n instead of yes/no. The docs advise against it.
 ;; They can go and reread GNU C coding style guides, instead of making such claims.
 use-short-answers t
 ;; prefer newer elisp files.
 load-prefer-newer t
 ;; If native-comp is having some trouble, there's not very much I can do.
 native-comp-async-report-warnings-errors 'silent
 ;; Unicode ellipses are better.
 truncate-string-ellipsis "…"
 ;; I want to close these fast, so switch to it so I can just hit 'q'
 help-window-select t
 ;; This certainly can't hurt anything.
 delete-by-moving-to-trash t
 ;; Highlight error messages more aggressively.
 next-error-message-highlight t
 ;; Don't let the minibuffer muck up my window tiling.
 read-minibuffer-restore-windows t
 ;; Don't keep duplicate entries in kill ring.
 kill-do-not-save-duplicates t)

;; Never mix tabs and spaces. Never use tabs, period.
;; We need the setq-default here because this becomes
;; a buffer-local variable when set.
;; Indent width of 4, pretty much became the
;; standard nowadays (unless you're a kernel developer, which I am not).
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq backward-delete-char-untabify-method 'hungry)
(setq-default electric-indent-inhibit t)

;; Leaving whitespace in code is criminal.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Unicode should always be the default.
(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8-unix)

;; Enable more modern behaviour.
(delete-selection-mode t)

;; Fix scrolling behaviour.
(setq
 fast-but-imprecise-scrolling t
 scroll-conservatively 101
 scroll-up-aggressively 0.01
 scroll-down-aggressively 0.01
 auto-window-vscroll nil)

;; Auto-closing parentheses.
(setq electric-pair-preserve-balance t
      electric-pair-open-newline-between-pairs t
      electric-pair-delete-adjacent-pairs t)
(electric-pair-mode 1)

;; Emacs really, really, really, likes littering in the filesystem with autosaves.
;; This was valid in the 1980s, not today.
(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

;; Custom is great, but can cause mess if you are trying to change variable is
;; being changed in some custom-save-file invocation.
(setq custom-file (make-temp-name "/tmp/"))

;; Emacs is not a secure system and there's little reason to pretend it is.
(setq custom-safe-themes t)

(defun wl/random-choice (items)
  (nth (random (length items)) items))

;; A bit of humour can't hurt. (idea from from Doom Emacs)
(setq wl/scratch-messages '(";; Approved by The Alphabet Bois.\n"
                            ";; Not Copyrighted by Anyone 1432-1785.\n"
                            ";; Spyware Embedded Deep Inside.\n"
                            ";; At least it's not electron.\n"
                            ";; Making vi users feel insecure since 1976.\n"
                            ";; But can your CASIO calculator do that?\n"
                            ";; Eight megabytes and constantly swapping.\n"
                            ";; Binary? Where we're going we don't need binary.\n"
                            ";; This buffer is watching you.\n"
                            ";; Your CPU fan thanks you for not using VSCode.\n"
                            ";; Powered by pure Lisp developer tears.\n"
                            ";; Heap allocation is overrated anyway.\n"
                            ";; The only editor with a built-in psychoterapist.\n"
                            ";; Now with 73% fewer parentheses.\n"
                            ";; Absolutely zero telemetry (we promise).\n"
                            ";; EMACS MACRO ACTED CREDO SODOM\n"
                            ";; Quicksort is Quick.\n"))

(setq wl/quit-messages '("You will regret this. "
                         "Come on, do it, see if I care. "
                         "Get out of here and go back to your boring programs. "
                         "Really? After all we've been through? "
                         "Fine, leave. I'll just garbage collect without you. "
                         "But we were just getting to the good part... "
                         "Top 10 anime betrayals. "
                         "Beware, the horrors of MS/DOS await outside. "
                         "Did you try turning me off and on again? "
                         "Back to Notepad.exe you go. "
                         "Error: dignity.el could not be found. "
                         "I was just about to show you something cool. "
                         "Sending our memories together to /dev/null... "
                         "I'll be here when you come crawling back. "))

(setq initial-scratch-message (concat ";; EDITOR OPERATION NORMAL.\n" (wl/random-choice wl/scratch-messages)))

(add-hook 'kill-emacs-query-functions
          (lambda () (y-or-n-p (wl/random-choice wl/quit-messages)))
          'append)

;; Turns out we can have nice things in life.
(defun wl/pretty-lambda ()
  (setq prettify-symbols-alist '(("lambda" . 955))))
(add-hook 'prog-mode-hook 'wl/pretty-lambda)
(global-prettify-symbols-mode 1)

(add-hook 'after-init-hook (lambda () (message (emacs-init-time))))
