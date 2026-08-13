;-*-Emacs-Lisp-*-

;; (setq debug-on-error t)


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
  (projectile-mode +1))

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
  :init (setq markdown-command
              (concat "pandoc -f gfm -t html5 --standalone"
                      " --metadata title=Preview"
                      " -M document-css=false"
                      " --css=" (expand-file-name "markdown-preview.css" user-emacs-directory))))

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

(use-package blamer
  :ensure t
  :bind (("s-i" . blamer-show-commit-info)
         ("C-c i" . blamer-show-posframe-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  (blamer-view 'overlay-right)
  (blamer-type 'visual)
  (blamer-symbol-count-before-new-line 4)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t)))
  :config
  (global-blamer-mode 1))

;; Persist history for better candidate sorting
(use-package savehist
  :init
  (savehist-mode))

;; Vertico - vertical completion UI
(use-package vertico
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package vertico-directory
  :after vertico
  :ensure nil
  :bind (:map vertico-map
         ("RET"   . vertico-directory-enter)
         ("DEL"   . vertico-directory-delete-char)
         ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

;; Orderless - flexible matching
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Marginalia - rich annotations in minibuffer
(use-package marginalia
  :init
  (marginalia-mode))

;; Consult - enhanced search/navigation commands
(use-package consult
  :bind (("C-x b" . consult-buffer)
         ("M-s r" . consult-ripgrep)
         ("M-s f" . consult-find)
         ("M-y"   . consult-yank-pop)))

;; Embark - contextual actions on completion candidates
(use-package embark
  :bind (("C-."   . embark-act)
         ("C-;"   . embark-dwim)
         ("C-h B" . embark-bindings)))

(use-package embark-consult
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

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
;; (use-package company-box
;;   :after company
;;   :hook
;;   (company-mode . company-box-mode)
;;   :config
;;   (setq company-box-icons-alist 'company-box-icons-all-the-icons))


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
  (define-key flyspell-mode-map (kbd "C-.") nil)
  (define-key flyspell-mode-map (kbd "C-,") nil)
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
;; shell
;;============================================================
(setq shell-file-name "/bin/zsh")
(setq shell-command-switch "-c")
(setq explicit-shell-file-name shell-file-name)
(setenv "SHELL" shell-file-name)

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


(defun rc/vterm-open-file-at-click (event)
  "Open file:line reference at mouse click in a vterm buffer.
Parses the text around the click point for patterns like
`path/to/file.ext:123` and opens the file at that line."
  (interactive "e")
  (let* ((pos (posn-point (event-start event)))
         line-text file-path line-num)
    (when pos
      (save-excursion
        (goto-char pos)
        (setq line-text (buffer-substring-no-properties
                         (line-beginning-position) (line-end-position))))
      ;; Match file:line patterns — absolute or relative paths
      (when (string-match
             "\\(/[^ \t:\"']+\\|[a-zA-Z0-9_.][^ \t:\"']*\\.[a-zA-Z0-9]+\\):\\([0-9]+\\)"
             line-text)
        (setq file-path (match-string 1 line-text))
        (setq line-num (string-to-number (match-string 2 line-text)))
        ;; Resolve relative paths against default-directory
        (setq file-path (expand-file-name file-path default-directory))
        (if (file-exists-p file-path)
            (progn
              (find-file-other-window file-path)
              (when (> line-num 0)
                (goto-char (point-min))
                (forward-line (1- line-num))))
          (message "File not found: %s" file-path))))))


(use-package gterm
  :load-path "/Users/rob.christie/dev/emacs-libgterm"
  :init
  (setq gterm-always-compile-module t))


(use-package claude-code-ide
  :load-path "/Users/rob.christie/dev/claude-code-ide.el"
  :bind (("C-c C-'" . claude-code-ide-menu)
         ("M-l" . claude-code-ide-insert-at-mentioned))
  :init
  (setq claude-code-ide-terminal-backend 'gterm)
  (setq claude-code-ide-cli-path "claude")
  (setq claude-code-ide-cli-extra-flags "--dangerously-skip-permissions")
  (setq claude-code-ide-enable-mcp-server t)
  :config
  (claude-code-ide-emacs-tools-setup)
  (with-eval-after-load 'vterm
    (define-key vterm-mode-map [double-mouse-1] #'rc/vterm-open-file-at-click))
  (with-eval-after-load 'gterm
    (define-key gterm-mode-map [double-mouse-1] #'rc/vterm-open-file-at-click)))

;; configuration vterm
(setq vterm-shell "/bin/zsh")

;; claude-code.el (stevemolitor) - terminal wrapper for Claude Code CLI
(use-package inheritenv
  :vc (:url "https://github.com/purcell/inheritenv" :rev :newest))

(defun rc/claude-code-clean-env (_buffer-name _dir)
  "Set environment for Claude running inside Emacs terminals.
FORCE_CODE_TERMINAL prevents the CLI from using output modes
that hang in embedded terminal emulators."
  (list "FORCE_CODE_TERMINAL=true" "INSIDE_EMACS" "PAGER=cat"))

(use-package claude-code
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :init
  (setq claude-code-terminal-backend 'gterm)
  (setq claude-code-program-switches '("--dangerously-skip-permissions"))
  :config
  (require 'claude-code-gterm)
  (add-hook 'claude-code-process-environment-functions #'rc/claude-code-clean-env)
  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map))

;;============================================================
;; private
;;============================================================
(load "private" 'noerror)

;; setup for ts-mode

(setq treesit-language-source-alist
'((ruby "https://github.com/tree-sitter/tree-sitter-ruby" "v0.23.1" "src")
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
