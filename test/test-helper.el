;;; test-helper --- Test helper for omni-control

;;; Commentary:
;; test helper inspired from https://github.com/tonini/overseer.el/blob/master/test/test-helper.el

;;; Code:

(require 'f)

(defvar cpt-path
  (f-parent (f-this-file)))

(defvar omni-control-test-path
  (f-dirname (f-this-file)))

(defvar omni-control-root-path
  (f-parent omni-control-test-path))

(defvar omni-control-sandbox-path
  (f-expand "sandbox" omni-control-test-path))

(when (f-exists? omni-control-sandbox-path)
  (error "Something is already in %s. Check and destroy it yourself" omni-control-sandbox-path))

(defmacro within-sandbox (&rest body)
  "Evaluate BODY in an empty sandbox directory."
  `(let ((default-directory omni-control-sandbox-path))
     (when (f-exists? omni-control-sandbox-path)
       (f-delete default-directory :force))
     (f-mkdir omni-control-sandbox-path)
     ,@body
     (f-delete default-directory :force)))

(require 'ert)
(require 'omni-control)

;;; test-helper.el ends here
