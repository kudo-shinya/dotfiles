;;
;; keybind
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; define many keys
(defun define-many-keys (key-map key-table)
  (loop for (key . cmd) in key-table
        do (define-key key-map (read-kbd-macro key) cmd)))

;; basic keybind
(define-many-keys global-map
  '(("C-h"      . delete-backward-char)
    ("M-?"      . help-for-help)
    ("C-z"      . undo)
    ("C-c i"    . indent-region)
    ("C-c C-i"  . hippie-expand)
    ("C-c ;"    . comment-dwim)
    ("C-o"      . toggle-input-method)
    ("M-C-g"    . grep)
    ("M-g"      . goto-line)
    ("C-x C-r"  . query-replace)
    ("C-x n"    . insert-file)))
