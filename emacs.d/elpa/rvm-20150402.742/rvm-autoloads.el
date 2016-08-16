;;; rvm-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "rvm" "../../../../../.emacs.d/elpa/rvm-20150402.742/rvm.el"
;;;;;;  "98bf3ac29febe7909f35cbe6b0e5b351")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rvm-20150402.742/rvm.el

(autoload 'rvm-use-default "rvm" "\
use the rvm-default ruby as the current ruby version

\(fn)" t nil)

(autoload 'rvm-activate-corresponding-ruby "rvm" "\
activate the corresponding ruby version for the file in the current buffer.
This function searches for an .rvmrc file and activates the configured ruby.
If no .rvmrc file is found, the default ruby is used insted.

\(fn)" t nil)

(autoload 'rvm-use "rvm" "\
switch the current ruby version to any ruby, which is installed with rvm

\(fn NEW-RUBY NEW-GEMSET)" t nil)

(autoload 'rvm-open-gem "rvm" "\


\(fn GEMHOME)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/rvm-20150402.742/rvm-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/rvm-20150402.742/rvm.el") (22090
;;;;;;  50764 314038 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; rvm-autoloads.el ends here
