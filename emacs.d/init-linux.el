;;; init-linux -- init linux kernel coding options
;;; Commentary:

;;; Code:
;; files in those directories will be handled as linux sources
(setq linux:linux-sources '("/srv/scratch/jo55toko/passt/linux-stable"
			    "~/Repo/Linux"
			    "/srv/scratch/jo55toko/passt/a4/staging"
			    "~/Repo/linux-stable"))

(defun linux:linux-source-p (filename)
  "True if FILENAME is inside one of the paths in linux:linux-sources."
  (and filename
       (seq-reduce
	(lambda (p elt)
	  (or p (string-match (expand-file-name elt) filename)))
	linux:linux-sources nil)))

(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces."
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))
    

(add-hook 'c-mode-common-hook
	  (lambda ()
	    ;; Add kernel style
	    (c-add-style
	     "linux-tabs-only"
	     '("linux" (c-offsets-alist
			(arglist-cont-nonempty
			 c-lineup-gcc-asm-reg
			 c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
	  (lambda ()
	    (let ((filename (buffer-file-name)))
	      ;; Enable kernel mode for the appropriate files
	      (when (linux:linux-source-p filename)
		(print "This file is considered a linux source file.")
		(setq indent-tabs-mode t)
		(setq show-trailing-whitespace t)
		(c-set-style "linux-tabs-only")))))


;; flycheck config
;; see [[https://stackoverflow.com/questions/29709967/using-flycheck-flymake-on-kernel-source-tree]]


(defun linux:flycheck-search-linux-makefile ()
  "Search for linux top `Makefile'."
  (cl-labels
      ((find-makefile-file-r (path)
			     (let* ((parent (file-name-directory path))
				    (file (concat parent "Makefile")))
			       (cond
				((file-exists-p file)
				 (progn
				   (with-temp-buffer
				     (insert-file-contents file)
				     (if (string-match "VERSION = [0-9]+[[:space:]]*PATCHLEVEL" (buffer-string))
					 (throw 'found-it parent)
				       (find-makefile-file-r (directory-file-name parent))
				       ))))
				((equal path parent) (throw 'found-it nil))
				(t (find-makefile-file-r (directory-file-name parent)))))))
    (if (buffer-file-name)
        (catch 'found-it
          (find-makefile-file-r (buffer-file-name)))
      (error "Buffer is not visiting a file"))))

(flycheck-define-checker linux:flycheck-linux-makefile-checker
  "Linux source checker"
  :command
  (
   "make" "C=1" "-C" (eval (linux:flycheck-search-linux-makefile))
   (eval (concat (file-name-sans-extension (file-relative-name buffer-file-name (linux:flycheck-search-linux-makefile))) ".o"))
   )
  :error-patterns
  ((error line-start
          (message "In file included from") " " (file-name) ":" line ":"
          column ":"
	  line-end)
   (info line-start (file-name) ":" line ":" column
         ": note: " (message) line-end)
   (warning line-start (file-name) ":" line ":" column
            ": warning: " (message) line-end)
   (error line-start (file-name) ":" line ":" column
          ": " (or "fatal error" "error") ": " (message) line-end))
  :error-filter
  (lambda (errors)
    (let ((errors (flycheck-sanitize-errors errors)))
      (dolist (err errors)
        (let* ((fn (flycheck-error-filename err))
               (rn0 (file-relative-name fn default-directory)) ; flycheck-fix-error-filename converted to absolute, revert
               (rn1 (expand-file-name rn0 (linux:flycheck-search-linux-makefile))) ; make absolute relative to "make -C dir"
               (ef (file-relative-name rn1 default-directory)) ; relative to source
               )
          (setf (flycheck-error-filename err) ef)
          )))
    errors)
  :modes (c-mode c++-mode)
  )

(defun linux:flycheck-mode-hook ()
  "Flycheck mode hook."
  (let ((filename (buffer-file-name)))
    (when (linux:linux-source-p filename)
      (make-variable-buffer-local 'flycheck-linux-makefile)
      (setq flycheck-linux-makefile (linux:flycheck-search-linux-makefile))
      (if flycheck-linux-makefile
	  (flycheck-select-checker 'linux:flycheck-linux-makefile-checker)))))

(add-hook 'flycheck-mode-hook 'linux:flycheck-mode-hook)
;;; foo
