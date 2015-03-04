;-*-Emacs-Lisp-*-

;;============================================================
;; default load directory
;;============================================================
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/vendor")

(setq custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)

;;============================================================
;; package managers
;;============================================================
(load "rwc-package")

;; (setq debug-on-error t)

;;============================================================
;; some global defaults
;;============================================================
(load "rwc-globals")

;;============================================================
;; tab management thx Ryan
;;============================================================
(load "rwc-tabs")

;;============================================================
;; color themes
;;============================================================
(load "rwc-color-theme")

;;============================================================
;; highlight current line
;; depends: color theme
;;============================================================
(load "rwc-highlight-line")

;;============================================================
;; powerline - prettifying the modeline
;;============================================================
(load "rwc-powerline")

;;============================================================
;; various configs
;;============================================================
(load "rwc-git")
(load "rwc-markdown")
(load "rwc-textile")
(load "rwc-twitter")
(load "rwc-ido")
(load "rwc-svn")
(load "rwc-comint")
;; (load "rwc-auctex")
(load "rwc-yaml")

;;============================================================
;; js mode
;;============================================================
(load "rwc-javascript")

;;============================================================
;; nxml 
;;============================================================
(load "rwc-nxml")

;;============================================================
;; Ruby/Rails/Ri
;;============================================================
(load "rwc-ruby")


;;============================================================
;; Projectile
;;============================================================
(load "rwc-projectile")

;;============================================================
;; Snippets
;;============================================================
(load "rwc-yasnippet")

;;============================================================
;; Rails Reloaded 
;; depends: ruby, yasnippet
;;============================================================
;; (load "rwc-rails-reloaded")

;;============================================================
;; css mode
;;============================================================
(load "rwc-css")

;;============================================================
;; xhtml help
;;============================================================
(load "rwc-xhtml")

;;============================================================
;; linemark functionality
;;============================================================
(load "rwc-linemark")

;;============================================================
;; flycheck
;;============================================================
(load "rwc-flycheck")

;;============================================================
;; flyspell
;;============================================================
(load "rwc-flyspell")

;;============================================================
;; eol-conversion
;;============================================================
(load "rwc-eol-conversion")

;;============================================================
;; key mappings
;;============================================================
(load "rwc-key-maps")

;;============================================================
;; bash
;;============================================================
(load "rwc-bash")

;;============================================================
;; environment settings
;;============================================================
(load "rwc-envs")

;;============================================================
;; my-c-style
;;============================================================
(load "rwc-c")

;;============================================================
;; mode line bell
;;============================================================
(load "rwc-mode-line-bell")

;;============================================================
;; defuns
;;============================================================
(load "rwc-defuns")

;;============================================================
;; private
;;============================================================
(load "private" 'noerror)

;;============================================================
;; test area
;;============================================================
(load "rwc-deft")
(load "rwc-el-get")
(load "rwc-tty-format")

;;============================================================
;; autoinstall
;;============================================================
;; (require 'auto-install)
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install"))
;;============================================================
;; anything
;;============================================================
;; (require 'anything)
;; (require 'anything-match-plugin)    
;; (setq anything-mp-space-regexp "[\\ ] ")


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;; (when
;;     (load
;;      (expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (package-initialize))

;; Beginning of the el4r block:
;; RCtool generated this block automatically. DO NOT MODIFY this block!
;; (add-to-list 'load-path "/Users/rchristie/.rvm/rubies/ruby-1.9.3-p194/share/emacs/site-lisp")
;; (require 'el4r)
;; (el4r-boot)
;; End of the el4r block.
;; User-setting area is below this line.
