;;; whisper-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "whisper" "whisper.el" (0 0 0 0))
;;; Generated autoloads from whisper.el

(autoload 'whisper-run "whisper" "\
Transcribe/translate audio using whisper.

When ARG is given, uses a local file as input. Otherwise records the audio.

This is a dwim function that does different things depending on current state:

- When inference engine (whisper.cpp) isn't installed, installs it first.
- When speech recognition model isn't available, downloads it.
- When installation/download is already in progress, cancels those.
- When installation is sound, starts recording audio.
- When recording is in progress, stops it and starts transcribing.
- When transcribing is in progress, cancels it.

\(fn &optional ARG)" t nil)

(autoload 'whisper-file "whisper" "\
Transcribe/translate local file using whisper." t nil)

(register-definition-prefixes "whisper" '("whisper-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; whisper-autoloads.el ends here
