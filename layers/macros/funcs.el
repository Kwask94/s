;;; Propertize

(defmacro with-face (STR &rest PROPS)
  "Return STR propertized with PROPS."
  `(propertize ,STR 'face (list ,@PROPS)))

;;; Anonymous Functions

(defun xi-find-args (seq)
  "Collect xi args."
  (seq-sort
   (lambda (sym1 sym2)
     (< (string-to-number (substring (symbol-name sym1) 1))
        (string-to-number (substring (symbol-name sym2) 1))))
   (seq-filter
    (lambda (x)
      (and (symbolp x) (equal 0 (string-match "x[0-9]+" (symbol-name x)))))
    (-flatten seq))))

(defmacro xi (&rest BODY)
  "Anonymous func maco, see https://ekaschalk.github.io/post/xi-macro/."
  `(lambda ,(xi-find-args BODY) ,BODY))

(defmacro xis (&rest BODY)
  "Anonymous func maco without collecting next form, for progns."
  `(lambda ,(xi-find-args BODY) ,@BODY))
