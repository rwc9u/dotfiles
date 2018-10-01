
(setq auto-mode-alist (delete '("\\.js\\'" . javascript-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))

(setq js2-cleanup-whitespace t)
(setq js2-basic-offset 2)
(setq js2-bounce-indent-p t)

(setq js2-consistent-level-indent-inner-bracket-p t)
(setq js2-use-ast-for-indentation-p t)

;; Warning customizations
(setq js2-strict-inconsistent-return-warning nil)

(add-hook 'js2-mode-hook
          (lambda ()
            (local-set-key (kbd "TAB") 'smart-tab)
            ))


(require 'coffee-mode)

(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

(define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
(define-key coffee-mode-map [(meta R)] 'coffee-compile-region)


(setenv "NODE_NO_READLINE" "1")
