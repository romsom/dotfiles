;; OrgMode Options

(defun my:org-latex-export-latex-body
    (&optional async subtreep visible-only ext-plist)
  "Export buffer to latex as bare body without preamble"
  (interactive)
  ;; (org-latex-export-to-latex :body-only t :async async :subtreep subtreep :visible-only visible-only :ext-plist ext-plist)))
  (org-latex-export-to-latex async subtreep visible-only t ext-plist))

(use-package org
  :bind
  (:map org-mode-map
	("C-c a e" . my:org-latex-export-latex-body)))
;; (require 'org)
;; (define-key org-mode-map (kbd "C-c a e") 'my:org-latex-export-latex-body)

;; fontify code in code blocks a.k.a. syntax highlighting in code blocks
(setq org-src-fontify-natively t)
(put 'erase-buffer 'disabled nil)
;; allow execution of certain languages in babel
(setq org-babel-load-languages
	  '((python . t)
		(shell . t)
		(emacs-lisp . t)
		(perl . t)
		(latex . t)
		(R . t)))
(setq org-adapt-indentation nil)
(setq org-agenda-files '("~/Repo/BAi4/ba-thesis/" "~/Syncs/org/"))

;; enable org templates, e.g. "<s" + TAB for source block  ;; FIXME: workaround
;; https://github.com/syl20bnr/spacemacs/issues/11798
(when (version<= "9.2" (org-version))
  (require 'org-tempo))

;; org-pdftools
(use-package org-pdftools
  :ensure t
  :hook (org-mode . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :ensure t
  :after org-noter
  :config
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))
