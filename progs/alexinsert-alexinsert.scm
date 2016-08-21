
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

;to activate the plugin:
;   1) press the "plus" button at the top level, choose "alexinsert"
;   2) in the insert menu the 2 additional buttons should appear

(texmacs-module (alexinsert-alexinsert)
  (:use (utils plugins plugin-eval)))

(use-modules (ice-9 format))
(use-modules(ice-9  regex))
;(use-modules (srfi srfi-1));this causes the plugin to crash

(tm-define (labello-insert t)
  (and-with p (tree-outer t)
    (labello-insert p)))

(tm-define (labello-insert t)
  (:require (tree-is-buffer? t))
  (let((suggestion (text->label(format #f "~s"  (focus-tree)))))
    (dialogue-window (form3 suggestion) (lambda (x) (insert (list 'label x) )) "Insert the label")
          ))

;TODO:
    ;make sure label is unique (<-- we need reference list for that)

;INGRIDIENTS
;(for ref)make the menu (??: how to build the menu):    /Users/nailbiter/Downloads/TeXmacs-1.99.5-src//TeXmacs/doc/devel/scheme/gui/scheme-gui-dialogs.en.tm
;(for label/ref)be able to get the list of all labels (HOW TO DO IT???)

;FIXME:
    ;insert label at the beginning of the theorem?

(tm-define (make-labello)
  (labello-insert (focus-tree)))

(tm-widget ((form3 default) cmd)
  (resize "500px" "500px"
    (padded
      (form "Test"
        (aligned
          (item (text "Label: ")
            (form-input "label" "string" (list default) "1w"))
          )
        (bottom-buttons
          ("Cancel" (noop)) >>
          ("Ok"
           (cmd (format #f "~a" (car (form-values))))))))))

(define (text->label text) (let*(
                                (match(string-match "<\\\\([^>]*)>" text))
                                (thmtype(match:substring match 1))
                                (thmtype((lambda(s)(cond
                                                     ((string=? s "proposition")"prop")
                                                     ((string=? s "theorem")"thm")
                                                     (else thmtype)))thmtype))
                                (body (string-drop text (+ 2(string-index text #\> ))));FIXME: this +2 is sort of empirical
                                (body(string-take body(+ -1 (string-index body #\< ))));FIXME: as well as this -1
                                (body(string-split body #\space))
                                (body(filter(lambda(s)(not(or (string-null? s)(string=? s "\\;"))))body));FIXME: exmpirical
                                (body(list-head body (min (length body)3)))
                                (body (if(null? body)body(cons(car body)(map(lambda(s)(string-append "-" s))(cdr body)))))
                                ) 
                             (format #f "~a:~a"  thmtype (string-concatenate body))))
