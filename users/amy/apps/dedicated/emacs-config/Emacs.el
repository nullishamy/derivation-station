;; Load use-package through straight
(straight-use-package 'use-package)

(setq visible-bell 1)
(setq x-super-keysym 'meta)
(setq inhibit-startup-message t)
(setq gc-cons-threshold (* 50 1000 1000))

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(defalias 'ssh-init 'exec-path-from-shell-initialize)

(use-package exec-path-from-shell
  :config
  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "NIX_PATH"))
	(add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

(use-package no-littering
  :config
  (setq no-littering-etc-directory (expand-file-name "config/" user-emacs-directory))
  (setq no-littering-var-directory (expand-file-name "data/" user-emacs-directory)))

(use-package emacs
  :custom
  (menu-bar-mode nil)         ;; Disable the menu bar
  (scroll-bar-mode nil)       ;; Disable the scroll bar
  (tool-bar-mode nil)         ;; Disable the tool bar
  ;;(inhibit-startup-screen t)  ;; Disable welcome screen
  (tooltip-mode -1)           ; Disable tooltips
  (set-fringe-mode 10)        ; Give some breathing room
  (toggle-frame-maximized)    ; Always start maximized

  (delete-selection-mode t)   ;; Select text and delete it by typing.
  (electric-indent-mode t)    ;; Turn off the weird indenting that Emacs does by default.
  (electric-pair-mode t)      ;; Turns on automatic parens pairing

  (blink-cursor-mode nil)     ;; Don't blink cursor
 
  (global-auto-revert-mode t) ;; Automatically reload file and show changes if the file has changed

  (pixel-scroll-precision-mode 1)

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
  
  (setq compilation-scroll-output t) ;; Make compilation mode scroll automatically
  (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

  :bind
  (([escape] . keyboard-escape-quit)) ;; Makes Escape quit prompts (Minibuffer Escape)
)

(use-package wakatime-mode
  :init (global-wakatime-mode))

(use-package diff-hl
  :hook ((dired-mode         . diff-hl-dired-mode-unless-remote)
  		 (magit-pre-refresh  . diff-hl-magit-pre-refresh)
  		 (magit-post-refresh . diff-hl-magit-post-refresh))
  :init (global-diff-hl-mode))

(use-package diminish)

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode)
  (org-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :config
  ;; Make it a proper global mode; we want this everywhere unless we explicitly disable it (TODO: Add blocklist filtering here)
  (define-globalized-minor-mode global-rainbow-mode rainbow-mode
    (lambda () (rainbow-mode 1)))
  (global-rainbow-mode 1))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-icon nil)
  (setq doom-modeline-minor-modes t)
  (setq doom-modeline-buffer-file-name-style 'relative-from-project))

(use-package magit
  :commands magit-status)

(use-package forge
  :after magit)

(use-package git-gutter
  :config
  (global-git-gutter-mode 't))

(use-package dtrt-indent
  :custom
  (dtrt-indent-global-mode t))

;; General keybindings
(global-set-key (kbd "C-x C-b") 'ibuffer)

(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm))

(add-to-list 'default-frame-alist '(alpha-background . 90)) ;; For all new frames henceforth

(setq sfont "Victor Mono Medium")
(set-face-attribute 'default nil
  :font sfont
  :height 200
  :weight 'medium)

(set-frame-font sfont nil t)
(add-to-list 'default-frame-alist '(font . "Victor Mono Medium"))

(use-package ligature
  :config
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  (global-ligature-mode t))

(setq-default line-spacing 0.12)

(use-package emacs
  :bind
  ("<C-wheel-up>" . text-scale-increase)
  ("<C-wheel-down>" . text-scale-decrease))

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after yasnippet)

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
  (direnv-mode)
  (setq direnv-always-show-summary nil))

(use-package expand-region
  :config
  (global-set-key (kbd "C-x e") 'er/expand-region))

(defun indent-region-advice (&rest ignored)
  (let ((deactivate deactivate-mark))
	(if (region-active-p)
		(indent-region (region-beginning) (region-end))
      (indent-region (line-beginning-position) (line-end-position)))
	(setq deactivate-mark deactivate)))

(use-package move-text
  :config
  (move-text-default-bindings)
  (advice-add 'move-text-down :after 'indent-region-advice)
  (advice-add 'move-text-up :after 'indent-region-advice))

(use-package projectile
 :custom
 (projectile-run-use-comint-mode t) ;; Interactive run dialog when running projects inside emacs (like giving input)
 (projectile-switch-project-action #'projectile-dired) ;; Open dired when switching to a project
 (projectile-project-search-path '("~/code")) ;;
 :config
 (projectile-mode)
 (setq projectile-use-git-grep t)
 (define-key projectile-mode-map (kbd "M-p") 'projectile-command-map))

(use-package multiple-cursors
  :config
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this))

(use-package beacon
  :config
  (beacon-mode 1))

(use-package goto-line-preview
  :config
  (global-set-key [remap goto-line] 'goto-line-preview))

(use-package anzu
:config
(global-anzu-mode +1)
(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp))

;; Additional language modes
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package zig-mode
  :mode "\\.zig\\'")

(use-package go-mode
  :mode ("\\.go\\'"))

(use-package rust-mode
  :mode ("\\.rs\\'" . rust-mode))

(use-package svelte-mode
  :mode ("\\.svelte\\'" . svelte-mode))

(use-package lsp-tailwindcss
  :init
  (setq lsp-tailwindcss-add-on-mode t))

(use-package tide
  :hook ((typescript-ts-mode . tide-setup)
         (tsx-ts-mode . tide-setup)
         (typescript-ts-mode . tide-hl-identifier-mode))
  :mode ("\\.tsx?\\'" . typescript-ts-mode))

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :mode ("\\.md\\'" . markdown-mode))

(use-package yaml-pro
  :mode ("\\.ya?ml\\'" . yaml-pro-mode))

(use-package yaml-mode
  :mode ("\\.ya?ml\\'" . yaml-mode))

(add-hook 'yaml-mode-hook (lambda () (tree-sitter-hl-mode)))

;; Filetype -> mode mappings
(setq auto-mode-alist
	  (append
		 ;; File name (within directory) starts with a dot.
	   '(("/\\.[^/]*\\'" . fundamental-mode)
		 (".*git-rebase-todo" . git-rebase-mode)
		 (".*COMMIT_EDITMSG" . git-rebase-mode)
		 ;; File name has no dot.
		 ("/[^\\./]*\\'" . fundamental-mode)
		 ;; File name ends in ‘.el’.
		 ("\\.el\\'" . emacs-lisp-mode)
		 ("\\.zig\\'" . zig-mode))
	   auto-mode-alist))

;; Treesitter is provided by Nix because of the natively compiled stuff
;; and we are using the Emacs builtin treesitter module which has its own language modes
;; <lang>-ts-mode

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
  (corfu-auto-prefix 1)          ;; Minimum length of prefix for auto completion.
  (corfu-popupinfo-mode t)       ;; Enable popup information
  (corfu-popupinfo-delay 0.5)    ;; Lower popupinfo delay to 0.5 seconds from 2 seconds
  (corfu-separator ?\s)          ;; Orderless field separator, Use M-SPC to enter separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  (corfu-preview-current t)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  (corfu-on-exact-match 'show)     ;; Configure handling of exact matches
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

(use-package prescient
  :after corfu
  :config
  (setq corfu-prescient-enable-filtering t)
  (setq corfu-prescient-override-sorting t)
  (setq completion-preview-sort-function #'prescient-completion-sort)
  (setq prescient-filter-method '(literal fuzzy prefix)))

(use-package corfu-prescient
  :after prescient
  :init
  (corfu-prescient-mode 1))

(defun cape-dabbrev-dict-keyword ()
  (cape-wrap-super
   (cape-capf-case-fold #'cape-dabbrev)
   (cape-capf-case-fold #'cape-keyword)
   (cape-capf-case-fold #'yasnippet-capf)))

(use-package cape
  :after corfu
  :config
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  ;; The functions that are added later will be the first in the list

  (add-to-list 'completion-at-point-functions #'cape-dabbrev-dict-keyword) ;; Combine all of these together
  (add-to-list 'completion-at-point-functions #'cape-file) ;; Path completion
  (add-to-list 'completion-at-point-functions #'cape-elisp-block) ;; Complete elisp in Org or Markdown mode
  
  (keymap-global-set "M-TAB" 'completion-at-point))

(use-package yasnippet-capf)

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

(use-package all-the-icons
  :if (display-graphic-p))

(use-package nerd-icons-dired
  :hook (dired-mode . (lambda () (nerd-icons-dired-mode t))))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))
