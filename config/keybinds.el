;; -*- coding: utf-8; lexical-binding: t -*-

;; I'm a vim refugee, because of that I use
;; evil mode, I also unbind all of the Emacs
;; key combos since they are of no use for me.

(visual-line-mode t)
(setq evil-respect-visual-line-mode t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil
        evil-respect-virtual-line-mode 1
        ;; I am morally against the existence of a way to enter
        ;; into inferior Emacs default bindings.
        evil-toggle-key "")
  :custom
  (evil-want-C-u-scroll t)
  (evil-want-fine-undo t)
  (evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (evil-set-leader nil (kbd "SPC")))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Idk if this mess of elisp was worth it instead of
;; just a lot of (evil-define-key) invocations,
;; but I don't care.
(defun wl/mode-binding (bind state)
  (let ((module-name (symbol-name (eval (nth 0 bind))))
        (chord (kbd (nth 1 bind)))
        (func (eval (nth 2 bind))))
    (cond
     ((string-match-p "-map" module-name)
      (evil-define-key state (symbol-value (eval (nth 0 bind))) chord func))
     ((string-match-p "-mode" module-name)
      (with-eval-after-load (eval (nth 0 bind))
        (evil-define-key state (symbol-value (intern (concat module-name "-map"))) chord func)))
     (t
      (with-eval-after-load (eval (nth 0 bind))
        (evil-define-key state (symbol-value (intern (concat module-name "-mode-map"))) chord func))))))

