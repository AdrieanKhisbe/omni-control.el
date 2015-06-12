(require 'f)

(defvar omni-control-support-path
  (f-dirname load-file-name))

(defvar omni-control-features-path
  (f-parent omni-control-support-path))

(defvar omni-control-root-path
  (f-parent omni-control-features-path))

(add-to-list 'load-path omni-control-root-path)

(require 'omni-control)
(require 'espuds)
(require 'ert)

(Setup
 ;; Before anything has run
 )

(Before
 ;; Before each scenario is run
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )
