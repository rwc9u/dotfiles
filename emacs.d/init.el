;-*-Emacs-Lisp-*-

(setq debug-on-error t)


;;;; per https://github.com/emacs-lsp/lsp-mode#performance
;; (setenv "LSP_USE_PLISTS" "true") ;; in early-init.el
;; (setq read-process-output-max (* 10 1024 1024)) ;; 10mb
;; (setq gc-cons-threshold 200000000)

;;============================================================
;; custom
;;============================================================
(setq custom-file "~/.emacs.d/lisp/custom.el")
(setq user-dev-directory "~/dev")
(load custom-file 'noerror)

;; emacs-plus additions
(setq ispell-program-name "aspell")
(setq ring-bell-function 'ignore)


;;============================================================
;; default load directory
;;============================================================
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/vendor")

;;============================================================
;; Ensure use-package is available
;;============================================================
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))


(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-compile
  :config (auto-compile-on-load-mode))

;; (use-package use-package-ensure-system-package
;;  :custom
;;  (system-packages-package-manager 'brew))
;;============================================================
;; helper functions
;;============================================================
(require 'init-defuns)

;;============================================================
;; themes and mode line
;;============================================================
(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (moody-replace-eldoc-minibuffer-message-function))

(use-package color-theme-sanityinc-solarized)
(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t)
  (let ((line (face-attribute 'mode-line :underline)))
	(set-face-attribute 'mode-line          nil :overline   line)
	(set-face-attribute 'mode-line-inactive nil :overline   line)
	(set-face-attribute 'mode-line-inactive nil :underline  line)
	(set-face-attribute 'mode-line          nil :box        nil)
	(set-face-attribute 'mode-line-inactive nil :box        nil)
	(set-face-attribute 'mode-line-inactive nil :background "#073642")))

;;============================================================
;; programming
;;============================================================
(use-package magit
  :bind (("<f13>" . magit-status)
         :map magit-mode-map
              ("M-3" . split-window-horizontally)
              ("M-2" . split-window-vertically)
              ("M-1" . delete-other-windows)
              ))

(use-package dash-at-point
  :bind
  ("C-c d" . dash-at-point))
(use-package coffee-mode
   :ensure t
   :init
   (setq-default coffee-tab-width 2))
(use-package yaml-mode)
(use-package fill-column-indicator)
(use-package projectile
  :bind
  (:map projectile-mode-map
        ("M-d" . projectile-find-dir)
        ("M-p" . projectile-switch-project)
        ("M-F" . projectile-find-file)
        ("M-G" . projectile-ripgrep))
  :config
  (setq projectile-dirconfig-comment-prefix "#")
  (setq projectile-switch-project-action 'projectile-dired)
  (projectile-global-mode))

(use-package yasnippet
  :config
  (yas-global-mode 1)
  :hook
  (projectile-rails-mode . (lambda ()
                             (yas-activate-extra-mode 'rails-mode))))
(use-package bm
  :init
  (setq bm-restore-repository-on-load t)
  :bind
  (("<M-f2>" . bm-toggle)
   ("<f2>" . bm-next)
   ("<S-f2>" . bm-previous))
  :hook
  ((after-init . bm-repository-load)
   (find-file . bm-buffer-restore)
   (kill-buffer . bm-buffer-save)
   (kill-emacs . (lambda nil
                   (bm-buffer-save-all)
                   (bm-repository-save)))))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package ag)
(use-package ripgrep)

(use-package docker-compose-mode)

(use-package sql-indent
  :hook (sql-mode . sqlind-minor-mode))

(use-package git-link
  :bind
  ("C-c g l" . git-link)
  :config
  (setq git-link-open-in-browser t)
  (setq git-link-default-branch "main"))

(use-package ido
  :init
  (setq ido-enable-flex-matching t)
  :config
  (ido-mode t)
  (ido-everywhere 1)
  :hook
  (ido-setup . (lambda()
                 (define-key ido-completion-map [tab] 'ido-complete))))
(use-package flx-ido)

(use-package which-key
  :config
  (which-key-mode)
  (which-key-setup-side-window-right-bottom))

(use-package smart-shift
  :config
  (global-smart-shift-mode 1))

;;============================================================
;; company
;;============================================================
(use-package company
  :hook
  (prog-mode . company-mode)
  (after-init . global-company-mode))

(use-package all-the-icons)
(use-package company-box
  :after company
  :hook
  (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-all-the-icons))


;;============================================================
;; terraform
;;============================================================
(use-package terraform-mode
  :init
  (setq lsp-semantic-tokens-enable t)
  (setq lsp-semantic-tokens-honor-refresh-requests t)
  (setq lsp-terraform-ls-enable-show-reference t))


  ;; (setq lsp-terraform-ls-prefill-required-fields t)

(use-package company-terraform)

;;============================================================
;; javascript
;;============================================================
;; (use-package js2-mode
;;   :ensure t
;;   :init
;;   (setq js-basic-indent 2)
;;   (setq-default js2-basic-indent 2
;;                 js2-basic-offset 2
;;                 js2-auto-indent-p t
;;                 js2-cleanup-whitespace t
;;                 js2-enter-indents-newline t
;;                 js2-indent-on-enter-key t
;;                 js2-global-externs (list "window" "module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "jQuery" "$"))
;;   (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))

;; (use-package js2-refactor
;;   :ensure t
;;   :init   (add-hook 'js2-mode-hook 'js2-refactor-mode)
;;   :config (js2r-add-keybindings-with-prefix "C-c ."))
;; (use-package tide
;;   :ensure t
;;   :after (typescript-mode company flycheck)
;;   :hook ((typescript-mode . tide-setup)
;;          (typescript-mode . tide-hl-identifier-mode)
;;          (before-save . tide-format-before-save))
;;   :init
;;   (setq tide-tsserver-executable "/Users/rob.christie/.asdf/shims/tsserver")
;;   (setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log")))



;;============================================================
;; some global defaults
;;============================================================
(require 'init-globals)

;;============================================================
;; tab management thx Ryan
;;============================================================
(require 'init-tabs)
;; remap M-/ to hippie-expand
(global-set-key [remap dabbrev-expand] 'hippie-expand)


;; (require 'init-utf8)

(use-package asdf 
  :load-path "/Users/rob.christie/dev/asdf.el"  
  :hook
  (prog-mode . asdf-enable)
  :init
  (setq asdf-binary "/opt/homebrew/opt/asdf/bin/asdf")
  :config
  (asdf-enable))
;;============================================================
;; Ruby/Rails/Ri
;;============================================================
(use-package projectile-rails
  :config
  (projectile-rails-global-mode))

(use-package ruby-mode
  :custom
  (ruby-align-to-stmt-keywords '(if def))
  :init
  (setq lsp-enable-indentation nil))

(use-package inf-ruby)
(use-package ruby-compilation)
(use-package rubocop)

(use-package haml-mode
    :mode ("html\\.haml$"
         "\\.html\\.haml$"
         "\\.hamlbars$")
    :hook ((haml-mode . (lambda()
                          (add-hook 'local-write-file-hooks
                                    '(lambda()
                                       (save-excursion
                                         (delete-trailing-whitespace)
                                         )))))))
(use-package sass-mode
  :mode ("\\.sass$"))
(use-package ruby-tools)

(use-package web-mode
  :init
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-indent-style 2)
  :mode ("\\.erb$"
         "\\.html$"
         "\\.php$"))

(require 'init-ruby)


;;============================================================
;; flycheck
;;============================================================
(use-package flycheck
  :config (global-flycheck-mode))

;;============================================================
;; flyspell
;;============================================================
(use-package flyspell
  :init
  (setq flyspell-use-meta-tab nil)
  :config
  (flyspell-mode)
  :bind
  (:map flyspell-mouse-map
        ([down-mouse-3] . flyspell-auto-correct-word))
  :hook
  ((text-mode . flyspell-mode-on)
   (LaTeX-mode . flyspell-mode-on)
   (org-mode . flyspell-mode-on)
   (markdown-mode . flyspell-mode)
   (c-mode-common . flyspell-prog-mode)
   (c++-mode-common . flyspell-prog-mode)
   (emacs-lisp-mode . flyspell-prog-mode)
   (c++-mode . flyspell-prog-mode)))

;;============================================================
;; eol-conversion
;;============================================================
(require 'eol-conversion)

;;============================================================
;; key mappings
;;============================================================
(require 'init-key-maps)

;;============================================================
;; bash
;;============================================================
(require 'init-bash)

;;============================================================
;; go 
;;============================================================
(use-package go-mode
  :init
  (setq lsp-gopls-staticcheck t)
  (setq lsp-eldoc-render-all t)
  (setq lsp-gopls-complete-unimported t)
  :bind
  (:map go-mode-map ("C-c C-c" . compile))
  :hook
  (go-mode . (lambda ()
             (flycheck-select-checker 'go-golint)
             (setq flycheck-disabled-checkers '(go-build go-vet)))))

(use-package protobuf-mode)

;;============================================================
;; lsp
;;============================================================
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :commands (lsp lsp-deferred)
  :hook ((lsp-mode . lsp-diagnostics-mode)
         (lsp-mode . lsp-enable-which-key-integration)
         (go-mode . lsp-deferred)
         (ruby-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (javascript-mode . lsp-deferred)
         (terraform-mode . lsp-deferred))

  :custom
  (lsp-eldoc-render-all t))

(use-package lsp-ui
  :commands lsp-ui-mode
  :defer t
  :hook (lsp-mode . lsp-ui-mode)

  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-use-webkit nil))

;;============================================================
;; org
;;============================================================
;; heavily inspired/copied from https://github.com/hrs/dotfiles/blob/main/emacs/.config/emacs/configuration.org#coq
(use-package org-superstar
  :config
  (setq org-superstar-special-todo-items t)
  (setq org-hide-leading-stars t)
  (add-hook 'org-mode-hook (lambda ()
                             (org-superstar-mode 1))))

(setq org-hide-emphasis-markers t)

(use-package org-appear
  :hook (org-mode . org-appear-mode))

(setq org-ellipsis "…")
(setq org-src-fontify-natively t)
(setq org-src-window-setup 'current-window)

(setq org-directory "~/org")

(defun org-file-path (filename)
  "Return the absolute address of an org file, given its relative name."
  (concat (file-name-as-directory org-directory) filename))

(setq org-index-file (org-file-path "index.org"))
(setq org-archive-location
      (concat
       (org-file-path (format "archive/archive-%s.org" (format-time-string "%Y")))
       "::* From %s"))

(setq org-refile-targets `((,org-index-file :level . 1)
                           (,(org-file-path "tasks.org") :level . 1)))

(setq org-agenda-files (list org-index-file
                             (org-file-path "tasks.org")
                             (org-file-path "work.org")))

(advice-add 'org-archive-subtree :after 'org-save-all-org-buffers)
(setq org-log-done 'time)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (ruby . t)
   (shell . t)))


(use-package org-ai
  :ensure t
  :commands (org-ai-mode
             org-ai-global-mode)
  :init
  (add-hook 'org-mode-hook #'org-ai-mode)
  (org-ai-global-mode) ; installs global keybindings on C-c M-a
  :config
  ;; if you are on the gpt-4 beta:
  ;; (setq org-ai-default-chat-model "gpt-4")
  ;; if you are using yasnippet and want `ai` snippets
  (org-ai-install-yasnippets))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "/Users/rob.christie/org/")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.33)
               (window-height . fit-window-to-buffer)))




(quelpa-use-package-activate-advice)
(use-package whisper
  :quelpa (whisper :fetcher github
                   :repo "natrys/whisper.el"
                   :branch "master"
                   :files ("*.el"))
  :bind ("C-c w r" . whisper-run)
  :config
  (setq whisper-install-directory "/tmp/"
        whisper-model "base"
        whisper-language "en"
        whisper-translate nil))
(quelpa-use-package-deactivate-advice)

;; (use-package flycheck-languagetool
;;   :ensure t
;;   :hook (text-mode . flycheck-languagetool-setup)
;;   :init
;;   (setq flycheck-languagetool-server-jar "/opt/homebrew/Cellar/languagetool/6.1/libexec/languagetool-server.jar"))

;;============================================================
;; private
;;============================================================
(load "private" 'noerror)




;; setup for ts-mode

(setq treesit-language-source-alist
'((ruby "https://github.com/tree-sitter/tree-sitter-ruby" "v0.21.0" "src")
  (bash "https://github.com/tree-sitter/tree-sitter-bash")
  (cmake "https://github.com/uyha/tree-sitter-cmake")
  (css "https://github.com/tree-sitter/tree-sitter-css")
  (elisp "https://github.com/Wilfred/tree-sitter-elisp")
  (go "https://github.com/tree-sitter/tree-sitter-go")
  (html "https://github.com/tree-sitter/tree-sitter-html")
  (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
  (json "https://github.com/tree-sitter/tree-sitter-json")
  (make "https://github.com/alemuller/tree-sitter-make")
  (markdown "https://github.com/ikatyang/tree-sitter-markdown")
  (python "https://github.com/tree-sitter/tree-sitter-python")
  (toml "https://github.com/tree-sitter/tree-sitter-toml")
  (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
  (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
  (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

(setq major-mode-remap-alist
      '((ruby-mode . ruby-ts-mode)
        (javascript-mode . javascript-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (tsx-mode . tsx-ts-mode)
        (json-mode . json-ts-mode)))

(defun run-non-ts-hooks ()
  (let ((major-name (symbol-name major-mode)))
    (when (string-match-p ".*-ts-mode" major-name)
      (run-hooks (intern (concat (replace-regexp-in-string "-ts" "" major-name) "-hook"))))))

(add-hook 'prog-mode-hook 'run-non-ts-hooks)
