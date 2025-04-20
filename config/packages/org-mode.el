;; -*- coding: utf-8; lexical-binding: t -*-

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
  ;; org styling
  (org-startup-indented t)
  (org-startup-with-latex-preview t)
  (org-startup-with-inline-images t)
  (org-hide-emphasis-markers t)
  (org-hide-leading-stars t)
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
   '(("t" "Todo" plain (file+headline "~/digital-vault/notes/tasks.org" "Tasks")
      "***** TODO %?\nEntered on %U\n %i\n %a")
     ("j" "Journal" entry (file+datetree "~/digital-vault/notes/journal.org")
      "* %?\nEntered on %U\n %i\n %a")
     ("i" "Idea" item (file+headline "~/digital-vault/notes/ideas.org" "Ideas")
      "%?\n %a")
     ("r" "Research later" item (file+headline "~/digital-vault/notes/ideas.org" "Research later")
      "%?\n %a")
     ("c" "Contemplation" entry (file+headline "~/digital-vault/notes/contemplatio.org" "Contemplations")
      "* %? %t\n")
     ("q" "Quote" plain (file+headline "~/digital-vault/notes/contemplatio.org" "Quotes")
      "#+BEGIN_QUOTE\n%?\n#+END_QUOTE\n\n")))

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
