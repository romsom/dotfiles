;; OrgMode Options
;; fontify code in code blocks a.k.a. syntax highlighting in code blocks
(setq org-src-fontify-natively t)
(put 'erase-buffer 'disabled nil)
(setq org-babel-load-languages
	  '((python . t)
		(shell . t)
		(emacs-lisp . t)
		(perl . t)
		(R . t)))
(setq org-adapt-indentation nil)
(setq org-agenda-files '("~/Repo/BAi4/ba-thesis/" "~/Dokumente/org/"))

;; enable org templates, e.g. "<s" + TAB for source block  ;; FIXME: workaround
;; https://github.com/syl20bnr/spacemacs/issues/11798
(when (version<= "9.2" (org-version))
  (require 'org-tempo))
