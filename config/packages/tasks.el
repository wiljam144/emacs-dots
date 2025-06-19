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
