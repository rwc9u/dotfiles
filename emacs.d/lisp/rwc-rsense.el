;; Replace $RSENSE_HOME with the directory where RSense was installed in full path
;; Example for UNIX-like systems
;; (setq rsense-home "/home/tomo/opt/rsense-0.2")
;; or
;; (setq rsense-home (expand-file-name "~/opt/rsense-0.2"))
;; Example for Windows
;; (setq rsense-home "C:\\rsense-0.2")
(setq rsense-home "/Users/rchristie/dev/dotfiles/emacs.d/vendor/rsense")
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)