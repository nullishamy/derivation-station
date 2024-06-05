;; Load use-package through straight
(straight-use-package 'use-package)

(setq visible-bell 1)
(setq x-super-keysym 'meta)
(setq inhibit-startup-message t)
(setq gc-cons-threshold (* 50 1000 1000))

(use-package emacs
	:custom
	(menu-bar-mode nil)         ;; Disable the menu bar
	(scroll-bar-mode nil)       ;; Disable the scroll bar
	(tool-bar-mode nil)         ;; Disable the tool bar
	;;(inhibit-startup-screen t)  ;; Disable welcome screen

	(delete-selection-mode t)   ;; Select text and delete it by typing.
	(electric-indent-mode nil)  ;; Turn off the weird indenting that Emacs does by default.
	(electric-pair-mode t)      ;; Turns on automatic parens pairing

	(blink-cursor-mode nil)     ;; Don't blink cursor
	(global-auto-revert-mode t) ;; Automatically reload file and show changes if the file has changed

	;;(dired-kill-when-opening-new-dired-buffer t) ;; Dired don't create new buffer
	;;(recentf-mode t) ;; Enable recent file mode

	;;(global-visual-line-mode t)           ;; Enable truncated lines
	;;(display-line-numbers-type 'relative) ;; Relative line numbers
	(global-display-line-numbers-mode t)  ;; Display line numbers

	(mouse-wheel-progressive-speed nil) ;; Disable progressive speed when scrolling
	(scroll-conservatively 10) ;; Smooth scrolling
	;;(scroll-margin 8)

	(tab-width 4)

	(make-backup-files nil) ;; Stop creating ~ backup files
	(auto-save-default nil) ;; Stop creating # auto save files
	:hook
	(prog-mode . (lambda () (hs-minor-mode t))) ;; Enable folding hide/show globally
	:config
	;; Move customization variables to a separate file and load it, avoid filling up init.el with unnecessary variables
	(setq custom-file (locate-user-emacs-file "custom-vars.el"))
	(load custom-file 'noerror 'nomessage)
	:bind (
		   ([escape] . keyboard-escape-quit) ;; Makes Escape quit prompts (Minibuffer Escape)
		   )
	)

(use-package diff-hl
	:hook ((dired-mode         . diff-hl-dired-mode-unless-remote)
		   (magit-pre-refresh  . diff-hl-magit-pre-refresh)
		   (magit-post-refresh . diff-hl-magit-post-refresh))
	:init (global-diff-hl-mode))

(use-package diminish)

(use-package rainbow-delimiters
	:hook (prog-mode . rainbow-delimiters-mode))
(use-package rainbow-mode
	:config
	;; Make it a proper global mode; we want this everywhere unless we explicitly disable it (TODO: Add blocklist filtering here)
	(define-globalized-minor-mode global-rainbow-mode rainbow-mode
	  (lambda () (rainbow-mode 1)))
	(global-rainbow-mode 1))

(use-package catppuccin-theme
	:config
	(load-theme 'catppuccin :no-confirm))

(add-to-list 'default-frame-alist '(alpha-background . 90)) ;; For all new frames henceforth

(set-face-attribute 'default nil
					:font "Iosevka Term" ;; Set your favorite type of font or download JetBrains Mono
					:height 150
					:weight 'medium)

(set-frame-font "Iosevka Term" nil t)
;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.

;;(add-to-list 'default-frame-alist '(font . "JetBrains Mono")) ;; Set your favorite font
(setq-default line-spacing 0.12)
(use-package emacs
	:bind
	("C-+" . text-scale-increase)
	("C--" . text-scale-decrease)
	("<C-wheel-up>" . text-scale-increase)
	("<C-wheel-down>" . text-scale-decrease))

(use-package hl-todo
	:config
	
	;; PERF: Fully optimised
	;; HACK: Hmm, this looks cursed
	;; TODO: What else?
	;; NOTE: Write that down, write that down!
	;; FIX:  Oh no

	;; Only highlight on KEYWORD: constructs, avoids highlighting random things
	;; in strings and code. My personal preference
	(setq hl-todo-require-punctuation t)
	(setq hl-todo-highlight-punctuation ":")

	(setq hl-todo-keyword-faces
		'(("PERF"   . hl-todo-PERF)
		  ("HACK"   . hl-todo-HACK)
          ("TODO"  . hl-todo-TODO)
          ("NOTE"  . hl-todo-NOTE)
		  ("FIX"  . hl-todo-FIX)
          ("FIXME"  . hl-todo-FIX)
          ("BUG"  . hl-todo-FIX))))

	(global-hl-todo-mode 1)

(defface hl-todo-PERF
	'((t :background "#cba6f7" :foreground "#11111b" :inherit (hl-todo)))
	"Face for highlighting the PERF keyword.")

(defface hl-todo-HACK
	'((t :background "#f9e2af" :foreground "#11111b" :inherit (hl-todo)))
	"Face for highlighting the HACK keyword.")

(defface hl-todo-TODO
	'((t :background "#89b4fa" :foreground "#11111b" :inherit (hl-todo)))
	"Face for highlighting the TODO keyword.")

(defface hl-todo-NOTE
	'((t :background "#a6e3a1" :foreground "#11111b" :inherit (hl-todo)))
	"Face for highlighting the NOTE keyword.")

(defface hl-todo-FIX
	'((t :background "#f38ba8" :foreground "#11111b" :inherit (hl-todo)))
	"Face for highlighting the FIX keyword.")

(use-package which-key
	:init
	(which-key-mode 1)
	:diminish
	:custom
	(which-key-side-window-location 'bottom)
	(which-key-sort-order #'which-key-key-order-alpha) ;; Same as default, except single characters are sorted alphabetically
	(which-key-sort-uppercase-first nil)
	(which-key-add-column-padding 1) ;; Number of spaces to add to the left of each column
	(which-key-min-display-lines 6)  ;; Increase the minimum lines to display, because the default is only 1
	(which-key-idle-delay 0.8)       ;; Set the time delay (in seconds) for the which-key popup to appear
	(which-key-max-description-length 25)
	(which-key-allow-imprecise-window-fit nil)) ;; Fixes which-key window slipping out in Emacs Daemon

(use-package direnv
 :config
 (direnv-mode))

(use-package expand-region
 :config
 (global-set-key (kbd "C-x e") 'er/expand-region))

(use-package projectile
 :custom
 (projectile-run-use-comint-mode t) ;; Interactive run dialog when running projects inside emacs (like giving input)
 (projectile-switch-project-action #'projectile-dired) ;; Open dired when switching to a project
 (projectile-project-search-path '("~/code")) ;;
 :config
 (projectile-mode)
 (define-key projectile-mode-map (kbd "M-p") 'projectile-command-map))

(use-package lsp-mode
	:config
	(setq lsp-keymap-prefix "C-c l")
	(setq lsp-completion-enable nil)
	(setq lsp-completion-provider :capf)
	:hook (
		   (python-mode . lsp)
		   (rust-mode . lsp)
		   (svelte-mode . lsp)
		   (go-mode . lsp)
		   (nix-mode . lsp)
		   (lsp-mode . lsp-enable-which-key-integration))
	:commands lsp)

(use-package lsp-ui
	:commands
	lsp-ui-mode
	:config
	(setq lsp-ui-doc-position 'at-point)
	(setq lsp-ui-doc-delay 1.5)
	(keymap-global-set "C-c d s" 'lsp-ui-doc-show)
	(keymap-global-set "C-c d f" 'lsp-ui-doc-focus-frame)
	(keymap-global-set "C-c d h" 'lsp-ui-doc-hide)
	(setq lsp-ui-doc-enable t))

;; Filetype -> mode mappings
(setq auto-mode-alist
		(append
		 ;; File name (within directory) starts with a dot.
		 '(("/\\.[^/]*\\'" . fundamental-mode)
		   ;; File name has no dot.
		   ("/[^\\./]*\\'" . fundamental-mode)
		   ;; File name ends in ‘.el’.
		   ("\\.el\\'" . emacs-lisp-mode))
		 auto-mode-alist))

;; Additional language modes
(use-package nix-mode
	:mode "\\.nix\\'")

(use-package go-mode
	:mode ("\\.go\\'" . go-mode))

(use-package rust-mode
	:mode ("\\.rs\\'" . rust-mode))

(use-package svelte-mode
	:mode ("\\.svelte\\'" . svelte-mode))

(use-package lsp-tailwindcss
	:init
	(setq lsp-tailwindcss-add-on-mode t))

(use-package typescript-mode
	:mode ("\\.tsx?\\'" . typescript-mode))

(use-package markdown-mode
	:mode ("\\.md\\'" . markdown-mode))

;; In-buffer checking
(use-package flycheck
	:config
	(add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-inline
	:config
	(with-eval-after-load 'flycheck
	  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode)))

(use-package toc-org
	:commands toc-org-enable
	:hook (org-mode . toc-org-mode))

(use-package org-superstar
	:hook (org-mode . org-superstar-mode))

;; https://www.masteringemacs.org/article/introduction-to-ido-mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-completing-read+
	:config
	(ido-ubiquitous-mode 1))


(savehist-mode) ;; Enables save history mode

(use-package corfu
	:custom
	(corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
	(corfu-auto t)                 ;; Enable auto completion
	(corfu-auto-prefix 2)          ;; Minimum length of prefix for auto completion.
	(corfu-popupinfo-mode t)       ;; Enable popup information
	(corfu-popupinfo-delay 0.5)    ;; Lower popupinfo delay to 0.5 seconds from 2 seconds
	(corfu-separator ?\s)          ;; Orderless field separator, Use M-SPC to enter separator
	;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
	;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
	(corfu-preview-current t)    ;; Disable current candidate preview
	;; (corfu-preselect 'prompt)      ;; Preselect the prompt
	;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
	;; (corfu-scroll-margin 5)        ;; Use scroll margin
	(completion-ignore-case t)
	;; Enable indentation+completion using the TAB key.
	;; `completion-at-point' is often bound to M-TAB.
	(tab-always-indent 'complete)
	(corfu-preview-current nil) ;; Don't insert completion without confirmation
	;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
	;; be used globally (M-/).  See also the customization variable
	;; `global-corfu-modes' to exclude certain modes.
	:init
	(global-corfu-mode))

(use-package cape
	:after corfu
	:init
	;; Add to the global default value of `completion-at-point-functions' which is
	;; used by `completion-at-point'.  The order of the functions matters, the
	;; first function returning a result wins.  Note that the list of buffer-local
	;; completion functions takes precedence over the global list.
	;; The functions that are added later will be the first in the list
	
	(add-to-list 'completion-at-point-functions #'cape-dabbrev) ;; Complete word from current buffers
	(add-to-list 'completion-at-point-functions #'cape-dict) ;; Dictionary completion
	(add-to-list 'completion-at-point-functions #'cape-file) ;; Path completion
	(add-to-list 'completion-at-point-functions #'cape-elisp-block) ;; Complete elisp in Org or Markdown mode
	(add-to-list 'completion-at-point-functions #'cape-keyword) ;; Keyword/Snipet completion

	(keymap-global-set "M-TAB" 'completion-at-point)
	;;(add-to-list 'completion-at-point-functions #'cape-abbrev) ;; Complete abbreviation
	;;(add-to-list 'completion-at-point-functions #'cape-history) ;; Complete from Eshell, Comint or minibuffer history
	;;(add-to-list 'completion-at-point-functions #'cape-line) ;; Complete entire line from current buffer
	;;(add-to-list 'completion-at-point-functions #'cape-elisp-symbol) ;; Complete Elisp symbol
	;;(add-to-list 'completion-at-point-functions #'cape-tex) ;; Complete Unicode char from TeX command, e.g. \hbar
	;;(add-to-list 'completion-at-point-functions #'cape-sgml) ;; Complete Unicode char from SGML entity, e.g., &alpha
	;;(add-to-list 'completion-at-point-functions #'cape-rfc1345) ;; Complete Unicode char using RFC 1345 mnemonics
	)

(defun elcord--enable-on-frame-created (f)
	(elcord-mode +1))

(defun elcord--disable-elcord-if-no-frames (f)
	(when (let ((frames (delete f (visible-frame-list))))
		  (or (null frames)
			  (and (null (cdr frames))
				   (eq (car frames) terminal-frame))))
	  (elcord-mode -1)
	  (add-hook 'after-make-frame-functions 'elcord--enable-on-frame-created)))

(defun custom-elcord-mode-hook ()
	(if elcord-mode
		(add-hook 'delete-frame-functions 'elcord--disable-elcord-if-no-frames)
	  (remove-hook 'delete-frame-functions 'elcord--disable-elcord-if-no-frames)))

(use-package elcord
	:config
	(add-hook 'elcord-mode-hook 'custom-elcord-mode-hook)
	(elcord-mode)
	(setq elcord-quiet t)
	(setq elcord-idle-message "AFK.."))

(use-package nerd-icons-completion
	:config
	(nerd-icons-completion-mode))

(use-package nerd-icons-corfu
	:after corfu
	:init (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons
	:if (display-graphic-p))

(use-package nerd-icons-dired
	:hook (dired-mode . (lambda () (nerd-icons-dired-mode t))))

(use-package nerd-icons-ibuffer
	:hook (ibuffer-mode . nerd-icons-ibuffer-mode))
