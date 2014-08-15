;; (add-to-list 'load-path "/Applications/Emacs.app/Contents/Resources/site-lisp/nxhtml/alts")
(add-to-list 'load-path "~/.emacs.d/vendor/js2/build")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq js2-basic-offset 2)
;; (setq js2-use-font-lock-faces t)
(setq js2-highlight-level 3)


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
