;; start auto-complete wit emacs: this completes statements like 'while'
(require 'auto-complete)
;; default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
;; turn on CEDET semantic mode
(semantic-mode 1)

;; add hooks

;; set semantic as a backend for auto-complete:
;; define a function which adds semantic as a suggestion backend to ac
;; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

(defun my:ac-c-header-init()
  (require  'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include")
)
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; latex math ac
(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)

(defun my:ac-math-init()
  (require 'ac-math)
  (add-to-list 'ac-sources '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands))
)
(add-hook 'latex-mode-hook 'my:ac-math-init)
