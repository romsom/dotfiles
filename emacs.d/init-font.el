(defun find-font-by-name (name)
  (font-info (font-spec :name name)))
;; get a list of all available fonts with (font-family-list)
(defun get-preferred-font ()
  "Find the first available font from a list of preferred fonts and return it with an appropriate size"
  (let ((fontlist '(
		    ("Fira Mono" . 100)
		    ("monospace" . 100)
		    ("Ubuntu Mono" . 110)
		    ("Anonymous Pro" . 120)
		    )))
    (while (not (or (not (car fontlist)) (find-font-by-name (car (car fontlist)))))
      (pop fontlist))
    (car fontlist)))

;; set font and size
(defun reset-font (&optional scaling-factor)
  (let ((found-font (get-preferred-font)))
    (when found-font
      (let ((font-name (car found-font)) (font-size (cdr found-font)))
	(set-face-attribute 'default nil :font font-name :height (if scaling-factor (round (* scaling-factor font-size)) font-size))))))

(defun font-scale-scaling (&optional factor)
  (prog1
      (setq font-scaling-factor
	    (* font-scaling-factor factor))
    (reset-font font-scaling-factor)))

(defun font-increase-scaling ()
  (interactive)
  (font-scale-scaling 1.1))

(defun font-decrease-scaling ()
  (interactive)
  (font-scale-scaling (/ 1.0 1.1)))

(define-key global-map (kbd "C-+") 'font-increase-scaling)
(define-key global-map (kbd "C--") 'font-decrease-scaling)
;;(define-key global-map (kbd "C-=") (lambda () (progn (setq font-scaling-factor 1.0)
						    ;;(reset-font font-scaling-factor))))

;; default font scaling:
(setq font-scaling-factor 1.0)
(reset-font font-scaling-factor)
