;;; rubocop-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "rubocop" "rubocop.el" (0 0 0 0))
;;; Generated autoloads from rubocop.el

(autoload 'rubocop-check-project "rubocop" "\
Run check on current project." t nil)

(autoload 'rubocop-autocorrect-project "rubocop" "\
Run autocorrect on current project." t nil)

(autoload 'rubocop-format-project "rubocop" "\
Run format on current project." t nil)

(autoload 'rubocop-check-directory "rubocop" "\
Run check on DIRECTORY if present.
Alternatively prompt user for directory.

\(fn &optional DIRECTORY)" t nil)

(autoload 'rubocop-autocorrect-directory "rubocop" "\
Run autocorrect on DIRECTORY if present.
Alternatively prompt user for directory.

\(fn &optional DIRECTORY)" t nil)

(autoload 'rubocop-check-current-file "rubocop" "\
Run check on current file." t nil)

(autoload 'rubocop-autocorrect-current-file "rubocop" "\
Run autocorrect on current file." t nil)

(autoload 'rubocop-format-current-file "rubocop" "\
Run format on current file." t nil)

(autoload 'rubocop-mode "rubocop" "\
Minor mode to interface with RuboCop.

This is a minor mode.  If called interactively, toggle the
`RuboCop mode' mode.  If the prefix argument is positive, enable
the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `rubocop-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "rubocop" '("rubocop-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rubocop-autoloads.el ends here
