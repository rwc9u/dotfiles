;; carbon version
;; (load "/Applications/Emacs.app/Contents/Resources/site-lisp/nxhtml/autostart.el")
(load "~/.emacs.d/vendor/nxhtml/autostart.el")

(setq
 nxhtml-global-minor-mode nil
 mumamo-chunk-coloring 'submode-colored
 nxhtml-skip-welcome t
 ;; indent-region-mode t
 nxhtml-default-encoding "utf8"
 rng-nxml-auto-validate-flag nil
 ;; nxml-degraded t
 )

(add-hook 'nxhtml-mode-hook
          (lambda () (define-key nxhtml-mode-map [f2] 'nxml-complete)))

(setq auto-mode-alist
      (append '(
                ("\\.xml"  . nxml-mode)
                ("\\.xsl"  . nxml-mode)
                ("\\.fo"   . nxml-mode)
                ("\\.svg"  . nxml-mode)
                ("\\.tld"  . nxml-mode)
                ("\\.vm"   . nxml-mode)
                ("\\.rvml" . nxml-mode)
                ("\\.html$" . nxhtml-mode)
                ("\\.jsp"  . nxhtml-mode)
                )
              auto-mode-alist
              )
      )

(require 'mumamo-fun)
(setq mumamo-chunk-coloring 'submode-colored)
;; (add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-nxhtml-mumamo))
;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))


(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
      (nxml-mode)
      (goto-char begin)
      (while (search-forward-regexp "\>[ \\t]*\<" nil t) 
        (backward-char) (insert "\n"))
      (indent-region begin end))
    (message "Ah, much better!"))
