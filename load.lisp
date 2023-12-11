;; call this to load everything we know with the current
;; environment variables, so we can already store it in
;; the image.
(defun env-value (setting)
  "Returns the value of the supplied environment variable."
  (sb-ext:posix-getenv (string-upcase (string setting))))

(defun feature-setting-p (setting)
  "Returns non-nil iff the setting is enabled."
  (let ((value (env-value (concatenate 'string "HAS_" (string-upcase (string setting))))))
    (and value (not (equal value "")))))

(format t "~& >> docker setting up environment ... ~%")
(push :docker *features*)
(push #p"/app/" ql:*local-project-directories*)
(format t "~& >> docker finished setting up environment~%")

;;; do we have base systems to load?
(format t "~& >> docker loading base systems ... ~%")
(ql:quickload :split-sequence)
(when (env-value :systems)
  (let ((systems (split-sequence:split-sequence #\Space (env-value :systems))))
    (ql:quickload systems)))
(format t "~& >> docker finished loading base systems ~%")

;;; do we have a bootable system to load?
(format t "~& >> docker loading boot ... ~%")
(when (env-value :boot)
  (let ((name (string-upcase (env-value :boot))))
    (ql:quickload name)))
(format t "~& >> docker finished loading boot ~%")

;;; getting swank up
(format t "~& >> docker loading swank ... ~%")
(ql:quickload :swank) ;; we need this toplevel
(format t "~& >> docker finished loading swank ~%")

(sb-ext:quit)
