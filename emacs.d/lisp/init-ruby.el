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
            ;; (local-set-key (kbd "TAB") 'smart-tab)
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



;; ;;============================================================
;; ;; rcode tools
;; ;;============================================================
;; ;; commented out because it was slowing down ruby file load
;; ;; (add-to-list 'load-path  (expand-file-name "~/.emacs.d/rcodetools"))
;; ;; (require 'rcodetools)

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
