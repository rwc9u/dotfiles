
(autoload 'js3-mode "js3" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))

;; (mode-to-list 'auto-mode-alist '("\\.js\\" . js3-mode))
;; (add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js3-mode))
;; (add-to-list 'auto-mode-alist '("\\.json\\" . js3-mode))
;; (add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(setf (cdr (rassoc 'javascript-mode auto-mode-alist)) 'js3-mode)

;; (setq js2-basic-offset 2)
;; (setq js2-use-font-lock-faces t)
;; (setq js2-highlight-level 3)
(custom-set-variables
 '(js3-lazy-commas t)
 '(js3-lazy-operators t)
 ;; '(js3-pretty-vars-spaces 2)
 ;; '(js3-continued-expr-mult 1)
 '(js3-expr-indent-offset 2)
 '(js3-paren-indent-offset 2)
 '(js3-square-indent-offset 2)
 '(js3-curly-indent-offset 0)  ;; this seems to fix indentation within functions for me
 )



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
