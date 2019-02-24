;;============================================================
;; This removes unsightly ^M characters that would otherwise
;; appear in the output of java applications.
;;============================================================
(add-hook 'comint-output-filter-functions
          'comint-strip-ctrl-m)

(provide 'init-comint)
