;; set custom-safe-themes before loading monokai
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("c59857e3e950131e0c17c65711f1812d20a54b829115b7c522672ae6ba0864cc" "57f8801351e8b7677923c9fe547f7e19f38c99b80d68c34da6fa9b94dc6d3297" default))
 '(package-selected-packages
   '(csharp-mode meson-mode org-noter org-roam use-package undo-tree org-noter-pdftools org-ref org-roam-bibtex smart-tabs-mode auctex helm helm-cscope nlinum dts-mode company-ghc company-emoji faustine markdown-mode rust-mode faust-mode flycheck flycheck-checkpatch flycheck-haskell flycheck-ocaml flycheck-pony flycheck-rust company-web yaml-mode pkgbuild-mode notmuch monokai-theme lua-mode latex-preview-pane latex-pretty-symbols latex-math-preview graphviz-dot-mode flycheck-irony evil-tutor evil-org evil-jumper evil-iedit-state dot-mode company-jedi company-arduino cdlatex ac-math)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; package

;; prevent package from adding this line here again
;;(package-initialize)
;; will be called in init-package.el

(load "~/.emacs.d/init-package.el")

;; use-package
(require 'use-package)
;; enable this when emacs loading takes too long
;; note: docs say that packages used without implicit autoload (e.g., :bind, :hook) might not load at all, so manually specifying ":defer t" might be the better choice
;; see README: https://github.com/jwiegley/use-package
;;(setq use-package-always-defer 1)

;; font
(load "~/.emacs.d/init-font.el")

;; company
(load "~/.emacs.d/init-company.el")

;; helm
(load "~/.emacs.d/init-helm.el")

;; settings for info mode
(load "~/.emacs.d/init-info.el")

;; load flycheck, needed for init-linux.el
(load "~/.emacs.d/init-flycheck.el")

;; settings for linux coding style, loaded in specific directories
(load "~/.emacs.d/init-linux.el")
(load "~/.emacs.d/kconfig-mode.el")
;; auto-complete
;;(load "~/.emacs.d/init-ac.el")

;; yasnippet
;(load "~/.emacs.d/init-yasnippet.el")

;; notmuch
;;(setq notmuch-init-file "~/.emacs.d/init-notmuch.el")
(load "~/.emacs.d/init-notmuch.el")

;; pdf-tools for org-pdftools etc.
(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install))
;; org
(load "~/.emacs.d/init-org.el")
(load "~/.emacs.d/init-org-noter.el")
(load "~/.emacs.d/init-org-roam.el")
(load "~/.emacs.d/init-org-ref.el")

;;;; look and feel

;;inhibit welcome stuff
;;(setq inhibit-startup-echo-area-message t)
;;(setq inhibit-startup-message t)

;; color theme monokai
;; MELPA: monokai-theme
(load-theme 'monokai t)
;; disable tool-bar-mode
(tool-bar-mode -1)
;; disable menu-bar-mode
(menu-bar-mode -1)
;; enable linum-mode
(global-nlinum-mode t)
(add-hook 'pdf-view-mode-hook (lambda ()
	  (nlinum-mode -1)))
;; column-number-mode to show column number in bottom bar
(column-number-mode)
;; highlight current line
(global-hl-line-mode)
;; highlight matching parens
(show-paren-mode)
;; activate smart-tabs-mode for certain languages
(smart-tabs-insinuate 'c)
;; enable undo-tree after evil-mode update doesn't do so automatically anymor
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time


;;;; small stuff

;; c-style
(setq c-basic-offset 4
	  tab-width 4
	  c-default-style
	  '((java-mode . "java")
		(awk-mode . "awk")
		(other . "linux")))

; keybinding for iedit mode
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; latex
; latex preview pane
(require 'latex-preview-pane)
(define-key global-map (kbd "<C-tab>") 'align-current)
(setq pdf-latex-command "xelatex")

;; evil mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

;; printing stuff
(use-package printing
  :config
  (setq ps-lpr-switches '("-PHP_LaserJet_4000_JetDirect"))
  (pr-update-menus))

;; continuous scrolling
(setq doc-view-continuous t)

;; keep list of recently opened files
(recentf-mode 1)
;; set variables in customize instead:
;; (setq recentf-max-menu-items 25)
;; (setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(setq recentf-max-menu-items 100)
(setq recentf-max-saved-items 100)

;; timed actions
(run-at-time nil (* 5 60) (lambda ()
			    (recentf-save-list)
			    (bookmark-save)))
(server-start)
