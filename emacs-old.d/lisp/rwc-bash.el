(setq shell-file-name "bash")
(setq shell-command-switch "-c")
(setq explicit-shell-file-name shell-file-name)
(setenv "SHELL" shell-file-name)
(setq explicit-sh-args '("-i"))
;;(if (boundp 'w32-quote-process-args)
;;    (setq w32-quote-process-args ?\")) ;; Include only for MS Windows

;; this is needed to handle text binary mode problems with bash
(setq process-coding-system-alist
      (cons '("bash" . latin-1-unix) process-coding-system-alist))
