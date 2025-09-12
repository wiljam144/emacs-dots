;; -*- coding: utf-8; lexical-binding: t -*-

(require 'cl-lib)

(cl-defstruct task
  name visible dependencies function)

(defvar tasks-list '())
(defvar tasks-hash (make-hash-table :test #'equal))

(defun tasks-register (tk)
  (when (task-visible tk)
    (push (task-name tk) tasks-list))
  (puthash (task-name tk) tk tasks-hash))

(defun tasks-select ()
  (interactive)
  (let ((choice (completing-read "Task: " tasks-list nil t)))
    (tasks-execute-task (gethash choice tasks-hash))))

(defun tasks-run (name)
  (if (map-contains-key tasks-hash name)
      (tasks-execute-task (gethash name tasks-hash))
    (message "Invalid task name: %s" name)))

(defun tasks-execute-task (tk)
  (dolist (dependency (task-dependencies tk))
    (tasks-run dependency))
  (funcall (task-function tk)))

(defconst tasks-trusted-file
  (expand-file-name "tasks-trusted.el" user-emacs-directory))

(defvar tasks-trusted-files '())

(defun tasks-save-trusted-files ()
  (with-temp-file tasks-trusted-file
    (insert ";; Trusted files for tasks.el\n")
    (insert "(setq tasks-trusted-files '")
    (prin1 tasks-trusted-files (current-buffer))
    (insert ")\n")))

(when (file-exists-p tasks-trusted-file)
  (load-file tasks-trusted-file))

(defun tasks-open-project ()
  (let* ((root (projectile-project-root))
         (tasks-file (expand-file-name ".tasks.el" root)))
    (when (file-exists-p tasks-file)
      (setq tasks-list '())
      (setq tasks-hash (make-hash-table :test #'equal))
      (cond
       ((member tasks-file tasks-trusted-files)
        (load-file tasks-file))
       ((y-or-n-p (format "Trust project at %s and load .tasks.el? " root))
        (when (y-or-n-p "Trust permanently? ")
          (add-to-list 'tasks-trusted-files tasks-file)
          (tasks-save-trusted-files))
        (load-file tasks-file))
       (t
        (message "Skipped loading untrusted .tasks.el"))))))

(add-hook 'projectile-after-switch-project-hook #'tasks-open-project)
