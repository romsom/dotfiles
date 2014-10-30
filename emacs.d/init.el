; inhibit welcome stuff
;(setq inhibit-startup-echo-area-message t)
;(setq inhibit-startup-message t)
; printing stuff
(setq ps-lpr-switches '("-PKM_Bizhub"))
(require 'printing)
(pr-update-menus)

;font
(set-face-attribute 'default nil :font "monospace")
(set-face-attribute 'default nil :height 90)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

; start package.el with emacs
(require 'package)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
; initialize package mode
(package-initialize)
; start auto-complete wit emacs: this completes statements like 'while'
(require 'auto-complete)
; default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
; start yasnippets - snippets like main, while with condition etc.
(require 'yasnippet)
(yas-global-mode 1)
(defun my:ac-c-header-init()
  (require  'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include")
)
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
; keybinding for iedit mode
(define-key global-map (kbd "C-c ;") 'iedit-mode)
; turn on CEDET semantic mode
(semantic-mode 1)
; set semantic as a backend for auto-complete:
; define a function which adds semantic as a suggestion backend to ac
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)


; latex math ac
(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)

(defun my:ac-math-init()
  (require 'ac-math)
  (add-to-list 'ac-sources '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands))
)
(add-hook 'latex-mode-hook 'my:ac-math-init)
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

;; color theme monokai
;; MELPA: monokai-theme
(load-theme 'monokai t)
;; disable tool-bar-mode
(tool-bar-mode -1)
;; disable menu-bar-mode
(menu-bar-mode -1)
;; enable linum-mode
(global-linum-mode t)
