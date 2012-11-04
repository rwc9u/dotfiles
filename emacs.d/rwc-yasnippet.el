;; (add-to-list 'load-path "~/.emacs.d/yasnippet")
;; (add-to-list 'load-path "~/dev/yasnippet")
(add-to-list 'load-path "~/dev/vendor/yasnippet-read-only")
(require 'yasnippet)
(require 'dropdown-list)
(setq yas/prompt-functions '( yas/dropdown-prompt
                              yas/ido-prompt
                              yas/completing-prompt))
(yas/initialize)

;; (yas/load-directory "~/.emacs.d/yasnippet/snippets")
;; (yas/load-directory "~/.emacs.d/yasnippet/extras/imported")
(yas/load-directory "~/dev/yasnippet/extras/imported/LaTeX-mode")
(yas/load-directory "~/dev/yasnippet/extras/imported/c-mode")
(yas/load-directory "~/dev/yasnippet/extras/imported/css-mode")
(yas/load-directory "~/dev/yasnippet/extras/imported/html-mode")
(yas/load-directory "~/dev/yasnippet/extras/imported/lisp-mode")
(yas/load-directory "~/dev/yasnippet/extras/imported/markdown-mode")
(yas/load-directory "~/dev/yasnippet/extras/imported/shell-script-mode")
(yas/load-directory "~/dev/yasnippet/extras/imported/text-mode")
(yas/load-directory "~/dev/yasnippet/extras/imported/yaml-mode")
(yas/load-directory "~/dev/yasnippet/snippets/snippet-mode") 
;; (load "~/dev/yasnippets-ruby/setup.el")  ;; used by ruby snippets
;; (yas/load-directory "~/dev/yasnippets-ruby")
(load "~/dev/yasnippet/extras/imported/ruby-mode/.yas-setup.el")
(yas/load-directory "~/dev/yasnippet/extras/imported/ruby-mode")
;; (yas/load-directory "~/dev/yasnippet/extras/imported/rails-mode")
(yas/load-directory "~/.emacs.d/yasnippets-shoulda")
(yas/load-directory "~/.emacs.d/vendor/yasnippets-rspec/rspec-snippets")
(yas/load-directory "~/dev/yasnippets-rails/rails-mode")
(load "~/dev/yasnippets-rails/rails-mode/.yas-setup.el")

(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers 

;; Removed and relying on yasnippet to enable my indent or expand
;; Hippie expand.  Groovy vans with tie-dyes.
;; (add-to-list 'hippie-expand-try-functions-list 'yas/hippie-try-expand)
;; Replace yasnippets's TAB
;; (add-hook 'yas/minor-mode-hook
;;           (lambda () (define-key yas/minor-mode-map
;;                        (kbd "TAB") 'indent-or-expand))) ; was yas/expand

;; Replace yasnippets's TAB
(add-hook 'yas/minor-mode-hook
          (lambda () (define-key yas/minor-mode-map
                       (kbd "TAB") 'smart-tab))) ; was yas/expand



;; may need this
;; (if (boundp 'mumamo:version)
;;     ((setq mumamo-map
;; (let ((map (make-sparse-keymap)))
;; (define-key map [(control meta prior)] 'mumamo-backward-chunk)
;; (define-key map [(control meta next)] 'mumamo-forward-chunk)
;; (define-key map [tab] 'yas/expand)
;; map))
;;      (mumamo-add-multi-keymap 'mumamo-multi-major-mode mumamo-map)))
 


(defun yas/advise-indent-function (function-symbol)
  (eval `(defadvice ,function-symbol (around yas/try-expand-first activate)
           ,(format
             "Try to expand a snippet before point, then call `%s' as usual"
             function-symbol)
           (let ((yas/fallback-behavior nil))
             (unless (and (interactive-p)
                          (yas/expand))
               ad-do-it)))))

(yas/advise-indent-function 'ruby-indent-line)

(defvar flymake-is-active-flag nil)

;; (defadvice yas/expand-snippet (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
;;   (setq flymake-is-active-flag
;;         (member '(flymake-mode . t) (buffer-local-variables)))
;;   (when flymake-is-active-flag
;;     (flymake-mode-off)))

;; (add-hook 'yas/after-exit-snippet-hook
;;           '(lambda ()
;;              (when flymake-is-active-flag
;;                (flymake-mode-on)))) 
