(require 'yasnippet)
;; (require 'dropdown-list)
;; (setq yas-prompt-functions '( yas-dropdown-prompt
;;                               yas-ido-prompt
;;                               yas-completing-prompt))
;; ;; (yas--initialize)
(yas-global-mode 1)

(add-hook 'projectile-rails-mode-hook
          #'(lambda ()
              (yas-activate-extra-mode 'rails-mode)))


;; ;; (load "~/dev/yasnippets-ruby/setup.el")  ;; used by ruby snippets
;; ;; (yas-load-directory "~/dev/yasnippets-ruby")
;; (load "~/dev/yasnippet/extras/imported/ruby-mode/.yas-setup.el")
;; (yas-load-directory "~/dev/yasnippet/extras/imported/ruby-mode")
;; ;; (yas-load-directory "~/dev/yasnippet/extras/imported/rails-mode")
;; (yas-load-directory "~/.emacs.d/yasnippets-shoulda")

;; (yas-load-directory "~/dev/yasnippets-rspec/rspec-snippets")
;; (yas-load-directory "~/dev/yasnippets-rails/rails-mode")
;; (load "~/dev/yasnippets-rails/rails-mode/.yas-setup.el")


