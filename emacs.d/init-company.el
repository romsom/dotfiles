;(require 'company)
;; python
(defun my-company-python-hook ()
  (company-mode)
  (add-to-list 'company-backends 'company-jedi)
  (jedi:setup))
(add-hook 'python-mode-hook 'my-company-python-hook)
;; elisp
(add-hook 'emacs-lisp-mode-hook 'company-mode)
