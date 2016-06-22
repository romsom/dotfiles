;; start yasnippets - snippets like main, while with condition etc.
(require 'yasnippet)
;; don't make it global or tab-completion in term won't work
(yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode 'yas-minor-mode)
(add-hook 'ess-mode 'yas-minor-mode)
