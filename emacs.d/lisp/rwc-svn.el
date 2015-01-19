(setq svn-status-ediff-delete-temporary-files t)


(add-hook 'svn-pre-parse-status-hook 'svn-status-parse-fixup-externals-full-path)

(defun svn-status-parse-fixup-externals-full-path ()
 "Subversion 1.7 adds the full path to externals.  This
pre-parse hook fixes it up to look like pre-1.7, allowing
psvn to continue functioning as normal."
 (goto-char (point-min))
 (let (( search-string  (file-truename default-directory) ))
      (save-match-data
        (save-excursion
          (while (re-search-forward search-string (point-max) t)
          (replace-match "" nil nil)
          )))))
