;;; smart-shift-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "smart-shift" "smart-shift.el" (0 0 0 0))
;;; Generated autoloads from smart-shift.el

(autoload 'smart-shift-right "smart-shift" "\
Shift the line or region to the ARG times to the right.

\(fn &optional ARG)" t nil)

(autoload 'smart-shift-left "smart-shift" "\
Shift the line or region to the ARG times to the left.

\(fn &optional ARG)" t nil)

(autoload 'smart-shift-up "smart-shift" "\
Shift current line or region to the ARG lines backwardly.

\(fn &optional ARG)" t nil)

(autoload 'smart-shift-down "smart-shift" "\
Shift current line or region to the ARG lines forwardly.

\(fn &optional ARG)" t nil)

(autoload 'smart-shift-pass-through "smart-shift" "\
Finish shifting and invoke the corresponding command." t nil)

(autoload 'smart-shift-mode "smart-shift" "\
Shift line/region to left/right.

This is a minor mode.  If called interactively, toggle the
`Smart-Shift mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `smart-shift-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(put 'global-smart-shift-mode 'globalized-minor-mode t)

(defvar global-smart-shift-mode nil "\
Non-nil if Global Smart-Shift mode is enabled.
See the `global-smart-shift-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-smart-shift-mode'.")

(custom-autoload 'global-smart-shift-mode "smart-shift" nil)

(autoload 'global-smart-shift-mode "smart-shift" "\
Toggle Smart-Shift mode in all buffers.
With prefix ARG, enable Global Smart-Shift mode if ARG is positive; otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Smart-Shift mode is enabled in all buffers where `smart-shift-mode-on' would do it.

See `smart-shift-mode' for more information on Smart-Shift mode.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "smart-shift" '("smart-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; smart-shift-autoloads.el ends here
