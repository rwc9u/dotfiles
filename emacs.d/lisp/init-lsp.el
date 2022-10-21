(setq lsp-keymap-prefix "C-c l")
(require 'lsp-mode)
(add-hook 'ruby-mode-hook #'lsp)

(provide 'init-lsp)

;; (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
