;; OrgMode Options
;; fontify code in code blocks a.k.a. syntax highlighting in code blocks
(setq org-src-fontify-natively t)
(put 'erase-buffer 'disabled nil)
;; allow execution of certain languages in babel
(setq org-babel-load-languages
	  '((python . t)
		(shell . t)
		(emacs-lisp . t)
		(perl . t)
		(R . t)))
(setq org-adapt-indentation nil)
(setq org-agenda-files '("~/Repo/BAi4/ba-thesis/" "~/Syncs/org/"))

;; enable org templates, e.g. "<s" + TAB for source block  ;; FIXME: workaround
;; https://github.com/syl20bnr/spacemacs/issues/11798
(when (version<= "9.2" (org-version))
  (require 'org-tempo))

;; org-pdftools
(use-package org-pdftools
  :hook (org-mode . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :after org-noter
  :config
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))
