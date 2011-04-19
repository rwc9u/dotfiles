;;; autopair.el --- Automagically pair braces and quotes like TextMate

;; Copyright (C) 2009 João Távora

;; Author: João Távora <joaotavora [at] gmail.com>
;; Keywords: convenience, emulations
;; Version: 0.2

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Another stab at making braces and quotes pair like in
;; TextMate:
;; 
;; * Opening braces/quotes are autopaired;
;; * Closing braces/quotes are autoskipped;
;; * Backspacing an opening brace/quote autodeletes its pair.
;;
;; Autopair deduces from the current syntax table which characters to
;; pair, skip or delete.
;;
;;; Installation:
;;
;;   (require 'autopair)
;;   (autopair-global-mode) ;; to enable in all buffers
;;
;; To enable autopair in just some types of buffers, comment out the
;; `autopair-global-mode' and put autopair-mode in some major-mode
;; hook, like:
;;
;; (add-hook 'c-mode-common-hook #'(lambda () (autopair-mode)))
;;
;; Alternatively, do use `autopair-global-mode' and create
;; *exceptions* using the `autopair-dont-activate' local variable,
;; like:
;;
;; (add-hook 'c-mode-common-hook #'(lambda () (setq autopair-dont-activate t)))
;;
;;; Use:
;; 
;; The extension works by rebinding the braces and quotes keys, but
;; can still be minimally intrusive, since the original binding is
;; always called as if autopair did not exist.
;;
;; The decision of which keys to actually rebind is taken at
;; minor-mode activation time, based on the current major mode's
;; syntax tables. To achieve this kind of behaviour, an emacs
;; variable `emulation-mode-map-alists' was used.
;;
;; If you set `autopair-pair-criteria' and `autopair-skip-criteria' to
;; 'help-balance (which, by the way, is the default), braces are not
;; autopaired/autoskiped in all situations; the decision to autopair
;; or autoskip a brace is taken according to the following table:
;;
;;  +---------+------------+-----------+-------------------+
;;  | 1234567 | autopair?  | autoskip? | notes             |
;;  +---------+------------+-----------+-------------------+
;;  |  (())   |  yyyyyyy   |  ---yy--  | balanced          |
;;  +---------+------------+-----------+-------------------+
;;  |  (()))  |  ------y   |  ---yyy-  | too many closings |
;;  +---------+------------+-----------+-------------------+
;;  |  ((())  |  yyyyyyy   |  -------  | too many openings |
;;  +---------+------------+-----------+-------------------+
;;
;; The table is read like this: in a buffer with 7 characters laid out
;; like the first column, an "y" marks points where an opening brace
;; is autopaired and in which places would a closing brace be
;; autoskiped.
;;
;; Quote pairing sports similar "intelligence".
;;
;; For further customization have a look at `autopair-dont-pair',
;; which lets you define special cases of characters you don't want
;; paired.  Its default value skips pairing single-quote characters
;; when inside a comment literal, even if the language syntax tables
;; does pair these characters.
;;
;; As a further example, to also prevent the '{' (opening brace)
;; character from being autopaired in C++ comments use this in your
;; .emacs.
;;
;; (add-hook 'c++-mode-hook
;;           #'(lambda ()
;;                (push ?{
;;                      (getf autopair-dont-pair :comment))))
;;                      
;;; Bugs:
;;
;; * Quote pairing/skipping inside comments is not perfect...
;;
;;; Credit:
;;
;; Thanks Ed Singleton for early testing.
;;
;;; Code:

;; requires
(require 'cl)

;; variables
(defvar autopair-pair-criteria 'help-balance
  "If non-nil, be more criterious when pairing opening brackets.")

(defvar autopair-skip-criteria 'help-balance
  "If non-nil, be more criterious when skipping closing brackets.")

(defvar autopair-emulation-alist (cons t (make-sparse-keymap))
  "A dinamic keymap for autopair set mostly from the current
  syntax table.")
(make-variable-buffer-local 'autopair-emulation-alist)

(defvar autopair-dont-activate nil
  "If non-nil `autopair-global-mode' does not activate in buffer")
(make-variable-buffer-local 'autopair-dont-activate)

(defvar autopair-dont-pair `(:string (?'):comment  (?'))
  "Characters for which to skip any pairing behaviour.

This variable overrides `autopair-pair-criteria'. It does not
  (currently) affect the skipping behaviour.

It's a Common-lisp-style even-numbered property list, each pair
of elements being of the form (TYPE , CHARS). CHARS is a list of
characters and TYPE can be one of:

:string : whereby characters in CHARS will not be autopaired when
          inside a string literal

:comment : whereby characters in CHARS will not be autopaired when
          inside a comment

:never : whereby characters in CHARS won't even have their
         bindings replaced by autopair's. This particular option
         should be used for troubleshooting and requires
         `autopair-mode' to be restarted to have any effect.")

(make-variable-buffer-local 'autopair-dont-pair)

(defvar autopair-action nil
  "List (action pair pos-before) set by last autopair command, or nil.

ACTION is one of `opening',`closing' or `backspace'. PAIR is an
element of `autopair-pairs'. POS-BEFORE is value of point before
action command took place .")
(make-variable-buffer-local 'autopair-action)

;; minor mode and global mode
;; 
(define-globalized-minor-mode autopair-global-mode autopair-mode autopair-on)

(defun autopair-on () (unless autopair-dont-activate (autopair-mode 1)))

(define-minor-mode autopair-mode
  "Automagically pair braces and quotes like in TextMate."
  nil " pair" nil
  (cond (autopair-mode
         ;; Setup the dynamic emulation keymap
         ;;
         (let ((map (make-sparse-keymap)))
           (define-key map [remap delete-backward-char] 'autopair-backspace)
           (define-key map [remap backward-delete-char-untabify] 'autopair-backspace)
           (define-key map (kbd "<backspace>") 'autopair-backspace)
           (define-key map [backspace] 'autopair-backspace)
           (dotimes (char 256) ;; only searches the first 256 chars, TODO: is this enough/toomuch/stupid?
             (unless (member char
                             (getf autopair-dont-pair :never))
               (let* ((syntax-entry (aref (syntax-table) char))
                      (class (and syntax-entry
                                  (syntax-class syntax-entry)))
                      (pair (and syntax-entry
                                 (cdr syntax-entry))))
                 (cond ((eq class (car (string-to-syntax "(")))
                        (define-key map (string char) 'autopair-insert-opening)
                        (define-key map (string pair) 'autopair-skip-close-maybe))
                       ((eq class (car (string-to-syntax "\"")))
                        (define-key map (string char) 'autopair-insert-or-skip-quote))))))
           (setq autopair-emulation-alist (list (cons t map))))
         
         (setq autopair-action nil)
         (add-hook 'emulation-mode-map-alists 'autopair-emulation-alist nil 'local)
         (add-hook 'post-command-hook 'autopair-post-command-handler 'append 'local))
        (t
         (remove-hook 'emulation-mode-map-alists 'autopair-emulation-alist        'local)
         (remove-hook 'post-command-hook         'autopair-post-command-handler 'local))))

;; useful functions, mostly decision login
;;
(defun autopair-fallback (&optional fallback-keys)
  (let ((autopair-emulation-alist nil)
        (command (or (key-binding (this-single-command-keys))
                     (key-binding fallback-keys))))
    (call-interactively command)))

(defun autopair-document-bindings (&optional fallback-keys)
  (concat 
   "Works by scheduling possible autopair behaviour, then calls
original command as if autopair didn't exist"
   (when (eq this-command 'describe-key)
     (let* ((autopair-emulation-alist nil)
            (command (or (key-binding (this-single-command-keys))
                         (key-binding fallback-keys))))
       (when command
         (format ", which in this case is `%s'" command))))
   "."))

(defun autopair-skip-p ()
  (interactive)
  (and (eq (char-after (point)) last-input-event)
       (cond ((eq autopair-skip-criteria 'help-balance)
              (save-excursion
                (condition-case err
                    (progn
                      (up-list (car (syntax-ppss)))
                      t)
                  (error nil))))
             ((eq autopair-skip-criteria 'need-opening)
              (save-excursion
                (condition-case err
                    (progn
                      (backward-list)
                      t)
                  (error nil))))
             (t
              t))))

(defun autopair-following-quote-p (&optional quick-syntax-info)
  (let ((quick-syntax-info (or quick-syntax-info
                               (syntax-ppss))))
    (or (and (nth 3 quick-syntax-info) ;; in a string, (nth 5
                                       ;; quick-syntax-info) is not
                                       ;; reliable
             (nth 5 (parse-partial-sexp (nth 8 quick-syntax-info)
                                        (point))))
        (nth 5 quick-syntax-info)))) ;; following a quote

(defun autopair-in-comment-disabled-p (&optional quick-syntax-info)
  (let ((quick-syntax-info (or quick-syntax-info
                               (syntax-ppss))))
    (and (nth 4 quick-syntax-info) ;; in a comment
         (member last-input-event
                 (getf autopair-dont-pair :comment)))))

(defun autopair-in-string-disabled-p (&optional quick-syntax-info)
  (let ((quick-syntax-info (or quick-syntax-info
                               (syntax-ppss))))
    (and (nth 3 quick-syntax-info) ;; in a string
         (member last-input-event
                 (getf autopair-dont-pair :string)))))

(defun autopair-pair-p ()
  (let ((syntax-info (syntax-ppss)))
    (unless (or (autopair-in-comment-disabled-p syntax-info)
                (autopair-in-string-disabled-p syntax-info))
      (cond ((eq autopair-pair-criteria 'help-balance)
             (and (not (autopair-following-quote-p))
                  (save-excursion
                    (condition-case err
                        (up-list (car (syntax-ppss)))
                      (error nil))
                    (condition-case err
                        (progn
                          (forward-list (point-max))
                          t)
                      (error
                       ;; the following `eq' should signal that this is a
                       ;; scan-error of type is "... ends prematurily"
                       (eq (fourth err) (point-max)))))))
            ((eq autopair-pair-criteria 'always)
             t)
            (t
             (not (autopair-following-quote-p))
             )))))

(defun autopair-find-pair (&optional delim by-closing-delim-p)
  (let ((syntax-entry (aref (syntax-table) (or delim
                                               last-input-event))))
    (cond ((eq (syntax-class syntax-entry) (car (string-to-syntax "(")))
           (cdr syntax-entry))
          ((eq (syntax-class syntax-entry) (car (string-to-syntax "\"")))
           delim)
          (t
           nil))))

;; interactive
;; 
(defun autopair-insert-or-skip-quote ()
  (interactive)
  (let* ((syntax-info (syntax-ppss))
         (inside-string (nth 3 syntax-info))) ;;inside-string is the quote character itself 
    (unless (autopair-following-quote-p syntax-info)
      (cond (;; skipping decision
             ;; 
             (and (eq last-input-event (char-after (point)))
                  (or
                   ;; possibly skip the quote if ww're already inside a
                   ;; string and the string starts with the character just
                   ;; inserted
                   (and inside-string
                        (eq last-input-event inside-string))
                   ;; possible skip the quote if we're in a comment in a
                   ;; quote-after-quote situarion (the inside-string
                   ;; criterion does not work here...)
                   (and (nth 4 syntax-info) 
                        (eq last-input-event (char-after (1- (point)))))))
             (setq autopair-action (list 'skip-quote last-input-event (point))))
            (;; pairing decision
             ;; 
             (not (or (eq last-input-event inside-string)
                      (autopair-in-comment-disabled-p syntax-info)
                      (autopair-in-string-disabled-p syntax-info)))
             (setq autopair-action (list 'insert-quote last-input-event (point))))))
    (autopair-fallback)))

  (put 'autopair-insert-or-skip-quote 'function-documentation
     '(concat "Insert or possibly skip over a quoting character.\n\n"
              (autopair-document-bindings)))

(defun autopair-insert-opening ()
  (interactive)
  (when (autopair-pair-p)
    (setq autopair-action (list 'opening (autopair-find-pair) (point))))
  (autopair-fallback))
(put 'autopair-insert-opening 'function-documentation
     '(concat "Insert opening delimiter and possibly automatically close it.\n\n"
              (autopair-document-bindings)))

(defun autopair-skip-close-maybe ()
  (interactive)
  (when (autopair-skip-p)
    (setq autopair-action (list 'closing last-input-event (point))))
  (autopair-fallback))
(put 'autopair-skip-close-maybe 'function-documentation
     '(concat "Insert or possibly skip over a closing delimiter.\n\n"
               (autopair-document-bindings)))

(defun autopair-backspace ()
  (interactive)
  (setq autopair-action (list 'backspace (autopair-find-pair (char-after (1- (point)))) (point)))
  (autopair-fallback (kbd "DEL")))
(put 'autopair-backspace 'function-documentation
     '(concat "Possibly delete a pair of paired delimiters.\n\n"
              (autopair-document-bindings (kbd "DEL"))))

;; post-command-hook stuff
;;
(defun autopair-post-command-handler ()
  "Inserts,deletes or skips over pairs based on `autopair-action'. "
  (let ((action (first autopair-action))
        (pair (second autopair-action))
        (pos-before (third autopair-action)))
    (when (and action
               pair
               pos-before)
      (autopair-handle-action action pair pos-before))
    (setq autopair-action nil)))

(defun autopair-handle-action (action pair pos-before)
  (cond (;; automatically insert closing delimiter
         (eq 'opening action)
         (insert pair)
         (backward-char 1))
        (;; automatically insert closing quote delimiter 
         (eq 'insert-quote action)
         (insert pair)
         (backward-char 1))
        (;; automatically skip oper closer quote delimiter
         (eq 'skip-quote action)
         (delete-char 1))
        (;; skip over newly-inserted-but-existing closing delimiter
         ;; (normal case)
         (eq 'closing action)
         (delete-char 1))
        (;; autodelete closing delimiter
         (and (eq 'backspace action)
              (eq pair (char-after (point))))
         (delete-char 1))))


(provide 'autopair)
;;; autopair.el ends here


