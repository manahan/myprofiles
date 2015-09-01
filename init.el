;;; -----------------------------------------------------------
;;; Peter Manahan Emacs Init
;;; -----------------------------------------------------------

;;; add the package repositories
(require 'package)

(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
	     '("tromey" . "http://tromey.com/elpa/") t)  
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;; initialize the packages
(package-initialize)

;;; refresh the package if needed.
(when (not package-archive-contents)
  (package-refresh-contents))

;;; setup my custom config files

(progn 
(setq cust-user-config (concat user-emacs-directory user-login-name ".el")
     cust-user-dir (concat user-emacs-directory user-login-name))

;;; add manahan dir
(add-to-list 'load-path cust-user-dir)
(when (file-exists-p cust-user-config ) (load cust-user-config)))

;;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)


;; No need for ~ files when editing
(setq create-lockfiles nil)

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")

;; Langauage-specific
(load "setup-clojure.el")
(load "setup-js.el")

