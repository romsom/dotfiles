(use-package helm
 )

(use-package helm-cscope
  :after helm
  :hook
  ;; Enable helm-cscope-mode
  ((c-mode c++-mode) . (lambda () (helm-cscope-mode 1)))
  :bind
  (:map helm-cscope-mode-map
		("M-t" . helm-cscope-find-this-symbol)
		("M-r" . helm-cscope-find-global-definition)
		("M-g M-c" . helm-cscope-find-called-function)
		("M-g M-p" . helm-cscope-find-calling-this-function)
		("M-s" . helm-cscope-select)))
