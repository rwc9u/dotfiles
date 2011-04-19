(if (eq window-system 'ns)
     (progn 
       (load "auctex.el" nil t t)
       (load "preview-latex.el" nil t t)
       (setq TeX-parse-self t) ; Enable parse on load.
       (setq TeX-auto-save t) ; Enable parse on save.
     ))

