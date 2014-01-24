;;; eyedropper-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (eyedrop-pick-foreground-at-point eyedrop-pick-background-at-point
;;;;;;  eyedrop-pick-foreground-at-mouse eyedrop-pick-background-at-mouse
;;;;;;  eyedrop-foreground-at-point eyedrop-background-at-point eyedrop-foreground-at-mouse
;;;;;;  eyedrop-background-at-mouse) "eyedropper" "eyedropper.el"
;;;;;;  (21183 54033 0 0))
;;; Generated autoloads from eyedropper.el

(autoload 'eyedrop-background-at-mouse "eyedropper" "\
Return the background color under the mouse pointer.
Non-nil optional arg MSG-P means display an informative message.

\(fn EVENT &optional MSG-P)" t nil)

(autoload 'eyedrop-foreground-at-mouse "eyedropper" "\
Return the foreground color under the mouse pointer.
Non-nil optional arg MSG-P means display an informative message.

\(fn EVENT &optional MSG-P)" t nil)

(defalias 'background-color 'eyedrop-background-at-point)

(autoload 'eyedrop-background-at-point "eyedropper" "\
Return the background color under the text cursor.
Non-nil optional arg MSG-P means display an informative message.

\(fn &optional MSG-P)" t nil)

(defalias 'foreground-color 'eyedrop-foreground-at-point)

(autoload 'eyedrop-foreground-at-point "eyedropper" "\
Return the foreground color under the text cursor.
Non-nil optional arg MSG-P means display an informative message.

\(fn &optional MSG-P)" t nil)

(autoload 'eyedrop-pick-background-at-mouse "eyedropper" "\
Pick background of face or frame at character under the mouse pointer.
Save the background color in `eyedrop-picked-background' and
`eyedrop-last-picked-color'.  Return the picked color.
Non-nil optional arg MSG-P means display an informative message.

\(fn EVENT &optional MSG-P)" t nil)

(autoload 'eyedrop-pick-foreground-at-mouse "eyedropper" "\
Pick foreground of face or frame at character under the mouse pointer.
Save the foreground color in `eyedrop-picked-foreground' and
`eyedrop-last-picked-color'.  Return the picked color.
Non-nil optional arg MSG-P means display an informative message.

\(fn EVENT &optional MSG-P)" t nil)

(defalias 'eyedropper-background 'eyedrop-pick-background-at-point)

(defalias 'pick-background-color 'eyedrop-pick-background-at-point)

(autoload 'eyedrop-pick-background-at-point "eyedropper" "\
Pick background of face or frame at character at text cursor (point).
Save the background color in `eyedrop-picked-background' and
`eyedrop-last-picked-color'.  Return the picked color.
Non-nil optional arg MSG-P means display an informative message.

\(fn &optional MSG-P)" t nil)

(defalias 'eyedropper-foreground 'eyedrop-pick-foreground-at-point)

(defalias 'pick-foreground-color 'eyedrop-pick-foreground-at-point)

(autoload 'eyedrop-pick-foreground-at-point "eyedropper" "\
Pick foreground of face or frame at character at text cursor (point).
Save the foreground color in `eyedrop-picked-foreground' and
`eyedrop-last-picked-color'.  Return the picked color.
Non-nil optional arg MSG-P means display an informative message.

\(fn &optional MSG-P)" t nil)

;;;***

;;;### (autoloads nil nil ("eyedropper-pkg.el") (21183 54033 153019
;;;;;;  0))

;;;***

(provide 'eyedropper-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; eyedropper-autoloads.el ends here
