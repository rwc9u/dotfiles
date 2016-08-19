
(require 'projectile)
(projectile-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

(define-key projectile-mode-map [(meta d)] 'projectile-find-dir)
(define-key projectile-mode-map [(meta p)] 'projectile-switch-project)
(define-key projectile-mode-map [(meta F)] 'projectile-find-file)
(define-key projectile-mode-map [(meta g)] 'projectile-grep)
