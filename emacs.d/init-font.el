(defun find-font-by-name (name)
  (font-info (font-spec :name name)))
;; get a list of all available fonts with (font-family-list)
(defun get-preferred-font ()
  "Find the first available font from a list of preferred fonts and return it with an appropriate size"
  (let ((fontlist (list
		   (cons "Fira Mono" 100)
		   (cons "monospace" 90)
		   (cons "Ubuntu Mono" 120)
		   (cons "Anonymous Pro" 120)
		   )))
    (while (not (or (not (car fontlist)) (find-font-by-name (car (car fontlist)))))
      (pop fontlist))
    (car fontlist)))

;; set font and size
(let ((found-font (get-preferred-font)))
  (if found-font
      (and (set-face-attribute 'default nil :font (car found-font))
	   (set-face-attribute 'default nil :height (cdr found-font)))))
