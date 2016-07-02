
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : alexinsert-alexinsert.scm
;; DESCRIPTION : Secure routines for 'secure' plugin
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(texmacs-module (alexinsert-alexinsert)
  (:use (utils plugins plugin-eval)))

(use-modules (ice-9 format))

(tm-define (labello-insert t)
  (and-with p (tree-outer t)
    (labello-insert p)))

(tm-define (labello-insert t)
  (:require (tree-is-buffer? t))
  (begin (insert '(label "tesi me hard"))(display*(string-append "text: "
                                                    (format #f "~s" 
                                                                   (tree-outer (focus-tree)))))(insert "some text"))
  )

(tm-define (make-labello)
  (labello-insert (focus-tree)))
