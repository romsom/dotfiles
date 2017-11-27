(require 'package)
;; set package-archives, add melpa and marmalade, replace gnu url with https version
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
;                         ("marmalade" . "https://marmalade-repo.org/packages/") ;; https seems broken here
                         ("melpa" . "https://melpa.org/packages/")))

;; initialize package mode
;; not needed according to https://www.emacswiki.org/emacs/ELPA,
;; but require latex-preview-pane complains without it
(package-initialize)

;; package maintainance stuff, may some day be unneccessary if I decide to switch to use-package
;; [[http://www.flycheck.org/en/latest/user/installation.html#flycheck-installation]]
(defun utils:installed-packages ()
  "List names of installed packages."
  (seq-sort 'string-lessp
	    (seq-filter (lambda (s) (not (package-built-in-p s)))
			(seq-map (lambda(a) (elt a 0)) package-alist))))

(defun utils:built-in-packages ()
  "List names of installed packages."
  (seq-sort 'string-lessp
	    (seq-filter 'package-built-in-p
			(seq-map (lambda(a) (elt a 0)) package-alist))))

;; to install missing packages run (package-install-selected-packages)
;; a package list will be saved in custom variable package-selected-packages
