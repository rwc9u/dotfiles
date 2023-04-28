;;; org-ai-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "org-ai" "org-ai.el" (0 0 0 0))
;;; Generated autoloads from org-ai.el

(defvar org-ai-global-mode nil "\
Non-nil if org-ai-global mode is enabled.
See the `org-ai-global-mode' command
for a description of this minor mode.")

(custom-autoload 'org-ai-global-mode "org-ai" nil)

(autoload 'org-ai-global-mode "org-ai" "\
Non `org-mode' specific minor mode for the OpenAI API.

This is a minor mode.  If called interactively, toggle the
`org-ai-global mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='org-ai-global-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "org-ai" '("org-ai-"))

;;;***

;;;### (autoloads nil "org-ai-block" "org-ai-block.el" (0 0 0 0))
;;; Generated autoloads from org-ai-block.el

(register-definition-prefixes "org-ai-block" '("org-ai-"))

;;;***

;;;### (autoloads nil "org-ai-on-project" "org-ai-on-project.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-ai-on-project.el

(autoload 'org-ai-on-project "org-ai-on-project" "\
Start org-ai-on-project inside BASE-DIR.
This is a command that will allow you to run an org-ai prompt on
multiple files. You can select the files using a regexp expression
and optionally select regions inside of the files.

Those files will then be concatenated and passed to org-ai with
your prompt.

\(fn &optional BASE-DIR)" t nil)

(register-definition-prefixes "org-ai-on-project" '("org-ai-on-"))

;;;***

;;;### (autoloads nil "org-ai-openai" "org-ai-openai.el" (0 0 0 0))
;;; Generated autoloads from org-ai-openai.el

(register-definition-prefixes "org-ai-openai" '("org-ai-"))

;;;***

;;;### (autoloads nil "org-ai-openai-image" "org-ai-openai-image.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-ai-openai-image.el

(register-definition-prefixes "org-ai-openai-image" '("org-ai-"))

;;;***

;;;### (autoloads nil "org-ai-talk" "org-ai-talk.el" (0 0 0 0))
;;; Generated autoloads from org-ai-talk.el

(register-definition-prefixes "org-ai-talk" '("org-ai-talk-"))

;;;***

;;;### (autoloads nil "org-ai-useful" "org-ai-useful.el" (0 0 0 0))
;;; Generated autoloads from org-ai-useful.el

(register-definition-prefixes "org-ai-useful" '("org-ai-"))

;;;***

;;;### (autoloads nil nil ("org-ai-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; org-ai-autoloads.el ends here
