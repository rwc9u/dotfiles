;;============================================================
;; Ruby when rails reloaded in use
;; or now when I want to use a newer version
;;============================================================
(require 'enh-ruby-mode)
(require 'inf-ruby)
(require 'ruby-compilation)



;;============================================================
;; Rinari
;;============================================================
(require 'rinari)
(setq rinari-tags-file-name "TAGS")
(global-rinari-mode)



;;============================================================
;; ruby
;;============================================================
(autoload 'enh-ruby-mode "enh-ruby-mode"  "Mode for editing ruby source files" t)

(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("autotest$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("irbrc$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("sake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("god$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("thor$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("jbuilder$" . enh-ruby-mode))


(setq interpreter-mode-alist (append '(("ruby" . enh-ruby-mode))
                                     interpreter-mode-alist))
(add-hook 'enh-ruby-mode-hook 'turn-on-font-lock)


(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)

(add-hook 'enh-ruby-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'compilation-shell-minor-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'compilation-minor-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


(defun ruby-insert-end ()
  "Insert \"end\" at point and reindent current line."
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))


(add-hook 'enh-ruby-mode-hook
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
            (local-set-key [(control c) (control e)] 'ruby-insert-end)
            (local-set-key (kbd "TAB") 'smart-tab)
            (substitute-key-definition 'ruby-electric-brace nil ruby-mode-map)
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
              (setenv "PAGER" (executable-find "cat"))
))


;;============================================================
;; robe
;;============================================================
(autoload 'company-mode "company" nil t)
(company-mode)

(add-to-list 'load-path  (expand-file-name "~/.emacs.d/vendor/robe"))
(autoload 'robe-mode "robe" "\
Improved navigation for Ruby
\(fn &optional ARG)" t nil)
(autoload 'company-robe "robe-company" "\
A `company-mode' completion back-end for `robe-mode'.
\(fn COMMAND &optional ARG)" t nil)
(add-hook 'enh-ruby-mode-hook 'robe-mode)
(push 'company-robe company-backends)
(add-hook 'after-init-hook 'global-company-mode)

;;============================================================
;; rcode tools
;;============================================================
(add-to-list 'load-path  (expand-file-name "~/.emacs.d/rcodetools"))
(require 'rcodetools)

;;============================================================
;; haml templating
;;============================================================
(require 'haml-mode)
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("html\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.hamlbars$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
(add-hook 'haml-mode-hook
          (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (delete-trailing-whitespace)
                           )))
            ))


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

(defun shell-command-on-region-to-string (beg end command)
  (with-output-to-string
    (shell-command-on-region beg end command standard-output)))

(defun hamlify-region ()
  (interactive)
  (kill-new (shell-command-on-region-to-string (region-beginning) (region-end) "html2haml -s --erb")))


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

;;==============================
;; rvm integration
;;==============================
(add-to-list 'load-path  (expand-file-name "~/.emacs.d/vendor/rvm"))
(require 'rvm)
(add-hook 'enh-ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))

;;==============================
;; apidock integration
;; http://simple-and-basic.com/2009/02/emacs-apidock-integration.html
;;==============================
(defun search-apidock-rails ()
  "Search current word in apidock for rails"
  (interactive)
  (let* ((word-at-point (thing-at-point 'symbol))
		(word (read-string "Search apidock for? " word-at-point)))
	(browse-url (concat "http://apidock.com/rails/" word))))

(define-key enh-ruby-mode-map (kbd "C-c d") 'search-apidock-rails)