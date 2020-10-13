(defun find-font-by-name (name)
  (font-info (font-spec :name name)))
;; get a list of all available fonts with (font-family-list)
(defun get-preferred-font ()
  "Find the first available font from a list of preferred fonts and return it with an appropriate size"
  (let ((fontlist
		 '(("Fira Code" . 100)
		   ("Fira Mono" . 100)
		   ("monospace" . 100)
		   ("Ubuntu Mono" . 110)
		   ("Anonymous Pro" . 120)
		   )))
    (while (not (or (not (car fontlist)) (find-font-by-name (car (car fontlist)))))
      (pop fontlist))
    (car fontlist)))

;; set font and size to default values
(defun reset-font (&optional scaling-factor)
  (interactive)
  (let ((found-font (get-preferred-font)))
    (when found-font
      (setq font-preferred-font found-font)
      (if scaling-factor
	  (setq font-scaling-factor scaling-factor)
	(setq font-scaling-factor 1.0))
      (font-apply-font)
      )))

;; apply scaling from font-scaling-factor
(defun font-apply-scaling (&optional scaling-factor)
  (let ((font-size (cdr font-preferred-font)))
    (set-face-attribute 'default nil :height (round (* font-scaling-factor font-size)))))

;; apply font from font-preferred-font and scaling from font-scaling-factor
(defun font-apply-font ()
  (let ((font-name (car font-preferred-font)) (font-size (cdr font-preferred-font)))
    (set-face-attribute 'default nil :font font-name :height (round (* font-scaling-factor font-size)))))

;; scale font-scaling-factor with factor
(defun font-scale-scaling (&optional factor)
  (prog1
      (setq font-scaling-factor
	    (* font-scaling-factor factor))
    (font-apply-scaling)))

(defun font-increase-scaling ()
  (interactive)
  (font-scale-scaling 1.1))

(defun font-decrease-scaling ()
  (interactive)
  (font-scale-scaling (/ 1.0 1.1)))

(define-key global-map (kbd "C-+") 'font-increase-scaling)
(define-key global-map (kbd "C--") 'font-decrease-scaling)
(define-key global-map (kbd "C-=") 'reset-font)

;; default font scaling:
(when (window-system)
  (reset-font))
