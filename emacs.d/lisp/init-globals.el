(setq-default indent-tabs-mode nil)
(line-number-mode 1)
(column-number-mode 1)
(toggle-scroll-bar -1)
(setq visible-bell t)
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; make scrolling nicer
(setq scroll-step 1)
(setq scroll-conservatively 300)

(show-paren-mode t)
;; Toggle incremental minibuffer completion for this Emacs session.
(icomplete-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
;; hide the tool bar on Carbon Emacs
(tool-bar-mode 0)

;; make the cursor blink
(blink-cursor-mode 1)

;; start emacs subprocess for emacs client processes
(server-start)

;; Change default for CHANGELOG name default: ChangeLog
(setq change-log-default-name "CHANGELOG") 

;; remove the startup screen
(setq inhibit-startup-message t)

;; yes I really want these
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

;;============================================================
;; font lock
;;============================================================
(load "font-lock")
(font-lock-mode)

;;============================================================
;; electric-pair-mode
;;============================================================
(electric-pair-mode 1)
;;============================================================


;;============================================================
;; defaults for whitespace
;;============================================================
(setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace

;; Turn on auto fill for text-modes
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;============================================================
;; setting turn on column marking
;;============================================================
(require 'fill-column-indicator)

;;============================================================
;; change garbage collection to help with non-responsiveness
;;============================================================
(setq gc-cons-threshold 100000000)

;;============================================================
;; change amount of data which emacs reads from a process
;;============================================================
(setq read-process-output-max (* 1024 1024 2)) 


;; scroll the compilation buffer 
(setq compilation-scroll-output t)

(provide 'init-globals)
