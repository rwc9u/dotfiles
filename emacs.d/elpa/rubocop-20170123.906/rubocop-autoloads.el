;;; rubocop-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "rubocop" "rubocop.el" (22686 20166 0 0))
;;; Generated autoloads from rubocop.el

(autoload 'rubocop-check-project "rubocop" "\
Run check on current project.

\(fn)" t nil)

(autoload 'rubocop-autocorrect-project "rubocop" "\
Run autocorrect on current project.

\(fn)" t nil)

(autoload 'rubocop-check-directory "rubocop" "\
Run check on DIRECTORY if present.
Alternatively prompt user for directory.

\(fn &optional DIRECTORY)" t nil)

(autoload 'rubocop-autocorrect-directory "rubocop" "\
Run autocorrect on DIRECTORY if present.
Alternatively prompt user for directory.

\(fn &optional DIRECTORY)" t nil)

(autoload 'rubocop-check-current-file "rubocop" "\
Run check on current file.

\(fn)" t nil)

(autoload 'rubocop-autocorrect-current-file "rubocop" "\
Run autocorrect on current file.

\(fn)" t nil)

(autoload 'rubocop-mode "rubocop" "\
Minor mode to interface with RuboCop.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("rubocop-pkg.el") (22686 20166 802481
;;;;;;  0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; rubocop-autoloads.el ends here
