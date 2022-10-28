;;============================================================
;; Ruby when rails reloaded in use
;; or now when I want to use a newer version
;;============================================================
(require 'ruby-mode)
(require 'inf-ruby)
(require 'ruby-compilation)


;;============================================================
;; ruby
;;============================================================
(autoload 'ruby-mode "ruby-mode"  "Mode for editing ruby source files" t)

(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("irbrc$" . ruby-mode))
(add-to-list 'auto-mode-alist '("sake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("god$" . ruby-mode))
(add-to-list 'auto-mode-alist '("thor$" . ruby-mode))
(add-to-list 'auto-mode-alist '("gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("jbuilder$" . ruby-mode))


(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(add-hook 'ruby-mode-hook 'turn-on-font-lock)


(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

(add-hook 'ruby-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'compilation-shell-minor-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'compilation-minor-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; turn off adding of magic comment
(setq ruby-insert-encoding-magic-comment nil)

;;============================================================
;; Rinari
;;============================================================
;; (require 'rinari)
;; (setq rinari-tags-file-name "TAGS")
;; (global-rinari-mode)

;; (add-hook 'projectile-mode-hook 'projectile-rails-on)
(projectile-rails-global-mode)


(defun ruby-insert-end ()
  "Insert \"end\" at point and reindent current line."
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))


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
            (local-set-key [(control c) (control e)] 'ruby-insert-end)
            (local-set-key [(control c) (.)] 'xref-find-definitions)
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


 (add-hook 'inf-ruby-mode-hook
           '(lambda ()
              (local-set-key [(control tab)] 'ido-ruby-complete-or-tab)
              (local-set-key "\C-c\C-c" 'ido-ruby-complete-or-tab)
              (setenv "PAGER" (executable-find "cat"))
))


;;============================================================
;; robe
;;============================================================
(autoload 'company-mode "company" nil t)
(company-mode)

(autoload 'robe-mode "robe" "\
Improved navigation for Ruby
\(fn &optional ARG)" t nil)
;; (autoload 'company-robe "robe-company" "\
;; A `company-mode' completion back-end for `robe-mode'.
;; \(fn COMMAND &optional ARG)" t nil)
(add-hook 'ruby-mode-hook 'robe-mode)
(eval-after-load 'company
  '(push 'company-robe company-backends))
(add-hook 'after-init-hook 'global-company-mode)

(with-eval-after-load 'company
 (define-key company-active-map (kbd "TAB") #'company-complete-common-or-cycle)
 (define-key company-active-map (kbd "<backtab>") (lambda () (interactive) (company-complete-common-or-cycle -1))))

;; ;;============================================================
;; ;; rcode tools
;; ;;============================================================
;; ;; commented out because it was slowing down ruby file load
;; ;; (add-to-list 'load-path  (expand-file-name "~/.emacs.d/rcodetools"))
;; ;; (require 'rcodetools)

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




(defun shell-command-on-region-to-string (beg end command)
  (with-output-to-string
    (shell-command-on-region beg end command standard-output)))

(defun hamlify-region ()
  (interactive)
  (kill-new (shell-command-on-region-to-string (region-beginning) (region-end) "html2haml -s --erb")))


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

;; ;;==============================
;; ;; rcov integration
;; ;;==============================
;; (require 'rcov)

;;==============================
;; rvm integration
;;==============================
(require 'rvm)
;; this seems to be slowing down ruby file opening
(add-hook 'ruby-mode-hook
           (lambda () (rvm-activate-corresponding-ruby)))

;;==============================
;; ruby tools
;;==============================
(require 'ruby-tools)

;;==============================
;; testing web-mode
''==============================
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-indent-style 2)

;;==============================
;; apidock integration
;; http://simple-and-basic.com/2009/02/emacs-apidock-integration.html
;;==============================
;; (defun search-apidock-rails ()
;;   "Search current word in apidock for rails"
;;   (interactive)
;;   (let* ((word-at-point (thing-at-point 'symbol))
;; 		(word (read-string "Search apidock for? " word-at-point)))
;; 	(browse-url (concat "http://apidock.com/rails/" word))))

;; (define-key ruby-mode-map (kbd "C-c d") 'search-apidock-rails)


(defun convert-hash-rocket (BEG END)
  "Convert hash rocket syntax to JSON syntax"
  (interactive "r")
  (if (not (region-active-p))
    (message "mark not active")
    (save-excursion
      (goto-char BEG)
      (while (re-search-forward ":\\([^\s]+\\)\s*=>\s*\\([^\s]+\\)" END t)
        (replace-match "\\1: \\2")))))

(provide 'init-ruby)
