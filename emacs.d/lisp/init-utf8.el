
;; (require 'un-define "un-define" t)
;; (set-buffer-file-coding-system 'utf-8 'utf-8-unix)
;; (set-default buffer-file-coding-system 'utf-8-unix)
;; (set-default-coding-systems 'utf-8-unix)
;; (prefer-coding-system 'utf-8-unix)

(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
;; (set-keyboard-coding-system 'utf-8-unix)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8-unix)
  (setq default-buffer-file-coding-system 'utf-8-unix))

(provide 'init-utf8)