(defun wl/define-binds (list state)
  (dolist (bind list)
    (let ((len (length bind)))
      (cond
       ((= len 1) (warn "Invalid binding: 1 argument."))
       ((= len 2) (evil-define-key state 'global (kbd (nth 0 bind)) (eval (nth 1 bind))))
       ((= len 3) (wl/mode-binding bind state))
       ((> len 3) (warn "Invalid binding: > 3 arguments."))))))

(setq wl/bindings-normal
      '(;; Buffer management.
        ("<leader>B" 'switch-to-buffer)
        ("<leader>b k" 'kill-buffer)
        ("<leader>." 'next-buffer)
        ("<leader>," 'previous-buffer)

        ;; Window management.
        ("<leader>w v" 'evil-window-vsplit)
        ("<leader>w h" 'evil-window-split)
        ("<leader>w k" 'delete-window)
        ("<leader>w s" 'scratch-buffer)
        ("C-h" 'windmove-left)
        ("C-l" 'windmove-right)
        ("C-j" 'windmove-down)
        ("C-k" 'windmove-up)
        ("<leader>w H" 'enlarge-window-horizontally)
        ("<leader>w J" 'shrink-window)
        ("<leader>w K" 'enlarge-window)
        ("<leader>w L" 'shrink-window-horizontally)

        ;; Lisp.
        ("<leader>l b" 'eval-buffer)
        ("<leader>l e" 'eval-expression)

        ;; Bookmarks.
        ("<leader>b s" 'bookmark-set)
        ("<leader>b j" 'bookmark-jump)

        ;; Help systems.
        ("<leader>h i" 'info)
        ("<leader>h a" 'apropos)
        ("<leader>h v" 'describe-variable)
        ("<leader>h f" 'describe-function)
        ("<leader>h s" 'describe-symbol)
        ("<leader>h m" 'wl/woman)

        ;; Dired.
        ("<leader>d" 'wl/toggle-dired-sidebar)
        ("<leader>D" 'wl/open-dired)

        ;; Projectile.
        ('projectile "SPC p" 'projectile-command-map)
        ;; This binding is straight up stolen from Doom Emacs.
        ('projectile "SPC SPC"
                     (lambda ()
                       (interactive)
                       (if (projectile-project-p)
                           (projectile-find-file)
                         (projectile-switch-project))))

        ;; Org-mode.
        ;; This one needs to be global so the other branch of the if will work.
        ("<leader>o e"
         (lambda ()
           (interactive)
           (if (eq major-mode 'org-mode)
               (org-edit-src-code)
             (org-edit-src-exit))))
        ('org "<leader>m h" 'org-metaleft)
        ('org "<leader>m l" 'org-metaright)
        ('org "<leader>m k" 'org-metaup)
        ('org "<leader>m j" 'org-metadown)
        ('org "<leader>m H" 'org-shiftmetaleft)
        ('org "<leader>m L" 'org-shiftmetaright)
        ('org "<leader>m K" 'org-shiftmetaup)
        ('org "<leader>m J" 'org-shiftmetadown)
        ;; movement.
        ;; next
        ('org "<leader>n h" 'org-next-visible-heading)
        ('org "<leader>n l" 'org-next-link)
        ;; last
        ('org "<leader>l h" 'org-previous-visible-heading)
        ('org "<leader>l l" 'org-previous-link)
        ;; up
        ('org "<leader>u h" 'outline-up-heading)
        ;; create/capture
        ('org "<leader>c h" 'org-meta-return)
        ('org "<leader>c l" 'org-insert-link)
        ('org "<leader>c t" 'org-timestamp)
        ('org "<leader>c k" 'org-capture-finalize)
        ("<leader>c c" 'org-capture)
        ;;lists
        ('org "<leader>-" 'org-cycle-list-bullet)
        ;; checkbox & todo
        ('org "<leader>x c" 'org-toggle-checkbox)
        ('org "<leader>x t" 'org-todo)
        ;; timestamps
        ('org "<leader>s i" 'org-timestamp-inactive)
        ('org "<leader>s h" 'org-timestamp-down-day)
        ('org "<leader>s j" 'org-timestamp-down)
        ('org "<leader>s k" 'org-timestamp-up)
        ('org "<leader>s l" 'org-timestamp-up-day)
        ;; org table
        ('org "<leader>t a" 'org-table-align)
        ('org "<leader>t h" 'org-table-hline-and-move)
        ('org "<leader>t s" 'org-table-sort-lines)
        ;; org links
        ('org "<leader>l c" 'org-store-link)
        ('org "<leader>l o" 'org-open-at-point)
        ;; org mode roam
        ('org "<leader>r i" 'org-roam-node-insert)
        ("<leader>r f" 'org-roam-node-find)
        ("<leader>r c" 'org-roam-capture)

        ;; Eglot.
        ('eglot "<leader>e a" 'eglot-code-actions)
        ('eglot "<leader>e d" 'eldoc)
        ('eglot "<leader>e c" 'eglot-find-declaration)
        ('eglot "<leader>e f" 'eglot-format)
        ('eglot "<leader>e r" 'eglot-rename)


        ;; To be honest I don't really like any of the
        ;; Emacs's terminal options, hence I use kitty in another DE window.
        ("<leader>~"
         (lambda ()
           (interactive)
           (let ((filepath (if (buffer-file-name)
                               (file-name-directory (buffer-file-name))
                             "/home/wiljam")))
             (start-process "kitty" nil "kitty" filepath))))
        ;; I actually like vterm.
        ("<leader>`" 'vterm-other-window)))

(setq wl/bindings-insert
      '(("TAB"
         (lambda ()
           (interactive)
           (if (string-match-p "-ts-" (symbol-name major-mode))
               (treesit-indent)
             (indent-according-to-mode))))))

(setq wl/bindings-visual
      '(("<leader>i" 'indent-region)
        ("<leader>;" 'comment-or-uncomment-region)))

(wl/define-binds wl/bindings-normal 'normal)
(wl/define-binds wl/bindings-insert 'insert)
(wl/define-binds wl/bindings-visual 'visual)

;; This will infuriate a lot of people...
;; It is my personal act of defiance against the Emacs bindings
;; and a clear statement of loyalty to modal editing and the clearly superior vim bindings.
;; Hence, I perform this blasphemous incantation, forever corrupting
;; the Sacrum of this Emacs instance.
;;
;; (I don't think I got every binding tho, maybe someday this keymap will intercept
;; all of Emacs's bindings)

(defvar wl/intercept-keymap (make-sparse-keymap)
  "Keymap that intercepts and blocks all C- and M- key combinations.")

(defun wl/block-all-control-meta-keys ()
  "Block all control and meta key combinations by setting up an intercept keymap."
  (interactive)
  ;; Reset the keymap
  (setq wl/intercept-keymap (make-sparse-keymap))

  ;; Define a dummy function that does nothing
  (defun wl/ignore-key () (interactive))

  ;; Block all Control key combinations
  (dotimes (i 26)
    (let* ((char (+ ?a i)))
      ;; We need to filter m out, since RET is actually a C-m
      ;; and unbinding RET is not really what we want to do.
      (unless (= char ?m)
        (let ((key (kbd (format "C-%c" char))))
          (define-key wl/intercept-keymap key #'wl/ignore-key)))))

  ;; Block all Meta key combinations
  (dotimes (i 26)
    (let* ((char (+ ?a i))
           (key (kbd (format "M-%c" char))))
      (define-key wl/intercept-keymap key #'wl/ignore-key)))

  ;; Block common control combinations with numbers and symbols
  (dolist (key '("C-1" "C-2" "C-3" "C-4" "C-5" "C-6" "C-7" "C-8" "C-9" "C-0"
                 "C-`" "C-~" "C-!" "C-@" "C-#" "C-$" "C-%" "C-^" "C-&" "C-*"
                 "C-(" "C-)" "C--" "C-=" "C-+" "C-]" "C-\\" "C-|" "C-;" ;; C-[ not included because it is ESC.
                 "C-:" "C-'" "C-\"" "C-," "C-." "C-<" "C->" "C-/" "C-?" "C-_"))
    (define-key wl/intercept-keymap (kbd key) #'wl/ignore-key))

  (dolist (special-key '("SPC" "TAB" "ESC" "DEL" "<home>" "<end>" "<prior>" "<next>"
                         "<left>" "<right>" "<up>" "<down>" "<insert>" "<delete>"
                         "<tab>" "<backspace>"
                         "<f1>" "<f2>" "<f3>" "<f4>" "<f5>" "<f6>"
                         "<f7>" "<f8>" "<f9>" "<f10>" "<f11>" "<f12>"))
    (define-key wl/intercept-keymap (kbd (concat "C-" special-key)) #'wl/ignore-key))

  ;; Make sure our keymap is higher priority than all others
  (add-to-list 'emulation-mode-map-alists
               `((wl-intercept-mode . ,wl/intercept-keymap))))

;; Create a minor mode for our interceptor
(define-minor-mode wl-intercept-mode
  "Minor mode to intercept and block all C-M key combinations."
  :global t
  :init-value t)

(wl/block-all-control-meta-keys)
(wl-intercept-mode 1)

(setq emulation-mode-map-alists
      (append '(evil-mode-map-alist)
              (remove 'evil-mode-map-alist emulation-mode-map-alists)))

(add-to-list 'emulation-mode-map-alists
             `((wl-intercept-mode . ,wl/intercept-keymap))
             t)
