;;;----------------------------
;;;  Org Mode Setup
;;;----------------------------

(require 'org)
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)

(setq org-default-notes-file (concat org-directory "/todo.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
        ("j" "Journal Entry"
         entry (file+datetree "~/org/journal.org")
         "* %?"
         :empty-lines 1)
        ))

;; custom action items
(define-key org-mode-map "\C-cn" 'org-mactions-new-numbered-action)
(setq org-log-done t)

;;; setup agenda files
(setq org-agenda-files (list "~/org/todo.org"
                             "~/org/manage.org" 
                             "~/org/sprint.org"
                             "~/org/datateam.org"
                             "~/org/masterconsole.org"))



(defcustom org-mactions-numbered-action-format "TODO Action #%d "
  "Default structure of the headling of a new action.
    %d will become the number of the action."
  :group 'org-edit-structure
  :type 'string)

(defcustom org-mactions-change-id-on-copy t
  "Non-nil means make new IDs in copied actions.
If an action copied with the command `org-mactions-collect-todos-in-subtree'
contains an ID, that ID will be replaced with a new one."
  :group 'org-edit-structure
  :type 'string)

(defun org-mactions-new-numbered-action (&optional inline)
  "Insert a new numbered action, using `org-mactions-numbered-action-format'.
    With prefix argument, insert an inline task."
  (interactive "P")
  (let* ((num (let ((re "\\`#\\([0-9]+\\)\\'"))
                (1+ (apply 'max 0
                           (mapcar
                            (lambda (e)
                              (if (string-match re (car e))
                                  (string-to-number (match-string 1 (car e)))
                                0))
                            (org-get-buffer-tags))))))
         (tag (concat "#" (number-to-string num))))
    (if inline
        (org-inlinetask-insert-task)
      (org-insert-heading 'force))
    (unless (eql (char-before) ?\ ) (insert " "))
    (insert (format org-mactions-numbered-action-format num))
    (org-toggle-tag tag 'on)
    (if (= (point-max) (point-at-bol))
        (save-excursion (goto-char (point-at-eol)) (insert "\n")))
    (unless (eql (char-before) ?\ ) (insert " "))))

(defun org-mactions-collect-todos-in-subtree ()
  "Collect all TODO items in the current subtree into a flat list."
  (interactive)
  (let ((buf (get-buffer-create "Org TODO Collect"))
        (cnt 0) beg end string s)
    (with-current-buffer buf (erase-buffer) (org-mode))
    (org-map-entries
     (lambda ()
       (setq beg (point) end (org-end-of-subtree t t) cnt (1+ cnt)
             string (buffer-substring beg end)
             s 0)
       (when org-mactions-change-id-on-copy
         (while (string-match "^\\([ \t]*:ID:\\)[ \t\n]+\\([^ \t\n]+\\)[ \t]*$"
                              string s)
           (setq s (match-end 1)
                 string (replace-match (concat "\\1 "
                                               (save-match-data (org-id-new)))
                                       t nil string))))
       (with-current-buffer buf (org-paste-subtree 1 string)
                            (goto-char (point-max))))
     (format "TODO={%s}" (regexp-opt org-not-done-keywords))
     'tree)
    (if (= cnt 0)
        (message "No TODO items in subtree")
      (message "%d TODO entries copied to kill ring" cnt)
      (prog1 (with-current-buffer buf
               (kill-new (buffer-string)))
        (kill-buffer buf)))))
