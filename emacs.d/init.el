;-*-Emacs-Lisp-*-

(setq debug-on-error t)
;;============================================================
;; custom
;;============================================================
(setq custom-file "~/.emacs.d/lisp/custom.el")
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

(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (moody-replace-eldoc-minibuffer-message-function))


;;============================================================
;; programming
;;============================================================
(use-package magit
  :bind (("C-g" . magit-status)
         :map magit-mode-map
              ("M-3" . split-window-horizontally)
              ("M-2" . split-window-vertically)
              ("M-1" . delete-other-windows)
              ))

(use-package dash-at-point
  :bind
  ("C-c d" . dash-at-point))
(use-package js2-mode)
(use-package js2-refactor)
(use-package coffee-mode)
(use-package flx-ido)
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

(use-package sql-indent
  :hook (sql-mode . sqlind-minor-mode))

;;============================================================
;; company
;;============================================================
(use-package company
  :hook (prog-mode . company-mode))
(use-package all-the-icons)
(use-package company-box
  :after company
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-all-the-icons))

;;============================================================
;; terraform
;;============================================================
(use-package terraform-mode)
(use-package company-terraform)

;;============================================================
;; javascript
;;============================================================
(require 'init-javascript)

;;============================================================
;; some global defaults
;;============================================================
(require 'init-globals)

;;============================================================
;; tab management thx Ryan
;;============================================================
(require 'init-tabs)

;;============================================================
;; various configs
;;============================================================
(require 'init-ido)
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

(use-package inf-ruby)
(use-package ruby-compilation)
(use-package robe)
(use-package haml-mode)
(use-package sass-mode)
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
  :init (global-flycheck-mode))

;;============================================================
;; flyspell
;;============================================================
(use-package flyspell
  :init
  (flyspell-mode)
  :config
  (setq flyspell-use-meta-tab nil)
  :bind
  (:map flyspell-mouse-map
        ([down-mouse-3] . flyspell-auto-correct-word))
  :hook
  ((text-mode . flyspell-mode-on)
   (LaTeX-mod . flyspell-mode-on)
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
;; environment settings
;;============================================================
(require 'init-envs)

;;============================================================
;; go 
;;============================================================
(require 'init-go)

;;============================================================
;; lsp
;;============================================================
;; (require 'init-lsp)

;;============================================================
;; org
;;============================================================
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

;;============================================================
;; private
;;============================================================
(load "private" 'noerror)
