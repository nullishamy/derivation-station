;; Configure straight.el settings
(setq straight-enable-use-package-integration t)
(setq straight-use-package-by-default t)

;; Load up my secrets
(defvar secrets-path)
(setq secrets-path (expand-file-name "secrets.el" user-emacs-directory))
;; Only attempt loading if the path actually exists.
;; It may not exist if sops has not yet been loaded.
;; This allows the daemon to launch (albeit with limited features) without crashing
(if (file-exists-p secrets-path)
	(load-file secrets-path))

(setq auth-sources '("~/.authinfo"))
  
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
  "Rebuild and reload the Emacs.org config.
This will **NOT** call init.el again
it will simply compile and source Emacs.org"
  (interactive)
  (org-babel-load-file
   (expand-file-name
	"Emacs.org"
	user-emacs-directory)))

(rebuild-config)
