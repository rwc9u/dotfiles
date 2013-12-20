(setq exec-path (cons "/opt/local/bin" exec-path))
(setenv "PATH" (concat "/opt/local/bin:" (getenv "PATH")))

(setq exec-path (cons "/opt/local/lib/postgresql83/bin" exec-path))
(setenv "PATH" (concat "/opt/local/lib/postgresql83/bin:" (getenv "PATH")))

(setq exec-path (cons "/usr/local/bin" exec-path))
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))


;; (setq exec-path (cons "~/bin" exec-path))
;; (setenv "PATH" (concat "~/bin:" (getenv "PATH")))

(setq exec-path (cons "/usr/local/mysql/bin" exec-path))
(setenv "PATH" (concat "/usr/local/mysql/bin:" (getenv "PATH")))

(setenv "CATALINA_HOME" "/usr/local/tomcat")
(setenv "ANT_HOME" "/usr/local/ant")
(setenv "JAVA_HOME" "/System/Library/Frameworks/JavaVM.framework/Versions/1.5/Home")
(setenv "DYLD_LIBRARY_PATH" "/usr/local/instantclient_10_2")
(setenv "TNS_ADMIN" "/usr/local/instantclient_10_2")
;; (setq exec-path (cons "/usr/local/ant/bin" exec-path))
(setq exec-path (cons "/usr/local/instantclient_10_2" exec-path))
(setenv "PATH" (concat "/usr/local/instantclient_10_2:/usr/local/ant/bin:" (getenv "PATH")))
(setenv "SQLPATH" (concat "/Users/rchristie/sqlstuff:" (getenv "SQLPATH")))

;; for latex to use texlive
(setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))

