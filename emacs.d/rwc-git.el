;;============================================================
;; git
;;============================================================

;; magit
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/magit"))
(require 'magit)
;; (require 'magit-svn) 
(add-hook 'magit-mode-hook
          '(lambda () 
             (make-variable-buffer-local 'global-hl-line-mode)
             (setq global-hl-line-mode nil)
             ))

;; paste to gist
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/gist.el"))
(require 'gist)

;;(if (eq background 'dark)
(set-face-background 'magit-item-highlight "gray15")
;;    (set-face-background 'magit-item-highlight "gray95")
(define-key magit-mode-map (kbd "TAB") 'magit-toggle-section) ; undo tab completion everywhere
(define-key magit-mode-map [tab] 'magit-toggle-section)       ; undo tab completion everywhere

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (set-face-background 'magit-item-highlight "gray15")
     (define-key magit-mode-map (kbd "M-3") 'split-window-horizontally) ; was magit-show-level-3
     (define-key magit-mode-map (kbd "M-2") 'split-window-vertically)   ; was magit-show-level-2
     (define-key magit-mode-map (kbd "M-1") 'delete-other-windows)      ; was magit-show-level-1
     (defun magit-pull ()
       (interactive)
       (magit-run-git-async "pull" "--rebase" "-v"))
     ))


(set-variable 'magit-emacsclient-executable "/usr/local/Cellar/emacs/HEAD/bin/emacsclient")
