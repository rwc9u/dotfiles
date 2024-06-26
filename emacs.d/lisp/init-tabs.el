;; Spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; If there is a tab, make it the size of 2 spaces
(setq-default tab-width 2)

;; Mode specific indent sizes
;; TODO: Consider putting these in their own mode specific inits
(set-default 'javascript-indent-level 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Smart Tab

(defvar smart-tab-using-hippie-expand t
  "turn this on if you want to use hippie-expand completion.")

;; (defun smart-tab (prefix)
;;   "Needs `transient-mark-mode' to be on. This smart tab is
;;   minibuffer compliant: it acts as usual in the minibuffer.

;;   In all other buffers: if PREFIX is \\[universal-argument], calls
;;   `smart-indent'. Else if point is at the end of a symbol,
;;   expands it. Else calls `smart-indent'."
;;   (interactive "P")
;;   (cl-labels ((smart-tab-must-expand (&optional prefix)
;;                                   (unless (or (consp prefix)
;;                                               mark-active)
;;                                     (looking-at "\\_>"))))
;;     (cond ((minibufferp)
;;            (minibuffer-complete))
;;           ((smart-tab-must-expand prefix)
;;            (if smart-tab-using-hippie-expand
;;                (hippie-expand prefix)
;;              (dabbrev-expand prefix)))
;;           ((smart-indent)))))

;; (defun smart-indent ()
;;   "Indents region if mark is active, or current line otherwise."
;;   (interactive)
;;   (if mark-active
;;     (indent-region (region-beginning)
;;                    (region-end))
;;     (indent-for-tab-command)))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (global-set-key (kbd "TAB") 'smart-tab)

(provide 'init-tabs)
