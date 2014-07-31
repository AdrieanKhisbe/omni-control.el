;;; omni-control.el --- Navigation "handlever" map

;; Copyright (C) 2014  Adrien Becchis
;; Created:  2014-07-31
;; Version: 0.1

;; Author: Adrien Becchis <adriean.khisbe@live.fr>
;; Keywords: convenience

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

;;; Building Notes:



(defvar omni-control-mode-map
  (let ((map (make-sparse-keymap)))
    (suppress-keymap map t) ; vire les self insert key
    (define-key map [remap self-insert-command] 'oc:no-command)
    map))

(defun oc:no-command ()
  "Warn no command"
  ;; §todo: disable mode after some time.
  (message "Not such control on the handlever!"))

(defun a ()
  "DOCSTRING"
  (interactive)
  (message "a") (notify "a" "a"))

(define-key  omni-control-mode-map "a" 'a  )
(lookup-key omni-control-mode-map "b")

(use-local-map omni-control-mode-map)

(use-local-map nil) ; for disabling

;;;###autoload
(define-minor-mode omni-control-mode
  "Temporary fast control modes."
  nil ;init-value
  :lighter " <=>"
  :keymap omni-control-mode-map
  ;; maybe hooks
  (message "NOP"))


(provide 'omni-control)
;;; omni-control.el ends here
