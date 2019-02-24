(setq-default indent-tabs-mode nil)
(line-number-mode 1)
(column-number-mode 1)
(toggle-scroll-bar -1)
(setq visible-bell t)
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)
;; brute force fix to make sure nxml mode is always used for xml files
;; (setq magic-mode-alist nil)
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
;; pc-like textmarking
;;============================================================
;; (pc-selection-mode)

;;============================================================
;; electric-pair-mode
;;============================================================
(electric-pair-mode 1)
;;============================================================
;; window/buffer movement with arrow keys
;; overrides a few things and must be below pc-selection-mode
;;============================================================
(windmove-default-keybindings 'meta)


;;============================================================
;; defaults for whitespace
;;============================================================
(setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace

;;============================================================
;; setting fonts for the mac
;;============================================================
;; (and (eq window-system 'mac)
;;      (create-fontset-from-fontset-spec
;;       (concat
;;        "-apple-monaco-medium-r-normal--11-*-*-*-*-*-fontset-monaco,"
;;        "ascii:-apple-monaco-medium-r-normal--11-100-*-*-m-100-mac-roman,"
;;        "latin-iso8859-1:-apple-monaco-medium-r-normal--11-100-*-*-m-100-mac-roman"))
;;      (create-fontset-from-fontset-spec
;;       (concat
;;        "-apple-monaco-medium-r-normal--12-*-*-*-*-*-fontset-monaco,"
;;        "ascii:-apple-monaco-medium-r-normal--12-100-*-*-m-100-mac-roman,"
;;        "latin-iso8859-1:-apple-monaco-medium-r-normal--12-100-*-*-m-100-mac-roman"))
;;      (create-fontset-from-fontset-spec
;;       (concat
;;        "-apple-monaco-medium-r-normal--16-*-*-*-*-*-fontset-monaco,"
;;        "ascii:-apple-monaco-medium-r-normal--16-100-*-*-m-100-mac-roman,"
;;        "latin-iso8859-1:-apple-monaco-medium-r-normal--16-100-*-*-m-100-mac-roman"))
;;      (create-fontset-from-fontset-spec
;;       (concat
;;        "-apple-monaco-medium-r-normal--20-*-*-*-*-*-fontset-monaco,"
;;        "ascii:-apple-monaco-medium-r-normal--20-100-*-*-m-100-mac-roman,"
;;        "latin-iso8859-1:-apple-monaco-medium-r-normal--20-100-*-*-m-100-mac-roman"))
;;      (setq default-frame-alist '((font . "fontset-monaco")))
;;      )

;; Turn on auto fill for text-modes
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;============================================================
;; setting turn on column marking
;;============================================================
(require 'fill-column-indicator)

;;============================================================
;; Adding back cl-struct-define used by some code
;;============================================================
(defun cl-struct-define (name docstring parent type named slots children-sym
                              tag print-auto)
  (cl-assert (or type (equal '(cl-tag-slot) (car slots))))
  (cl-assert (or type (not named)))
  (if (boundp children-sym)
      (add-to-list children-sym tag)
    (set children-sym (list tag)))
  (let* ((parent-class parent))
    (while parent-class
      (add-to-list (intern (format "cl-struct-%s-tags" parent-class)) tag)
      (setq parent-class (get parent-class 'cl-struct-include))))
  ;; If the cl-generic support, we need to be able to check
  ;; if a vector is a cl-struct object, without knowing its particular type.
  ;; So we use the (otherwise) unused function slots of the tag symbol
  ;; to put a special witness value, to make the check easy and reliable.
  (unless named (fset tag :quick-object-witness-check))
  (put name 'cl-struct-slots slots)
  (put name 'cl-struct-type (list type named))
  (if parent (put name 'cl-struct-include parent))
  (if print-auto (put name 'cl-struct-print print-auto))
  (if docstring (put name 'structure-documentation docstring)))
