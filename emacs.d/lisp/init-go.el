(setq lsp-gopls-staticcheck t)
(setq lsp-eldoc-render-all t)
(setq lsp-gopls-complete-unimported t)
(add-hook 'go-mode-hook
          (lambda ()
            (flycheck-select-checker 'go-golint)
            (setq flycheck-disabled-checkers '(go-build go-vet))))
;; (let ((govet (flycheck-checker-get 'go-vet 'command)))
;;   (when (equal (cadr govet) "tool")
;;     (setf (cdr govet) (cddr govet))))
(provide 'init-go)
