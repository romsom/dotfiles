(use-package org-ref
  :ensure t
  :after helm
  ;; TODO add global bibliography if needed
  :custom
  ;; Config from README
  (reftex-default-bibliography '("~/Repo/BAi4/ba-thesis/bibliography.bib"))
  (org-ref-default-bibliography '("~/Repo/BAi4/ba-thesis/bibliography.bib"))
  (org-ref-pdf-directory "~/Repo/BAi4/ba-thesis/literature/")
  (org-ref-bibliography-notes "~/Repo/BAi4/ba-thesis/references.org")
  ;; Config for helm
  (bibtex-completion-bibliography "~/Repo/BAi4/ba-thesis/bibliography.bib")
  ;; (bibtex-completion-bibliography "~/Sync/bibliography/references.bib")
  (bibtex-completion-library-path "~/~/Repo/BAi4/ba-thesis/literature/")
  (bibtex-completion-notes-path "~/Repo/BAi4/ba-thesis/references.org")
  :config
  (setq org-ref-default-ref-type "cref")
  )
(use-package doi-utils
  :after org-ref)

(use-package org-ref-pdf
  :after org-ref)

(use-package org-ref-url-utils
  :after org-ref)
