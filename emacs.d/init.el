;; set custom-safe-themes before loading monokai
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(custom-safe-themes
   (quote
    ("c59857e3e950131e0c17c65711f1812d20a54b829115b7c522672ae6ba0864cc" "57f8801351e8b7677923c9fe547f7e19f38c99b80d68c34da6fa9b94dc6d3297" default)))
 '(doc-view-continuous t)
 '(fci-rule-color "#49483E")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#49483E" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#49483E" . 100))))
 '(magit-diff-use-overlays nil)
 '(notmuch-saved-searches
   (quote
    ((:name "inbox" :query "tag:inbox" :key "i")
     (:name "unread" :query "tag:unread" :key "u")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "d")
     (:name "all mail" :query "*" :key "a")
     (:name "juze" :query "folder:Juze")
     (:name "Inbox" :query "folder:Inbox")
     (:name "Uni" :query "folder:Uni"))))
 '(package-selected-packages
   (quote
    (company-ghc company-emoji faustine markdown-mode rust-mode faust-mode flycheck flycheck-haskell flycheck-ocaml flycheck-pony flycheck-rust company-web yaml-mode pkgbuild-mode notmuch monokai-theme lua-mode latex-preview-pane latex-pretty-symbols latex-math-preview graphviz-dot-mode flycheck-irony evil-tutor evil-org evil-jumper evil-iedit-state dot-mode company-jedi company-arduino cdlatex ac-math)))
 '(pdf-latex-command "xelatex")
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(send-mail-function (quote sendmail-send-it))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "#373030")))))

;; package

;; prevent package from adding this line here again
;;(package-initialize)
;; will be called in init-package.el

(load "~/.emacs.d/init-package.el")

;; font
(load "~/.emacs.d/init-font.el")

;; company
(load "~/.emacs.d/init-company.el")

;; settings for info mode
(load "~/.emacs.d/init-info.el")

;; load flycheck, needed for init-linux.el
(require 'flycheck)

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
;; column-number-mode to show column number in bottom bar
(column-number-mode)
;; highlight current line
(global-hl-line-mode)
;; highlight matching parens
(show-paren-mode)

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
(define-key global-map (kbd "<C-tab>") 'align-current)

;; OrgMode Options
;; fontify code in code blocks a.k.a. syntax highlighting in code blocks
(setq org-src-fontify-natively t)
(put 'erase-buffer 'disabled nil)

;; evil mode
(require 'evil)
(evil-mode 1)

;; printing stuff
(setq ps-lpr-switches '("-PLaserjet4k-10"))
(require 'printing)
(pr-update-menus)
