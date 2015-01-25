(global-set-key [delete] 'delete-char)
(global-set-key "\M-%" 'query-replace-regexp)
(global-set-key [f3] 'projectile-grep)
(global-set-key [(control f3)] 'gse-locate)
;; (global-set-key [(control f4)] 'semantic-tag-folding-fold-block)
;; (global-set-key [(control meta f4)] 'semantic-tag-folding-show-block)
(global-set-key [(control f4)] 'magit-status)
(global-set-key [f4] 'html-script-toggle-narrow)
;; (global-set-key [f5] 'jde-build)
(global-set-key [S-f5] 'ruby-eval-buffer)
(global-set-key [(control f5)] 'xmp)
(global-set-key [f6] 'goto-line)
(global-set-key [S-f7] 'kmacro-start-macro-or-insert-counter)
(global-set-key [f7] 'kmacro-end-or-call-macro)
(global-set-key [f8] 'sql-send-region)
(global-set-key [(control f8)] 'sql-send-buffer)
(global-set-key [(control f9)] 'rails-svn-status-into-root)
(global-set-key [(meta f1)]    'ri)

(global-set-key "%" 'match-paren)

(global-set-key [(meta \))] 'zoom-way-out)
(global-set-key [(meta _)] 'zoom-in)
(global-set-key [(meta +)] 'zoom-out)


(define-key global-map [(control meta n)]   'next-error)
(define-key global-map [(control meta p)]   'previous-error)

(global-set-key (kbd "C-t") 'ido-goto-symbol) ; was character transpose


;; some additional keymappings
;; Map the window manipulation keys to meta 0, 1, 2, o
(global-set-key (kbd "M-3") 'split-window-horizontally) ; was digit-argument
(global-set-key (kbd "M-2") 'split-window-vertically) ; was digit-argument
(global-set-key (kbd "M-1") 'delete-other-windows) ; was digit-argument
(global-set-key (kbd "M-0") 'delete-window) ; was digit-argument
(global-set-key (kbd "M-o") 'other-window)  ; was facemenu-keymap

;; Mac conventions
(global-set-key (kbd "M-a") 'mark-whole-buffer) ; was backward-sentence.
(global-set-key (kbd "M-s") 'save-buffer) ; was center-line. cmd-s is OS X convention.
                                        ; (defalias 'center-line 'save-buffer)

;; on NeXT/OpenStep Emacs.app, the physical Del key located under Ins key shows up in emacs as <kp-delete>, but on Carbon Emacs and Aquaemacs, it shows up as <delete>.
(global-set-key (kbd "<kp-delete>") 'delete-char) 

;;============================================================
;; minibuffer space completion
;;============================================================
(define-key minibuffer-local-filename-completion-map (kbd "SPC")
  'minibuffer-complete-word)

(define-key minibuffer-local-must-match-filename-map (kbd "SPC")
  'minibuffer-complete-word)

;;============================================================
;; Use of command key with emacs 23 on mac
;;============================================================
(if (eq window-system 'ns)
    (setq ns-command-modifier (quote meta)))
