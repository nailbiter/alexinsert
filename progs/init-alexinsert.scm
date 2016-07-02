
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : init-world.scm
;; DESCRIPTION : Initialize the 'alexinsert' plugin
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(plugin-configure alexinsert
  (:require #t))

(when (supports-alexinsert?)
  (import-from (alexinsert-alexinsert))
   (display* "Using alex insert plug-in!\n")
         ;(tm-widget (example2) (explicit-buttons ("Hello" (noop))))
         (tm-menu (insert-menu)
                    (former)
                        ("alex insert: label"(make-labello)) 
                        ("alex insert: reference" (noop))
                        )
         )
