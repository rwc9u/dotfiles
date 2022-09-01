(autoload 'dash-at-point "dash-at-point"
  "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)

(add-hook 'rinari-minor-mode-hook
          (lambda () (setq dash-at-point-docset "rails")))

(provide 'init-dash)
