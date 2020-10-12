;; python
;; jedi-mode
;; To use jedi mode, install company-jedi in emacs
;; and jedi, virtualenv and epc either systemwide or using pip
(use-package company
  :config
  (defun my-company-python-hook ()
	(company-mode)
	(add-to-list 'company-backends 'company-jedi)
	(jedi:setup))
  :hook
  (python-mode . my-company-python-hook)
;; elisp
  (emacs-lisp-mode . company-mode))
;; python notes
;; flycheck
;; flycheck-verify-setup checks install
;; flake8 and pylint recommended
