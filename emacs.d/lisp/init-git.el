;;============================================================
;; git
;;============================================================

;; magit
(require 'magit)
;; (require 'magit-svn) 
(add-hook 'magit-mode-hook
          '(lambda () 
             (make-variable-buffer-local 'global-hl-line-mode)
             (setq global-hl-line-mode nil)
             ))


;; (define-key magit-mode-map (kbd "TAB") 'magit-toggle-section) ; undo tab completion everywhere
;; (define-key magit-mode-map [tab] 'magit-toggle-section)       ; undo tab completion everywhere

(eval-after-load 'magit
  '(progn
     (define-key magit-mode-map (kbd "M-3") 'split-window-horizontally) ; was magit-show-level-3
     (define-key magit-mode-map (kbd "M-2") 'split-window-vertically)   ; was magit-show-level-2
     (define-key magit-mode-map (kbd "M-1") 'delete-other-windows)      ; was magit-show-level-1
     (defun magit-pull ()
       (interactive)
       (magit-run-git-async "pull" "--rebase" "-v"))
     ))

(provide 'init-git)
