(require 'flyspell)
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t) 
(autoload 'tex-mode-flyspell-verify "flyspell" "" t) 

;; turn off the use of meta-tab key combination that is window switching on most machines now
;; if not nil then this can be used for autocorrect. I don't use autocorrect so I don't rebind
;; it to any other key. 
(setq flyspell-use-meta-tab nil)

;; ;; my customization settings

;; ;; adds correction to the abbreviation table
;; ;; (flyspell-abbrev-p t)
;; ;; using a global abbreviation table
;; ;; (flyspell-use-global-abbrev-table-p t)


;; instead of having this set to mouse 2 I rebind it to mouse three
(setq flyspell-mouse-map
      (let ((map (make-sparse-keymap)))
        (define-key map [down-mouse-3] #'flyspell-correct-word)
        map))

;; ;; my modes where I add either flyspell or flyspell programming
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
(add-hook 'c++-mode-common-hook 'flyspell-prog-mode)
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode)
(add-hook 'c++-mode-hook 'flyspell-prog-mode)
(add-hook 'ruby-mode-hook 'flyspell-prog-mode)
(add-to-list 'flyspell-prog-text-faces 'nxml-text-face)


;; ;; ignore latex specific commands this is set for tex-mode but not for
;; ;; LaTex-mode
;; (put 'LaTex-mode 'flyspell-mode-predicate 'tex-mode-flyspell-verify)
;; (add-hook 'tex-mode-hook (lambda () (setq ispell-parser 'tex)))


;; ;; example from wikie
;; ;; (dolist (hook '(text-mode-hook))
;; ;;    (add-hook hook (lambda () (flyspell-mode 1))))
;; ;; (dolist (hook '(emacs-lisp-mode-hook))
;; ;;    (add-hook hook (lambda () (flyspell-mode 1))))


;; ;; (dolist (hook '(change-log-mode-hook log-edit-mode-hook))
;; ;;   (add-hook hook (lambda () (flyspell-mode -1))))