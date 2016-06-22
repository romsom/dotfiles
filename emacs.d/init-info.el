(defun my-Info-mode-hook ()
  (evil-emacs-state)
   ;(evil-local-mode -1)
  )

(add-hook 'Info-mode-hook 'my-Info-mode-hook)
				    
