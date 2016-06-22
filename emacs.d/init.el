;; package
(load "~/.emacs.d/init-package.el")

;; font
(load "~/.emacs.d/init-font.el")

;; company
(load "~/.emacs.d/init-company.el")

;; settings for info mode
(load "~/.emacs.d/init-info.el")

;; auto-complete
;;(load "~/.emacs.d/init-ac.el")

;; yasnippet
;(load "~/.emacs.d/init-yasnippet.el")

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
(global-linum-mode t)
;; set indent style
(setq c-default-style "linux"
      c-basic-offset 4)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time


;;;; small stuff

; keybinding for iedit mode
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; latex
; latex preview pane
(require 'latex-preview-pane)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("57f8801351e8b7677923c9fe547f7e19f38c99b80d68c34da6fa9b94dc6d3297" default)))
 '(doc-view-continuous t)
 '(pdf-latex-command "xelatex"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(define-key global-map (kbd "<C-tab>") 'align-current)

;; OrgMode Options
;; fontify code in code blocks a.k.a. syntax highlighting in code blocks
(setq org-src-fontify-natively t)
(put 'erase-buffer 'disabled nil)

;; evil mode
(require 'evil)
(evil-mode 1)

;; printing stuff
;;(setq ps-lpr-switches '("-PKM_Bizhub"))
;;(require 'printing)
;;(pr-update-menus)
