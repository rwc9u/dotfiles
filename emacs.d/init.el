;-*-Emacs-Lisp-*-

(setq debug-on-error t)
;;============================================================
;; custom
;;============================================================
(setq custom-file "~/.emacs.d/lisp/custom.el")
(setq user-dev-directory "~/dev")
(load custom-file 'noerror)


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

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-compile
  :config (auto-compile-on-load-mode))

(use-package use-package-ensure-system-package
  :custom
  (system-packages-package-manager 'brew))
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

;; (use-package ef-themes
;;   :custom
;;    (ef-themes-headings
;;          '((0 . (1.3))
;;            (1 . (1.3))
;;            (2 . (1.2))
;;            (t . (1.1))))
;;    (ef-themes-mixed-fonts t))

;; (ef-themes-select 'ef-night)

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
  ("C-c g l" . git-link))

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
(use-package js2-mode
  :ensure t
  :init
  (setq js-basic-indent 2)
  (setq-default js2-basic-indent 2
                js2-basic-offset 2
                js2-auto-indent-p t
                js2-cleanup-whitespace t
                js2-enter-indents-newline t
                js2-indent-on-enter-key t
                js2-global-externs (list "window" "module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "jQuery" "$"))

  ;; (add-hook 'js2-mode-hook
  ;;           (lambda ()
  ;;             (push '("function" . ?ƒ) prettify-symbols-alist)))

  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))
(use-package js2-refactor
  :ensure t
  :init   (add-hook 'js2-mode-hook 'js2-refactor-mode)
  :config (js2r-add-keybindings-with-prefix "C-c ."))
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(use-package nvm
  :ensure t)
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

;;============================================================
;; Ruby/Rails/Ri
;;============================================================
(use-package rvm
  :hook
  ((ruby-mode . rvm-activate-corresponding-ruby)))

(use-package projectile-rails
  :config
  (projectile-rails-global-mode))

(use-package ruby-mode
  :custom
  (ruby-align-to-stmt-keywords '(if def)))

(use-package inf-ruby)
(use-package ruby-compilation)
(use-package rubocop)

;; (use-package robe
;;   :hook
;;   (ruby-mode . robe-mode)
;;   :config
;;   )

;; (eval-after-load 'company
;;   '(push 'company-robe company-backends))

;; (with-eval-after-load 'company
;;  (define-key company-active-map (kbd "TAB") #'company-complete-common-or-cycle)
;;  (define-key company-active-map (kbd "<backtab>") (lambda () (interactive) (company-complete-common-or-cycle -1))))

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
  :hook ((go-mode ruby-mode terraform-mode) . lsp-deferred)

  :custom
  (lsp-eldoc-render-all t))

(use-package lsp-ui
  :commands lsp-ui-mode
  :defer t
  :hook (lsp-mode . lsp-ui-mode)

  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

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

;;============================================================
;; copilot
;; https://robert.kra.hn/posts/2023-02-22-copilot-emacs-setup/
;;============================================================

(use-package s)
(use-package dash)
(use-package editorconfig)


(use-package copilot
 
  :load-path "/Users/rob.christie/dev/copilot.el"  
  :hook
  (prog-mode . copilot-mode)
  :config
  (setq copilot-node-executable "/Users/rob.christie/.nvm/versions/node/v18.15.0/bin/node"))

;; (quelpa-use-package-activate-advice)
;; (use-package copilot
;;   :quelpa (copilot :fetcher github
;;                    :repo "rwc9u/copilot.el"
;;                    :branch "add-getPanelCompletions-support"
;;                    :files ("dist" "*.el"))
;;   :hook
;;   (prog-mode . copilot-mode)
;;   :config
;;   (setq copilot-node-executable "/Users/rob.christie/.nvm/versions/node/v18.15.0/bin/node"))
;; ;; you can utilize :map :hook and :config to customize copilot
;; (quelpa-use-package-deactivate-advice)

(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))

(with-eval-after-load 'copilot
(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
(define-key copilot-mode-map (kbd "M-C-<down>") #'copilot-next-completion)
(define-key copilot-mode-map (kbd "M-C-<up>") #'copilot-previous-completion)
(define-key copilot-mode-map (kbd "M-C-<right>") #'copilot-accept-completion-by-word)
(define-key copilot-mode-map (kbd "M-C-l") #'copilot-accept-completion-by-line))

(define-key global-map (kbd "M-C-<return>") #'rk/copilot-complete-or-accept)

;; from https://robert.kra.hn/posts/2023-02-22-copilot-emacs-setup/#tab-key

(defun rk/no-copilot-mode ()
  "Helper for `rk/no-copilot-modes'."
  (copilot-mode -1))

(defvar rk/no-copilot-modes '(shell-mode
                              inferior-python-mode
                              eshell-mode
                              term-mode
                              vterm-mode
                              comint-mode
                              compilation-mode
                              debugger-mode
                              dired-mode-hook
                              compilation-mode-hook
                              flutter-mode-hook
                              minibuffer-mode-hook)
  "Modes in which copilot is inconvenient.")

(defvar rk/copilot-manual-mode nil
  "When `t' will only show completions when manually triggered, e.g. via M-C-<return>.")

(defun rk/copilot-disable-predicate ()
  "When copilot should not automatically show completions."
  (or rk/copilot-manual-mode
      (member major-mode rk/no-copilot-modes)
      (company--active-p)))

;; (add-to-list 'copilot-disable-predicates #'rk/copilot-disable-predicate)


(defun rk/copilot-change-activation ()
  "Switch between three activation modes:
- automatic: copilot will automatically overlay completions
- manual: you need to press a key (M-C-<return>) to trigger completions
- off: copilot is completely disabled."
  (interactive)
  (if (and copilot-mode rk/copilot-manual-mode)
      (progn
        (message "deactivating copilot")
        (global-copilot-mode -1)
        (setq rk/copilot-manual-mode nil))
    (if copilot-mode
        (progn
          (message "activating copilot manual mode")
          (setq rk/copilot-manual-mode t))
      (message "activating copilot mode")
      (global-copilot-mode))))

(define-key global-map (kbd "M-C-<escape>") #'rk/copilot-change-activation)

(defun rk/copilot-complete-or-accept ()
  "Command that either triggers a completion or accepts one if one
is available. Useful if you tend to hammer your keys like I do."
  (interactive)
  (if (copilot--overlay-visible)
      (progn
        (copilot-accept-completion)
        (open-line 1)
        (next-line))
    (copilot-complete)))


(defun rk/copilot-quit ()
  "Run `copilot-clear-overlay' or `keyboard-quit'. If copilot is
cleared, make sure the overlay doesn't come back too soon."
  (interactive)
  (condition-case err
      (when copilot--overlay
        (lexical-let ((pre-copilot-disable-predicates copilot-disable-predicates))
          (setq copilot-disable-predicates (list (lambda () t)))
          (copilot-clear-overlay)
          (run-with-idle-timer
           1.0
           nil
           (lambda ()
             (setq copilot-disable-predicates pre-copilot-disable-predicates)))))
    (error (lambda ()
             (message "copilot not active, running `keyboard-quit'")
             (keyboard-quit)))))

(advice-add 'keyboard-quit :before #'rk/copilot-quit)

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



(defun rob-test-copilot-diagnose ()
  "Restart and diagnose copilot."
  (interactive)
  (when copilot--connection
    (jsonrpc-shutdown copilot--connection)
    (setq copilot--connection nil))
  (setq copilot--opened-buffers nil)
  (copilot--async-request 'getPanelCompletions
                          '(:doc (:version 0
                                  :source "\n"
                                  :path ""
                                  :uri ""
                                  :relativePath ""
                                  :languageId "text"
                                  :position (:line 0 :character 0))
                            :panelId "rob")
                          :success-fn (lambda (res)
                                        (message "%s" res))
                          :error-fn (lambda (err)
                                      (message "Copilot error: %S" err))
                          :timeout-fn (lambda ()
                                        (message "Copilot agent timeout."))))


;;; Copilot getPanelCompletions
;; (defun copilot--get-panel-completions (callback)
;;   "Get panel completions with CALLBACK."
;;   (copilot--async-request 'getPanelCompletions
;;                           (list :doc (copilot--generate-doc)
;;                                 :panelId (generate-new-buffer-name "copilot-panel"))
;;                           :success-fn callback
;;                           :error-fn (lambda (err)
;;                                       (message "Copilot error: %S" err))
;;                           :timeout-fn (lambda ()
;;                                         (message "Copilot agent timeout."))
;;                           :timeout 45))


;; (defun copilot-panel-complete ()
;;   "Pop a buffer with a list of suggested completions based on the current file ."
;;   (interactive)
;;   (setq copilot--last-doc-version copilot--doc-version)

;;   (setq copilot--completion-cache nil)

;;   (let ((called-interactively (called-interactively-p 'interactive)))
;;     (copilot--sync-doc)
;;     (copilot--get-panel-completions
;;      (lambda (res)
;;        (message "%s" res)))
;;     (switch-to-buffer
;;      (get-buffer-create (concat "*copilot-panel*")))))

;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;; Testing
;; (jsonrpc-lambda (&key completionText)
;;         (let ((completion (if (seq-empty-p completions) nil (seq-elt completions 0))))
;;           (if completion
;;               (message "%s" completion)
;;             (when called-interactively
;;               (message "No completion is available.")))))


;; (defun copilot--handle-notification (_server _method msg)
;;   "Handle MSG from CONN."
;;   (message "%s" (prin1-to-string _method))
;;   (if (eql _method 'PanelSolution)
;;       (progn
;;         (let ((oldbuf (current-buffer))
;;               (completion-text (plist-get msg :completionText)))
;;            (with-temp-buffer (get-buffer-create "*copilot-panel*")
;;                              (pop-to-buffer "*copilot-panel*")
;;                              (insert completion-text)
;;                              (insert "\n##############################################\n")
;;                       ))
;;         (message "%s" (plist-get msg :completionText))
;;         (message "##############################################")
;;         (message "%s" (prin1-to-string msg)))))

;; (defun copilot--handle-notification (server method msg)
;;   "Handle MSG of type method from server."
;;   ;; (message "%s" (prin1-to-string method))
;;   (if (eql method 'PanelSolution)
;;       (let ((oldbuf (current-buffer))
;;             (completion-text (plist-get msg :completionText))
;;             (completion-score (plist-get msg :score)))
;;         (with-temp-buffer (get-buffer-create "*copilot-panel*")
;;                           (pop-to-buffer "*copilot-panel*")
;;                           (insert completion-text)
;;                           (insert "\n##############################################\n")
;;                           )))
;;   (if (eql method 'PanelSolutionsDone)    
;;       (let ((oldbuf (current-buffer)))
;;         (with-temp-buffer (get-buffer-create "*copilot-panel*")
;;                           (pop-to-buffer "*copilot-panel*")
;;                           (insert "\n## Panel Solution Done\n")
;;                           ))))

