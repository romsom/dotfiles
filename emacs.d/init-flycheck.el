(require 'flycheck)

(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
      '(flycheck-checkpatch-setup))
