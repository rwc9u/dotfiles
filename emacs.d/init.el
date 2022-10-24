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

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (require 'use-package))

;;============================================================
;; helper functions
;;============================================================
(require 'init-defuns)

;;============================================================
;; packages
;;============================================================
(use-package magit
  :bind (:map magit-mode-map
              ("M-3" . split-window-horizontally)
              ("M-2" . split-window-vertically)
              ("M-1" . delete-other-windows)
              ))
(use-package powerline)
(use-package js2-mode)
(use-package js2-refactor)
(use-package coffee-mode)
(use-package color-theme-sanityinc-solarized)
(use-package solarized-theme
  :config (load-theme 'solarized-dark t))
(use-package flx-ido)
(use-package yaml-mode)
(use-package fill-column-indicator)
(use-package projectile)
(use-package inf-ruby)
(use-package ruby-compilation)
(use-package robe)
(use-package company)
(use-package haml-mode)
(use-package sass-mode)
(use-package rvm)
(use-package ruby-tools)
(use-package web-mode)
(use-package yasnippet)
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
(use-package flycheck)
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))
(use-package ag)

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
;; powerline - prettifying the modeline
;;============================================================
(require 'init-powerline)

;;============================================================
;; various configs
;;============================================================
(require 'init-ido)
(require 'init-comint)
;; (require 'init-utf8)

;;============================================================
;; Projectile
;;============================================================
(require 'init-projectile)

;;============================================================
;; Ruby/Rails/Ri
;;============================================================
(require 'init-ruby)

;;============================================================
;; Snippets
;;============================================================
(require 'init-yasnippet)

;;============================================================
;; flycheck
;;============================================================
(require 'init-flycheck)

;;============================================================
;; flyspell
;;============================================================
(require 'init-flyspell)

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
;; my-c-style
;;============================================================
(require 'init-c)

;;============================================================
;; go 
;;============================================================
(require 'init-go)

;;============================================================
;; dash 
;;============================================================
(require 'init-dash)

;;============================================================
;; lsp
;;============================================================
(require 'init-lsp)

;;============================================================
;; private
;;============================================================
(load "private" 'noerror)
