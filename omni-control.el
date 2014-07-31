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

;; §maybe: quickly require bindkey? or see how to batch declara command binds.

(defcustom oc:error-max-count 5 "Number of consecutive commands that force to go back to normal \"flight conditions\"."
 :group 'omni-control :type 'numeric)
(defvar oc:error-count 0 "Consecutive number of wrong command.")

(defvar omni-control-mode-map
  (let ((map (make-sparse-keymap)))
    (suppress-keymap map t) ; vire les self insert key [du coup garde autres bindings]
    (define-key map [remap self-insert-command] 'oc:no-command) ;; remplace self insert by commande spécifiée
    map))

(defun oc:no-command()
  "Warn no command"
  (interactive) ;; should not be called directly. maybe use a lambda?
  ;; §todo: disable mode after some time.
  (if (< oc:error-count oc:error-max-count)
      (progn
	(message "Not such control on the handlever!")
	(setq oc:error-count (1+ oc:error-count)))
      (progn
	(message "You drive like a fool, manual control disabled!")
	(setq oc:error-count 0)
	(omni-control-mode -1))))

(defun a () (interactive) (message "a") (notify "a" "a"))
(define-key omni-control-mode-map "a" 'a)
(lookup-key omni-control-mode-map "b") ; consulte commande


;; commands to create
;; ¤note §todo: storye this in generic set? (to try them, then select)



;; ¤doc: To set map:
;; (use-local-map omni-control-mode-map)
;; (use-local-map nil) ; for disabling

;;;###autoload
(define-minor-mode omni-control-mode
  "Temporary fast control modes."
  nil ;init-value
  :lighter " <=>"
  :keymap omni-control-mode-map
  ;; §maybe hooks
  ;; §maybe: change some color?
  (message "NOP"))


(provide 'omni-control)
;;; omni-control.el ends here
