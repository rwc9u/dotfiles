(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(*pastie-restricted* nil)
 '(*pastie-timeout* 85)
 '(Info-additional-directory-list (quote ("~/.emacs.d/info")))
 '(LaTeX-command "latex -synctex=1")
 '(TeX-master "../master")
 '(autotest-use-ui t)
 '(backup-directory-alist (quote (("." . "~/backups"))))
 '(bm-recenter t)
 '(case-fold-search t)
 '(comint-move-point-for-output (quote all))
 '(compilation-scroll-output t)
 '(compilation-skip-threshold 2)
 '(current-language-environment "Latin-1")
 '(custom-safe-themes
   (quote
    ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(default-input-method "latin-1-prefix")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(fill-column 120)
 '(flx-ido-threshold 100)
 '(flycheck-eslintrc nil)
 '(flymake-allowed-file-name-masks
   (quote
    (("\\.c\\'" flymake-simple-make-init)
     ("\\.cpp\\'" flymake-simple-make-init)
     ("\\.xml\\'" flymake-xml-init)
     ("\\.html?\\'" flymake-xml-init)
     ("\\.cs\\'" flymake-simple-make-init)
     ("\\.pl\\'" flymake-perl-init)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
     ("\\.java\\'" jde-ecj-server-flymake-init jde-ecj-flymake-cleanup)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup)
     ("\\.tex\\'" flymake-simple-tex-init)
     ("\\.idl\\'" flymake-simple-make-init))))
 '(flymake-proc-allowed-file-name-masks
   (quote
    (("\\.c\\'" flymake-simple-make-init)
     ("\\.cpp\\'" flymake-simple-make-init)
     ("\\.xml\\'" flymake-xml-init)
     ("\\.html?\\'" flymake-xml-init)
     ("\\.cs\\'" flymake-simple-make-init)
     ("\\.pl\\'" flymake-perl-init)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
     ("\\.java\\'" jde-ecj-server-flymake-init jde-ecj-flymake-cleanup)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup)
     ("\\.tex\\'" flymake-simple-tex-init)
     ("\\.idl\\'" flymake-simple-make-init))))
 '(global-font-lock-mode t nil (font-lock))
 '(grep-find-command
   "find . -path '*/.svn/*' -or -path '*/build/*' -or -path '*/.git/*' -prune -o -type f -print0 | xargs -0 grep -nH -e ")
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "coverage" "logs")))
 '(hippie-expand-try-functions-list
   (quote
    (try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol try-expand-line)))
 '(isearch-allow-scroll t)
 '(iswitchb-max-to-show 40)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(markdown-command "/usr/local/bin/markdown")
 '(markdown-css-path
   "https://gist.github.com/jasonm23/516763/raw/632b066c7c18edc91485ba13b37ba50a9b2caac7/screen.css")
 '(max-lisp-eval-depth 1024)
 '(max-specpdl-size 15000)
 '(mf-display-padding-height 115)
 '(mumamo-chunk-coloring (quote submode-colored))
 '(mumamo-major-modes
   (quote
    ((xml-pi-php php-mode)
     (inlined-css-mode css-mode)
     (jsp-java-mode jde-mode)
     (eruby-mode ruby-mode)
     (inlined-javascript-mode javascript-mode ecmascript-mode))))
 '(package-selected-packages
   (quote
    (magit bm apples-mode projectile web-mode rspec-mode ruby-tools fill-column-indicator rubocop zenburn-theme yasnippet yari yaml-mode textmate scss-mode sass-mode rvm rinari rainbow-mode psvn nodejs-repl memory-usage markdown-mode magit-svn heroku handlebars-sgml-mode flymake-sass flymake-ruby flymake-haml flx-ido eyedropper es-mode deft color-theme-solarized color-theme browse-kill-ring autopair)))
 '(rails-webrick:use-mongrel t)
 '(rails-ws:default-server-type "mongrel")
 '(rng-schema-locating-files (quote ("schemas.xml" "~/dev/schemas/schemas.xml")))
 '(ruby-program-name "/opt/local/bin/irb --inf-ruby-mode" t)
 '(scss-compile-at-save nil)
 '(sql-oracle-program "/usr/local/bin/sqlplus")
 '(sql-pop-to-buffer-after-send-region t)
 '(svn-status-default-diff-arguments (quote ("-x -wbu --ignore-eol-style")))
 '(tempo-interactive t)
 '(tidy-shell-command "/usr/bin/tidy")
 '(user-full-name "Rob Christie")
 '(user-mail-address "rob.christie@eyestreet.com")
 '(vc-cvs-stay-local nil t)
 '(which-function-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:inherit diff-changed :background "#70FB67" :foreground "black"))))
 '(diff-file-header ((((class color) (min-colors 88) (background dark)) (:background "#5686E2" :weight bold))))
 '(diff-header ((((class color) (min-colors 88) (background dark)) (:background "#3469D0"))))
 '(diff-hunk-header ((t (:inherit diff-header :background "#3469D0"))))
 '(diff-index ((t (:inherit diff-file-header :background "#5686E2"))))
 '(diff-removed ((t (:inherit diff-changed :background "#FF453C"))))
 '(enh-ruby-op-face ((t (:foreground "gray69"))))
 '(enh-ruby-string-delimiter-face ((t (:foreground "#259185"))))
 '(flymake-errline ((((class color)) (:background "#330000" :overline "red" :underline "red"))) t)
 '(flymake-warnline ((((class color)) (:background "#333300" :overline "yellow" :underline "yellow"))) t)
 '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) nil)))
 '(mumamo-background-chunk-submode ((((class color) (min-colors 88) (background dark)) (:background "gray28"))) t)
 '(nxml-attribute-local-name-face ((t (:inherit nxml-name-face :foreground "blue" :weight semi-bold))) t)
 '(nxml-attribute-prefix-face ((t (:inherit nxml-name-face :foreground "blue" :weight semi-bold))) t)
 '(nxml-comment-content-face ((t (:foreground "purple" :slant italic))) t)
 '(nxml-element-local-name-face ((t (:inherit nxml-name-face :foreground "red" :weight bold))) t)
 '(nxml-element-prefix-face ((t (:inherit nxml-name-face :weight bold))) t)
 '(nxml-name-face ((((class color) (background light)) (:foreground "green"))) t)
 '(nxml-tag-slash-face ((t (:inherit nxml-name-face :foreground "green"))) t)
 '(rng-error-face ((t (:background "#080808" :overline "red" :underline "red"))) t))
