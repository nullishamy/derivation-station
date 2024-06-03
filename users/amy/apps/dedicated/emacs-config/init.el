(defun rebuild-config ()
  (interactive) 
  (org-babel-load-file
   (expand-file-name
	"Emacs.org"
	user-emacs-directory)))

(rebuild-config)
