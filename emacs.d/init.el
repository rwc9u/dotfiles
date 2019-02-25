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
;; helper functions
;;============================================================
(require 'init-defuns)

;;============================================================
;; package managers
;;============================================================
(require 'init-package)

;;============================================================
;; packages
;;============================================================
(package 'magit)
(package 'powerline)
(package 'js2-mode)
(package 'coffee-mode)
(package 'color-theme-sanityinc-solarized)
(package 'solarized-theme)
(package 'flx-ido)
(package 'yaml-mode)
(package 'fill-column-indicator)
(package 'projectile)
(package 'inf-ruby)
(package 'ruby-compilation)
(package 'robe)
(package 'company)
(package 'haml-mode)
(package 'sass-mode)
(package 'rvm)
(package 'ruby-tools)
(package 'web-mode)
(package 'yasnippet)
(package 'bm)
(package 'flycheck)
(package 'markdown-mode)

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
;; color themes
;;============================================================
(require 'init-color-theme)

;;============================================================
;; highlight current line
;; depends: color theme
;;============================================================
(require 'init-highlight-line)

;;============================================================
;; powerline - prettifying the modeline
;;============================================================
(require 'init-powerline)

;;============================================================
;; various configs
;;============================================================
(require 'init-git)
(require 'init-markdown)
(require 'init-ido)
(require 'init-svn)
(require 'init-comint)
(require 'init-yaml)
(require 'init-utf8)

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
;; linemark functionality
;;============================================================
(require 'init-linemark)

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

;; ;;============================================================
;; ;; mode line bell
;; ;;============================================================
;; (require 'init-mode-line-bell)

;;============================================================
;; private
;;============================================================
(load "private" 'noerror)