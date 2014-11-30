(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/maxframe"))
(require 'maxframe)
(setq mf-max-width 1920)
(add-hook 'window-setup-hook 'maximize-frame t)
