(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'scss-mode-hook 'flycheck-mode)


(flycheck-def-config-file-var flycheck-haml-lintrc haml-lint ".haml-lint.yml"
  :safe #'stringp)

(flycheck-define-checker haml-lint
  "A haml-lint syntax checker"
  :command ("haml-lint"
            (config-file "--config" flycheck-haml-lintrc)
            source)
  :error-patterns
  ((warning line-start
            (file-name) ":" line " [W] "  (message)
            line-end))
  :modes (haml-mode))
