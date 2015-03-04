
(require 'projectile)
(projectile-global-mode)

(define-key projectile-mode-map [(meta d)] 'projectile-find-dir)
(define-key projectile-mode-map [(meta p)] 'projectile-switch-project)
(define-key projectile-mode-map [(meta F)] 'projectile-find-file)
(define-key projectile-mode-map [(meta G)] 'projectile-grep)

(setq gc-cons-threshold 100000000)
