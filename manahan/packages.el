;;;---------------------------------------------------------
;;; define my package lists
;;; derived from flyingmachine/emacs-for-clojure
;;;===========================


(defvar my-packages
  '(
    paredit
    clojure-mode
    clojure-mode-extra-font-locking
    cider
    ido-ubiquitous
    smex
    projectile
    rainbow-mode
    rainbow-delimiters
    tagedit
    magit))

;;; handle OSX system path issue
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

;;; install the packages

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

