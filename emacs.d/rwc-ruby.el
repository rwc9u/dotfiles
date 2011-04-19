;;============================================================
;; Ruby when rails reloaded in use
;; or now when I want to use a newer version
;;============================================================
(add-to-list 'load-path (expand-file-name "~/dev/dotfiles/emacs.d/vendor/ruby-mode/"))
(require 'ruby-mode)
(require 'inf-ruby)
;; (require 'ruby-compilation)



;;============================================================
;; Rinari
;;============================================================
;; this is currently first because it also contains a ruby mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/rinari"))
(require 'rinari)
(setq rinari-tags-file-name "TAGS")




;;============================================================
;; ruby
;;============================================================
;; (add-to-list 'load-path "~/.emacs.d/ruby")
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
;; Rake files are ruby, too, as are gemspecs.
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.autotest$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.sake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(add-hook 'ruby-mode-hook 'turn-on-font-lock)


(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
             ))
(add-hook 'ruby-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'compilation-shell-minor-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'compilation-minor-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; (require 'ruby-electric)

(add-hook 'ruby-mode-hook
          (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
                           )))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (set (make-local-variable 'tab-width) 2)
            (imenu-add-to-menubar "IMENU")
            ;; (require 'ruby-electric)
            ;; (ruby-electric-mode t)
            ))


(defun rails-find-and-goto-error ()
  "Finds error in rails html log go on error line"
  (interactive)
  (search-forward-regexp "RAILS_ROOT: \\([^<]*\\)")
  (let ((rails-root (concat (match-string 1) "/")))
    (search-forward "id=\"Application-Trace\"")
    (search-forward "RAILS_ROOT}")
    (search-forward-regexp "\\([^:]*\\):\\([0-9]+\\)")
    (let  ((file (match-string 1))
           (line (match-string 2)))
                                        ;(kill-buffer (current-buffer))
      (message
       (format "Error found in file \"%s\" on line %s. "  file line))
      (find-file (concat rails-root file))
      (goto-line (string-to-int line)))))

(defun ruby-eval-buffer ()
  "Evaluate the buffer with ruby."
  (interactive)
  (shell-command-on-region (point-min) (point-max) "ruby"))


;; Clear the compilation buffer between test runs.
(eval-after-load 'ruby-compilation
  '(progn
     (defadvice ruby-do-run-w/compilation (before kill-buffer (name cmdlist))
       (let ((comp-buffer-name (format "*%s*" name)))
         (when (get-buffer comp-buffer-name)
           (with-current-buffer comp-buffer-name
             (delete-region (point-min) (point-max))))))
     (ad-activate 'ruby-do-run-w/compilation)))

;;============================================================
;; emacs ri
;;===========================================================
;; (add-to-list 'load-path  (expand-file-name "~/site-lisp/ri-emacs"))
;; (setq ri-ruby-script "/Users/rchristie/site-lisp/ri-emacs/ri-emacs.rb")
;; (setq ri-ruby-program "/opt/local/bin/ruby")
;; (load-file "~/site-lisp/ri-emacs/ri-ruby.el")


(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/ri-emacs"))
(require 'ri)
(setq ri-repl-executable "/Users/rchristie/.emacs.d/vendor/ri-emacs/ri_repl")
;; (setq ri-ruby-script "/Users/rchristie/.emacs.d/vendor/ri-emacs/ri-emacs.rb")
;; (setq ri-ruby-program "/opt/local/bin/ruby")

;; (load-file "~/.emacs.d/vendor/ri-emacs/ri-ruby.el")

;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              (define-key ruby-mode-map [?\C-c ?\C-v ?\C-.]
;;                'ri-ruby-complete-symbol)))
;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              (define-key ruby-mode-map [?\C-c ?\C-v ?\C-w]
;;                'rails-browse-api-at-point)))

;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              (local-set-key "\C-c\C-a" 'ri-ruby-show-args)))


 (add-hook 'inf-ruby-mode-hook
           '(lambda ()
;;               (local-set-key [?\C-c ?\C-v ?\C-.] 'ri-ruby-complete-symbol)
;;               (local-set-key "\C-c\C-a" 'ri-ruby-show-args)
              (local-set-key [(control tab)] 'ido-ruby-complete-or-tab)
              (local-set-key "\C-c\C-c" 'ido-ruby-complete-or-tab)
))

;;============================================================
;; autotest
;;============================================================
(require 'autotest)

;;============================================================
;; rcode tools
;;============================================================
(add-to-list 'load-path  (expand-file-name "~/.emacs.d/rcodetools"))
(require 'rcodetools)

;;============================================================
;; haml templating
;;============================================================
(add-to-list 'load-path  (expand-file-name "~/.emacs.d/haml"))
(require 'haml-mode)
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("html\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

;;============================================================
;; flymake
;;============================================================
;; flymake ruby support 
(require 'flymake)
(add-to-list 'load-path  (expand-file-name "~/.emacs.d/vendor/flymake-ruby"))
(require 'flymake-ruby)
;; (add-hook 'ruby-mode-hook 
;;           '(lambda()
;;              (flymake-ruby-load)
;;              (local-set-key (kbd "\C-c d") 
;;                             'flymake-display-err-menu-for-current-line)
;;              ))
(add-to-list 'load-path  (expand-file-name "~/.emacs.d/vendor/flymake-haml"))
(require 'flymake-haml)
(add-hook 'haml-mode-hook 'flymake-haml-load)
(add-hook 'sass-mode-hook 'flymake-sass-load)

;; thanks to Dmitry Galinsky - this was taken from emacs-rails
;; (defconst flymake-allowed-ruby-file-name-masks
;;   '(("\\.rb\\'"      flymake-ruby-init)
;;     ("\\.rxml\\'"    flymake-ruby-init)
;;     ("\\.builder\\'" flymake-ruby-init)
;;     ("\\.rjs\\'"     flymake-ruby-init))
;;   "Filename extensions that switch on flymake-ruby mode syntax checks.")

;; (defconst flymake-ruby-error-line-pattern-regexp
;;   '("^\\([^:]+\\):\\([0-9]+\\): *\\([\n]+\\)" 1 2 nil 3)
;;   "Regexp matching ruby error messages.")

;; (defun flymake-ruby-init ()
;;   (condition-case er
;;       (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                          'flymake-create-temp-inplace))
;;              (local-file  (file-relative-name
;;                            temp-file
;;                            (file-name-directory buffer-file-name))))
;;         (list "/opt/local/bin/ruby" (list "-c" local-file)))
;;     ('error ())))

;; ;; TODO - pull these out to my rwc-defuns file.
;; (defun strings-join (separator strings)
;;   "Join all STRINGS using a SEPARATOR."
;;   (mapconcat 'identity strings separator))

;; (defalias 'string-join 'strings-join)

;; (defun flymake-ruby-load ()
;;   (when (and (buffer-file-name)
;;              (string-match
;;               (format "\\(%s\\)"
;;                       (string-join
;;                        "\\|"
;;                        (mapcar 'car flymake-allowed-ruby-file-name-masks)))
;;               (buffer-file-name)))
;;     (setq flymake-allowed-file-name-masks
;;           (append flymake-allowed-file-name-masks flymake-allowed-ruby-file-name-masks))
;;     (setq flymake-err-line-patterns
;;           (cons flymake-ruby-error-line-pattern-regexp flymake-err-line-patterns))
;;     (flymake-mode t)
;;     (local-set-key (kbd "\C-c d") 'flymake-display-err-menu-for-current-line)))

;; (when (featurep 'flymake)
;;   (add-hook 'ruby-mode-hook 'flymake-ruby-load))


;;====================
;; my completion code
;;====================
(defun ido-ruby-complete-or-tab (&optional command)
  "Either complete the ruby code at point or call
`indent-for-tab-command' if no completion is available.  Relies
on the irb/completion Module used by readline when running irb
through a terminal."
  (interactive (list (let* ((curr (thing-at-point 'line))
			    (completions (inf-ruby-completions curr)))
		       (case (length completions)
			 (0 nil)
			 (1 (car completions))
			 (t (ido-completing-read "possible completions: " completions nil 'confirm-only curr))))))
  (if (not command)
      (call-interactively 'indent-for-tab-command)
    (move-beginning-of-line 1)
    (kill-line 1)
    (insert command)))

;;==============================
;; rcov integration
;;==============================
(require 'rcov)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/rvm.el"))
(require 'rvm)

