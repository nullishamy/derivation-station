;;; keybinds.el -*- lexical-binding: t; -*-

;; Override default LSP binds with lsp-ui ones
(map! :leader "cD" nil)
(map! :leader "cD" #'lsp-ui-peek-find-references)

;; Jump to start / end of lines
(map! :nvom "H" #'evil-first-non-blank)
(map! :nvom "L" #'evil-last-non-blank)

(provide 'keybinds)
;;; keybinds.el ends here
