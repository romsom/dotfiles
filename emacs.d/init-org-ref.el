(use-package org-ref
  :after helm
  ;; TODO add global bibliography if needed
  ;;:custom
  ;; (bibtex-completion-bibliography "~/Sync/bibliography/references.bib")
  ;; (bibtex-completion-library-path "~/Sync/bibliography/bibtex-pdfs")
  ;; (bibtex-completion-notes-path "~/Sync/bibliography/helm-bibtex-notes")
  )
(use-package doi-utils
  :after org-ref)

(use-package org-ref-pdf
  :after org-ref)

(use-package org-ref-url-utils
  :after org-ref)
