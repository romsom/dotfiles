(use-package flycheck
  :hook ((after-init . global-flycheck-mode))
  :config
  (flycheck-checkpatch-setup)
  (with-eval-after-load 'rust-mode
	(add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
  (setq flycheck-ghc-args '("-dynamic")))
