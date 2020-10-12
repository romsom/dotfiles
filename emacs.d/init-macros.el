(defun mirror-lines-rec (n lines)
  "Recursively remove N lines from buffer and return them as a list in reverse order.
Use LINES as temporary buffer to build the list."

  (if (> n 0)
	  (let ((line (thing-at-point 'line t)))
		(kill-whole-line 1)
		(mirror-lines-rec (- n 1) (cons line lines)))
	  lines))

(defun mirror-lines (n)
  "Mirror the next N lines."
  (interactive "nMirror the next n lines: ")
  (let ((lines (mirror-lines-rec n nil)))
	(apply 'insert lines)
	))
