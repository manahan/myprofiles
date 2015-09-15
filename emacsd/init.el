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

;; load packages
(load "packages.el") 

;; Org Mode
(load "myorg.el")

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(coffee-tab-width 2)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3f3f3f" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 180 :width normal :foundry "nil" :family "Monaco")))))
