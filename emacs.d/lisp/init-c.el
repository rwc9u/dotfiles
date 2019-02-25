(defconst my-c-style
  '((c-basic-offset . 4)
    (c-comment-only-line-offset 0 . 0)
    (c-offsets-alist
     (string . c-lineup-dont-change)
     (c . c-lineup-C-comments)
     (defun-open . 0)
     (defun-close . 0)
     (defun-block-intro . +)
     (class-open . 0)
     (class-close . 0)
     (inline-close . 0)
     (func-decl-cont . +)
     (knr-argdecl . 0)
     (topmost-intro . 0)
     (topmost-intro-cont . 0)
     (member-init-intro . +)
     (member-init-cont . c-lineup-multi-inher)
     (inher-intro . +)
     (inher-cont . +)
     (block-open . -)
     (block-close . 0)
     (brace-list-open . 0)
     (brace-list-close . 0)
     (brace-list-intro . +)
     (brace-list-entry . 0)
     (brace-entry-open . 0)
     (statement . 0)
     (statement-case-intro . +)
     (substatement . +)
     (case-label . 0)
     (access-label . -)
     (do-while-closure . 0)
     (else-clause . 0)
     (catch-clause . 0)
     (comment-intro . c-lineup-comment)
     (arglist-cont . 0)
     (arglist-cont-nonempty . c-lineup-arglist)
     (stream-op . c-lineup-streamop)
     (inclass . +)
     (cpp-macro .
                [0])
     (cpp-macro-cont . c-lineup-dont-change)
     (friend . 0)
     (objc-method-intro .
                        [0])
     (objc-method-args-cont . c-lineup-ObjC-method-args)
     (objc-method-call-cont . c-lineup-ObjC-method-call)
     (extern-lang-open . 0)
     (extern-lang-close . 0)
     (inextern-lang . +)
     (namespace-open . 0)
     (namespace-close . 0)
     (innamespace . +)
     (template-args-cont c-lineup-template-args +)
     (inlambda . 0)
     (lambda-intro-cont . +)
     (inexpr-statement . 0)
     (inexpr-class . +)
     (statement-block-intro . +)
     (knr-argdecl-intro . 0)
     (substatement-open . 0)
     (label . 0)
     (statement-case-open . +)
     (statement-cont . +)
     (arglist-intro . +)
     (arglist-close . 0)
     (inline-open . 0))
    (c-special-indent-hook . c-gnu-impose-minimum)
    (c-comment-continuation-stars . "* ")
    (c-hanging-comment-ender-p . t))
  "My C Programming Style")

(provide 'init-c)
;;; init-c.el ends here