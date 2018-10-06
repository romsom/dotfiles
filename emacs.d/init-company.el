;(require 'company)
;; python
;; jedi-mode
;; To use jedi mode, install company-jedi in emacs
;; and jedi, virtualenv and epc either systemwide or using pip
(defun my-company-python-hook ()
  (company-mode)
  (add-to-list 'company-backends 'company-jedi)
  (jedi:setup))
(add-hook 'python-mode-hook 'my-company-python-hook)
;; elisp
(add-hook 'emacs-lisp-mode-hook 'company-mode)
;; python notes
;; flycheck
;; flycheck-verify-setup checks install
;; flake8 and pylint recommended
