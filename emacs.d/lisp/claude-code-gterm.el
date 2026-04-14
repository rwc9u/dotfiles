;;; claude-code-gterm.el --- gterm backend for claude-code.el -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Rob Christie
;; Author: Rob Christie

;;; Commentary:

;; Provides a gterm (libghostty) terminal backend for claude-code.el.
;; Requires both gterm and claude-code packages.

;;; Code:

(require 'cl-lib)

;; Declare external gterm functions and variables
(declare-function gterm-create "gterm" (buffer-name program &optional switches))
(declare-function gterm-send-string "gterm" (string))
(declare-function gterm-copy-mode "gterm" ())
(declare-function gterm--copy-mode-enter "gterm" ())
(declare-function gterm--copy-mode-exit "gterm" ())
(declare-function gterm--maybe-resize "gterm" ())
(defvar gterm--process)
(defvar gterm--copy-mode)
(defvar gterm-term-environment-variable)
(defvar gterm-mode-map)

;; Declare claude-code variables
(defvar claude-code-term-name)
(defvar claude-code-newline-keybinding-style)

(defun claude-code--ensure-gterm ()
  "Ensure gterm package is loaded."
  (unless (and (require 'gterm nil t)
               (featurep 'gterm))
    (error "The gterm package is required for gterm terminal backend.  Please install it")))

(cl-defmethod claude-code--term-make ((_backend (eql gterm)) buffer-name program &optional switches)
  "Create a gterm terminal in BUFFER-NAME running PROGRAM with SWITCHES."
  (claude-code--ensure-gterm)
  ;; Inject env vars that the Claude CLI needs when running inside
  ;; an embedded terminal emulator (matches claude-code-ide behavior)
  (let ((process-environment
         (append (list "TERM_PROGRAM=emacs"
                       "FORCE_CODE_TERMINAL=true"
                       "PAGER=cat")
                 process-environment)))
    (let ((buf (gterm-create buffer-name program switches)))
      ;; Hide the window after creation like vterm backend does
      (when-let ((win (get-buffer-window buf)))
        (delete-window win))
      buf)))

(cl-defmethod claude-code--term-send-string ((_backend (eql gterm)) string)
  "Send STRING to gterm terminal."
  (gterm-send-string string))

(cl-defmethod claude-code--term-kill-process ((_backend (eql gterm)) buffer)
  "Kill the gterm terminal process in BUFFER."
  (when-let ((proc (get-buffer-process buffer)))
    (kill-process proc)))

(cl-defmethod claude-code--term-read-only-mode ((_backend (eql gterm)))
  "Switch gterm terminal to read-only (copy) mode."
  (claude-code--ensure-gterm)
  (unless gterm--copy-mode
    (gterm--copy-mode-enter))
  (setq-local cursor-type t))

(cl-defmethod claude-code--term-interactive-mode ((_backend (eql gterm)))
  "Switch gterm terminal to interactive mode."
  (claude-code--ensure-gterm)
  (when gterm--copy-mode
    (gterm--copy-mode-exit))
  (setq-local cursor-type nil))

(cl-defmethod claude-code--term-in-read-only-p ((_backend (eql gterm)))
  "Check if gterm terminal is in read-only (copy) mode."
  gterm--copy-mode)

(cl-defmethod claude-code--term-configure ((_backend (eql gterm)))
  "Configure gterm terminal in current buffer."
  (claude-code--ensure-gterm)
  (setq gterm-term-environment-variable claude-code-term-name)
  (setq-local cursor-in-non-selected-windows nil)
  (setq-local blink-cursor-mode nil)
  (setq-local cursor-type nil)
  (when-let ((proc (get-buffer-process (current-buffer))))
    (set-process-query-on-exit-flag proc nil))
  ;; Restore keymap when exiting copy mode
  (add-hook 'gterm-copy-mode-hook
            (lambda ()
              (unless gterm--copy-mode
                (claude-code--term-setup-keymap 'gterm)))
            nil t))

(cl-defmethod claude-code--term-customize-faces ((_backend (eql gterm)))
  "Apply face customizations for gterm terminal.
No customizations needed currently."
  nil)

;; Key sending helpers

(defun claude-code--gterm-send-escape ()
  "Send escape key to gterm."
  (interactive)
  (gterm-send-string "\e"))

(defun claude-code--gterm-send-return ()
  "Send return key to gterm."
  (interactive)
  (gterm-send-string "\r"))

(defun claude-code--gterm-send-alt-return ()
  "Send alt-return to gterm for newline without submitting."
  (interactive)
  (gterm-send-string "\e\r"))

(cl-defmethod claude-code--term-setup-keymap ((_backend (eql gterm)))
  "Set up the local keymap for Claude Code gterm buffers."
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map (current-local-map))

    ;; C-g for escape
    (define-key map (kbd "C-g") #'claude-code--gterm-send-escape)

    (pcase claude-code-newline-keybinding-style
      ('newline-on-shift-return
       (define-key map (kbd "<S-return>") #'claude-code--gterm-send-alt-return)
       (define-key map (kbd "<return>") #'claude-code--gterm-send-return))
      ('newline-on-alt-return
       (define-key map (kbd "<M-return>") #'claude-code--gterm-send-alt-return)
       (define-key map (kbd "<return>") #'claude-code--gterm-send-return))
      ('shift-return-to-send
       (define-key map (kbd "<return>") #'claude-code--gterm-send-alt-return)
       (define-key map (kbd "<S-return>") #'claude-code--gterm-send-return))
      ('super-return-to-send
       (define-key map (kbd "<return>") #'claude-code--gterm-send-alt-return)
       (define-key map (kbd "<s-return>") #'claude-code--gterm-send-return)))

    (use-local-map map)))

(defun claude-code--gterm-adjust-process-window-size (process windows)
  "Adjust PROCESS window size for gterm based on WINDOWS.
This delegates to gterm's built-in resize mechanism."
  (when-let ((buf (process-buffer process)))
    (with-current-buffer buf
      (gterm--maybe-resize)))
  nil)

(cl-defmethod claude-code--term-get-adjust-process-window-size-fn ((_backend (eql gterm)))
  "Get the gterm-specific function that adjusts window size."
  #'claude-code--gterm-adjust-process-window-size)

(provide 'claude-code-gterm)

;;; claude-code-gterm.el ends here
