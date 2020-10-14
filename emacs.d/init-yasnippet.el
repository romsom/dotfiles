;; start yasnippets - snippets like main, while with condition etc.
(use-package yasnippet
  :ensure t
  :config
;; don't make it global or tab-completion in term won't work
  (yas-global-mode 1)
  (yas-reload-all)
  :hook
  (prog-mode . yas-minor-mode)
  (ess-mode . yas-minor-mode))
