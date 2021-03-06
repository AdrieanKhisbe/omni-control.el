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
;; §TODO: doc... (draft before disovered hydra existance)
;; Some inspiration where found on very good `god-mode' about the keymap implementation
;;

;;; Building Notes:

;; §maybe: quickly require bindkey? or see how to batch declara command binds.

;;; Code:

(defcustom omni-control-error-max-count 5 "Number of consecutive commands that force to go back to normal \"flight conditions\"."
 :group 'omni-control :type 'numeric)
(defvar omni-control-error-count 0 "Consecutive number of wrong command.")

(defvar omni-control-mode-map
  (let ((map (make-sparse-keymap)))
    (suppress-keymap map t) ; vire les self insert key [du coup garde autres bindings]
    (define-key map [remap self-insert-command] 'omni-control-no-command) ;; remplace self insert by commande spécifiée
    ;; keep all the Control, meta function and so on . (which is rather good in fact :)
    map))

(defun omni-control-no-command()
  "Warn no command"
  (interactive) ;; should not be called directly. maybe use a lambda?
  ;; §todo: disable mode after some time.
  (if (< omni-control-error-count omni-control-error-max-count)
      (progn
        (omni-control-warn "Not such control on the handlever!")
        (setq omni-control-error-count (1+ omni-control-error-count)))
      (progn
        (omni-control-warn "You drive like a fool, manual control disabled!")
        (setq omni-control-error-count 0)
        (omni-control-mode -1))))

;; (lookup-key omni-control-mode-map "


;; commands to create
;; ¤note §todo: store this in generic set? (to try them, then select)

(defvar omni-control-panel-proto
  '(("ESC" . omni-control-mode)

    ;; ¤>> left hand

  ("a" . ace-jump-line-mode)
    ("z" . ace-jump-word-mode)
    ("e" . ace-jump-char-mode)


    ;; ¤>> right hand
    ("p" . forward-char)
    ("o" . forward-word)
    ("i" . forward-symbol)
    ("u" . forward-line)
    ("y" . forward-paragraph)

    ("m" . backward-char)
    ("l" . backward-word)
    ("k" . backward-symbol) ; don't exist!! (lambda with forward?) [kill??]
    ("j" . backward-line)
    ("h" . backward-paragraph)
    ;; §maybe switch to inverse. (put in different panel)

    ("n" . scroll-down-command)
    ("b" . scroll-up-command)
    )
  "Prototype pannel.

 (Alist with key commands cells)")

;; §later: switch for prefix arg?
;; (wraper function setting prefix var before to call?)

(defun omni-control-load-panel (panel)
  "Populate keymap with given PANEL."
  (interactive)
  ;; §later: reinit keymap -> maybe not if different panel defined and combined!!
  ;; §later: format check. [unless this is made a custom]
  (mapc (lambda (cell)
          (define-key omni-control-mode-map (car cell) (cdr cell))) panel)
  ;; return command map.
  omni-control-mode-map)

;; §tmp: load proto pannel
(omni-control-load-panel omni-control-panel-proto)

;; ¤doc To set map:
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
  (if omni-control-mode
      (omni-control-warn "Flight mode on")
    (omni-control-warn "Flight mode off")))

;; ¤helper
(defun omni-control-warn (message)
  "Print MESSAGE with given face."
  (message (propertize message 'face 'font-lock-keyword-face)))

(provide 'omni-control)
;;; omni-control.el ends here
