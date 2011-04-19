;; (add-to-list 'load-path "/Applications/Emacs.app/Contents/Resources/site-lisp/nxhtml/alts")
(add-to-list 'load-path "~/.emacs.d/vendor/js2/build")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq js2-basic-offset 2)
;; (setq js2-use-font-lock-faces t)
(setq js2-highlight-level 3)