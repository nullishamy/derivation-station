;; Configure straight.el settings
(setq straight-enable-use-package-integration t)
(setq straight-use-package-by-default t)
  
;; Bootstrap straight
(defvar bootstrap-version)
(let ((bootstrap-file
	   (expand-file-name
		"straight/repos/straight.el/bootstrap.el"
		(or (bound-and-true-p straight-base-dir)
			user-emacs-directory)))
	  (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
	(with-current-buffer
		(url-retrieve-synchronously
		 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
		 'silent 'inhibit-cookies)
	  (goto-char (point-max))
	  (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'org)

(defun rebuild-config ()
  (interactive) 
  (org-babel-load-file
   (expand-file-name
	"Emacs.org"
	user-emacs-directory)))

(rebuild-config)
