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
 '(copilot-chat-model "claude-3.5-sonnet")
 '(copilot-disable-predicates '(rk/copilot-disable-predicate))
 '(custom-enabled-themes '(sanityinc-solarized-dark))
 '(custom-safe-themes
   '("48d34b6afe72407ca494387c8bea495bb2deee96bd88516f302db1f11e1810a1"
     "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default))
 '(ediff-split-window-function 'split-window-horizontally)
 '(fill-column 120)
 '(flx-ido-threshold 100)
 '(flycheck-eslintrc nil)
 '(flycheck-ruby-executable "bundle exec rubocop")
 '(flymake-allowed-file-name-masks
   '(("\\.c\\'" flymake-simple-make-init) ("\\.cpp\\'" flymake-simple-make-init) ("\\.xml\\'" flymake-xml-init)
     ("\\.html?\\'" flymake-xml-init) ("\\.cs\\'" flymake-simple-make-init) ("\\.pl\\'" flymake-perl-init)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
     ("\\.java\\'" jde-ecj-server-flymake-init jde-ecj-flymake-cleanup)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup) ("\\.tex\\'" flymake-simple-tex-init)
     ("\\.idl\\'" flymake-simple-make-init)))
 '(flymake-proc-allowed-file-name-masks
   '(("\\.c\\'" flymake-simple-make-init) ("\\.cpp\\'" flymake-simple-make-init) ("\\.xml\\'" flymake-xml-init)
     ("\\.html?\\'" flymake-xml-init) ("\\.cs\\'" flymake-simple-make-init) ("\\.pl\\'" flymake-perl-init)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
     ("\\.java\\'" jde-ecj-server-flymake-init jde-ecj-flymake-cleanup)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup) ("\\.tex\\'" flymake-simple-tex-init)
     ("\\.idl\\'" flymake-simple-make-init)))
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode t)
 '(global-prettify-symbols-mode t)
 '(grep-find-command
   "find . -path '*/.svn/*' -or -path '*/build/*' -or -path '*/.git/*' -prune -o -type f -print0 | xargs -0 grep -nH -e ")
 '(grep-find-ignored-directories
   '("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "coverage" "logs"))
 '(hippie-expand-try-functions-list
   '(try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-dabbrev
                                      try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill
                                      try-complete-lisp-symbol-partially try-complete-lisp-symbol try-expand-line))
 '(isearch-allow-scroll t)
 '(iswitchb-max-to-show 40)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(keyboard-coding-system 'utf-8-unix)
 '(major-mode-remap-alist nil)
 '(markdown-command "/usr/local/bin/markdown")
 '(markdown-css-path
   "https://gist.github.com/jasonm23/516763/raw/632b066c7c18edc91485ba13b37ba50a9b2caac7/screen.css")
 '(max-lisp-eval-depth 1024)
 '(max-specpdl-size 15000 t)
 '(org-agenda-files '("/Users/rob.christie/org/index.org"))
 '(org-capture-templates
   '(("r" "Read later" entry (file+olp+datetree "~/org/notes.org") "* [[%:link][%:description]]" :immediate-finish t)))
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(org-support-shift-select t)
 '(org-todo-keywords '((sequence "TODO" "DOING" "DONE")))
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/") ("melpa" . "https://melpa.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
 '(package-selected-packages nil)
 '(safe-local-variable-values
   '((lsp-disabled-clients ruby-ls rubocop-ls sorbet-ls) (lsp-disabled-clients ruby-ls rubocop-ls)
     (lsp-enabled-clients quote ruby-lsp-ls) (lsp-enabled-clients quote (ruby-lsp-ls))
     (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8")
     (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx")
     (ruby-compilation-executable . "jruby")))
 '(tide-node-executable nil)
 '(typescript-indent-level 2))
'(ruby-program-name "/opt/local/bin/irb --inf-ruby-mode" t)
'(scss-compile-at-save nil)
'(user-full-name "Rob Christie")
'(user-mail-address "robchristie@gmail.com")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-hunk-header ((t (:inherit diff-header :background "#3469D0"))))
 '(diff-index ((t (:inherit diff-file-header :background "#5686E2")))))
