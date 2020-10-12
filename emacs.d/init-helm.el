(use-package helm
  :hook
  ;; Enable helm-cscope-mode
  (c-mode . helm-cscope-mode)
  (c++-mode . helm-cscope-mode))

(use-package helm-cscope
  :after helm
  :bind
  (:map helm-cscope-mode-map
		("M-t" . helm-cscope-find-this-symbol)
		("M-r" . helm-cscope-find-global-definition)
		("M-g M-c" . helm-cscope-find-called-function)
		("M-g M-p" . helm-cscope-find-calling-this-function)
		("M-s" . helm-cscope-select)))
