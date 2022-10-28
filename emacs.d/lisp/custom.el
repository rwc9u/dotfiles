(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist '(("." . "~/backups")))
 '(bm-recenter t)
 '(case-fold-search t)
 '(comint-move-point-for-output 'all)
 '(compilation-scroll-output t)
 '(compilation-skip-threshold 2)
 '(custom-enabled-themes '(sanityinc-solarized-dark))
 '(custom-safe-themes
   '("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default))
 '(ediff-split-window-function 'split-window-horizontally)
 '(fill-column 120)
 '(flx-ido-threshold 100)
 '(flycheck-eslintrc nil)
 '(flymake-allowed-file-name-masks
   '(("\\.c\\'" flymake-simple-make-init)
     ("\\.cpp\\'" flymake-simple-make-init)
     ("\\.xml\\'" flymake-xml-init)
     ("\\.html?\\'" flymake-xml-init)
     ("\\.cs\\'" flymake-simple-make-init)
     ("\\.pl\\'" flymake-perl-init)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
     ("\\.java\\'" jde-ecj-server-flymake-init jde-ecj-flymake-cleanup)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup)
     ("\\.tex\\'" flymake-simple-tex-init)
     ("\\.idl\\'" flymake-simple-make-init)))
 '(flymake-proc-allowed-file-name-masks
   '(("\\.c\\'" flymake-simple-make-init)
     ("\\.cpp\\'" flymake-simple-make-init)
     ("\\.xml\\'" flymake-xml-init)
     ("\\.html?\\'" flymake-xml-init)
     ("\\.cs\\'" flymake-simple-make-init)
     ("\\.pl\\'" flymake-perl-init)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
     ("\\.java\\'" jde-ecj-server-flymake-init jde-ecj-flymake-cleanup)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup)
     ("\\.tex\\'" flymake-simple-tex-init)
     ("\\.idl\\'" flymake-simple-make-init)))
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode t)
 '(global-prettify-symbols-mode t)
 '(grep-find-command
   "find . -path '*/.svn/*' -or -path '*/build/*' -or -path '*/.git/*' -prune -o -type f -print0 | xargs -0 grep -nH -e ")
 '(grep-find-ignored-directories
   '("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "coverage" "logs"))
 '(hippie-expand-try-functions-list
   '(try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol try-expand-line))
 '(isearch-allow-scroll t)
 '(iswitchb-max-to-show 40)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(keyboard-coding-system 'utf-8-unix)
 '(markdown-command "/usr/local/bin/markdown")
 '(markdown-css-path
   "https://gist.github.com/jasonm23/516763/raw/632b066c7c18edc91485ba13b37ba50a9b2caac7/screen.css")
 '(max-lisp-eval-depth 1024)
 '(max-specpdl-size 15000)
 '(org-support-shift-select t)
 '(org-todo-keywords '((sequence "TODO" "DOING" "DONE")))
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
 '(package-selected-packages
   '(ripgrep moody sass-mode bm use-package lsp-ui lsp-mode dash-at-point rvm neotree company-terraform terraform-mode go-mode docker-compose-mode groovy-mode js2-refactor color-theme-sanityinc-solarized color-theme fill-column-indicator coffee-mode js2-mode))
 '(windmove-default-keybindings '([ignore] meta alt)))
'(ruby-program-name "/opt/local/bin/irb --inf-ruby-mode" t)
'(scss-compile-at-save nil)
'(user-full-name "Rob Christie")
'(user-mail-address "robchristie@gmail.com")
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
 '(hl-line ((t (:extend t :background "#111")))))
