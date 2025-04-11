;; -*- coding: utf-8; lexical-binding: t -*-

;; Here, I hacked together a bunch of elisp to create somewhat of a sidebar
;; using dired. I use it to perform some quick file operations that don't
;; require the "big" dired window.
;; The sidebar is a bit wonky and fucks up window arrangement when multiple are opened.
;; but honestly it works quite nicely (for me at least).

(defun wl/open-dired ()
  (interactive)
  (let ((filepath (if (buffer-file-name)
                      (file-name-directory (buffer-file-name))
                      "~/")))
    (dired filepath)))

(defun wl/dired-find-file-other-window ()
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (if (file-directory-p file)
      (progn 
        (dired-find-file)
        (dired-hide-details-mode)
        (evil-local-set-key 'normal (kbd "SPC e") 'wl/toggle-dired-sidebar))
      (let ((other-window (or (window-in-direction 'right)
                              (split-window-right))))
        (select-window other-window)
        (find-file file)))))

(defun wl/find-dired-sidebar-window ()
  (let ((result nil))
    (dolist (window (window-list))
      (when (and (with-selected-window window 
                   (eq major-mode 'dired-mode))
                 (<= (window-width window) 35)) ; Assuming sidebar is narrow
        (setq result window)))
    result))

(defun wl/open-dired-sidebar ()
  (interactive)
  (let ((sidebar-window (wl/find-dired-sidebar-window))
        (filepath (if (buffer-file-name) 
                      (file-name-directory (buffer-file-name))
                      "~/")))
    (if sidebar-window
      (progn 
        (select-window sidebar-window)
        (delete-window))
      (progn
        (split-window-right 30)
        (dired filepath)
        (dired-hide-details-mode)
        (local-set-key (kbd "RET") 'wl/dired-find-file-other-window)
        (local-set-key (kbd "<return>") 'wl/dired-find-file-other-window)
        (evil-local-set-key 'normal (kbd "q") 'ignore)
        (evil-local-set-key 'normal (kbd "SPC e") 'wl/toggle-dired-sidebar)))))

(defun wl/toggle-dired-sidebar () 
  (interactive)
  (if (eq major-mode 'dired-mode)
    (delete-window)
    (wl/open-dired-sidebar)))

(add-hook 'dired-mode-hook 
  (lambda () 
    (display-line-numbers-mode -1)))
