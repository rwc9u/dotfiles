;;; rinari-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (rinari-minor-mode rinari-launch) "rinari" "rinari.el"
;;;;;;  (20830 22307 0 0))
;;; Generated autoloads from rinari.el

(autoload 'rinari-launch "rinari" "\
Call function `rinari-minor-mode' if inside a rails project.
Otherwise, disable that minor mode if currently enabled.

\(fn)" t nil)

(defvar rinari-major-modes (if (boundp 'rinari-major-modes) rinari-major-modes (list 'find-file-hook 'mumamo-after-change-major-mode-hook 'dired-mode-hook)) "\
Major Modes from which to launch Rinari.")

(dolist (hook rinari-major-modes) (add-hook hook 'rinari-launch))

(autoload 'rinari-minor-mode "rinari" "\
Enable Rinari minor mode to support working with the Ruby on Rails framework.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("rinari-pkg.el") (20830 22307 154500 0))

;;;***

(provide 'rinari-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rinari-autoloads.el ends here
