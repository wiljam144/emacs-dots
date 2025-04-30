;; -*- coding: utf-8; lexical-binding: t -*-

;; This is a fun one, for fleeting notes that are meant to be processed properly later,
;; I have this folder, where each note is a file numbered from 1 onwards.
;; When I want to capture a new fleeting note this creates the file with the next number;
;; and allows me to type into it. This creates a sort of queue for unprocessed notes.
(defun wl/org-fleet-next-file ()
  (let* ((dir (expand-file-name "~/digital-vault/notes/roam/fleeting/"))
         (files (directory-files dir nil "\\`[0-9]+\\.org\\'"))
         (nums (mapcar (lambda (f)
                         (string-to-number (file-name-base f)))
                       files))
         (n 1))
    (while (member n nums)
      (setq n (1+ n)))
    (unless (file-directory-p dir)
      (make-directory dir t))
    (expand-file-name (format "%d.org" n) dir)))

(use-package org
  :ensure nil
  :hook
  (org-mode . visual-fill-column-mode)
  (org-mode . visual-line-mode)
  (org-mode . (lambda ()
                (setq-local word-wrap t)
                (setq-local word-wrap-by-category t)
                (setq-local visual-line-fringe-indicators '(nil right-curly-arrow))))
  (after-init . (lambda ()
                  (with-eval-after-load 'org
                    (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.7)))))
  :custom
  ;; org startup defaults
  (org-startup-indented t)
  (org-startup-with-latex-preview t)
  (org-startup-with-inline-images t)
  ;; org styling
  (org-hide-emphasis-markers t)
  (org-hide-leading-stars t)
  (org-hide-drawer-startup t)
  (org-pretty-entities t)
  (org-ellipsis "…")
  (org-auto-align-tags nil)
  (org-tags-column 0)
  (org-agenda-tags-column 0)
  ;; org organization
  (org-todo-keywords '((sequence "TODO" "WIP" "REVIEWING" "|" "DONE")))
  (org-log-done 'time)
  ;; org behaviour
  (org-insert-heading-respect-content t)
  (org-catch-invisible-edits 'show-and-error)
  (org-return-follows-link t)
  (org-link-frame-setup
        '((vm . vm-visit-folder)
          (vm-imap . vm-visit-imap-folder)
          (gnus . org-gnus-no-new-news)
          (file . find-file)
          (wl . wl-draft)
          (shell . org-link--open-shell)
          (term . org-link--open-shell)
          (mailto . browse-url)
          (https . browse-url)
          (http . browse-url)
          (ftp . browse-url)))
  ;; org src blocks
  (org-src-fontify-natively t)
  (org-edit-src-content-indentation 0)
  (org-src-lang-modes
   '(("python" . python-ts)
     ("c" . c-ts)
     ("c++" . c++-ts)
     ("java" . java-ts)))
  ;; org capture
  (org-capture-templates
   '(;; TODO lists for important things that I need to do preferably as soon as possible.
     ("t" "Todo" plain (file+headline "~/digital-vault/notes/tasks.org" "Tasks")
      "***** TODO %?\nEntered on %U\n %i\n %a" :kill-buffer t)
     ;; My personal journal/diary. I write my thoughts here.
     ("j" "Journal" entry (file+olp+datetree "~/digital-vault/notes/journal.org")
      "* %?\nEntered on %U\n %i\n %a" :kill-buffer t)
     ;; A place for quick ideas, and noting things that I need to do (eg. in my emacs config).
     ;; That are not really important enough to be a TODO.
     ("i" "Idea" item (file+headline "~/digital-vault/notes/ideas.org" "Ideas")
      "%?\n %a" :kill-buffer t)
     ;; In here I just capture no more than a sentence per item, which is just a topic I
     ;; want to do more research on, or a topic to think about more later.
     ("r" "Research later" item (file+headline "~/digital-vault/notes/ideas.org" "Research later")
      "%?\n %a" :kill-buffer t)
     ;; Here I put my contemplations and thoughts.
     ("c" "Contemplation" entry (file+headline "~/digital-vault/notes/contemplatio.org" "Contemplations")
      "* %? %t\n" :kill-buffer t)
     ;; Here I put interesting quotes that I can reflect back on.
     ("u" "Quote" plain (file+headline "~/digital-vault/notes/contemplatio.org" "Quotes")
      "#+BEGIN_QUOTE\n%?\n#+END_QUOTE\n\n" :kill-buffer t)
     ;; Anki card to be put into one of my anki decks later.
     ("a" "Anki card" item (file+headline "~/digital-vault/notes/anki.org" "Cards to Add")
      "%?\n" :kill-buffer t)
     ;; Here I write a quick fleeting note which length is from one to three paragraphs.
     ;; notes from here need further processing (style, aesthetic etc.) and eventually end
     ;; up in my org-roam directory as proper nodes.
     ("f" "Fleeting note" plain (file (lambda () (wl/org-fleet-next-file)))
      "* %?\nEntered on %U\n" :kill-buffer t)))

  :custom-face
  (org-level-1 ((t (:inherit variable-pitch :weight bold :height 1.5))))
  (org-level-2 ((t (:inherit variable-pitch :weight bold :height 1.3))))
  (org-level-3 ((t (:inherit variable-pitch :weight bold :height 1.2))))
  (org-level-4 ((t (:inherit variable-pitch :weight bold :height 1.1))))
  ;; I use org-levels 5 to 8 for todo's.
  (org-level-5 ((t (:inherit fixed-pitch))))
  (org-level-6 ((t (:inherit fixed-pitch))))
  (org-level-7 ((t (:inherit fixed-pitch))))
  (org-level-8 ((t (:inherit fixed-pitch)))))

;; this package is godsend, I swear.
(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :custom
  (org-modern-checkbox
   '((?X . "✔")
     (?- . "┅")
     (?\s . "□")))
  (org-modern-replace-stars "◉○◉○◉")
  (org-modern-star 'replace))

(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode))

(use-package org-fragtog
  :ensure t
  :hook (org-mode . org-fragtog-mode))

(use-package org-roam
  :ensure t
  :hook (after-init . org-roam-db-autosync-mode)
  :custom
  (org-roam-directory (file-truename "~/digital-vault/notes/roam")))

(use-package org-tidy
  :ensure t
  :hook
  (org-mode . org-tidy-mode))
