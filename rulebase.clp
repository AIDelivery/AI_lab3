(defrule data-input
  (initial-fact)
=>
  (printout t crlf "Number of days until exam (integer): ")
  (bind ?days (read))

 (if (numberp ?days)
	then (assert (days ?days))
	else (printout t crlf "Input number: " crlf))


  (printout t "Number of unfinished LR (%): ")
  (bind ?works (read))
  (assert (works ?works))

  (printout t "Temperature (celsium): ")
  (bind ?temp (read))
  (assert (temp ?temp))

  (printout t "Weather (sun/rain/snow/cloudy): ")
  (bind ?weather (read))
  (assert (weather ?weather)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule TR1
  (temp ?temp)
  (test
    (>= ?temp 25))
  =>
  (printout t crlf "[Unbearably warm]")
  ;(assert (t_temp "hot"))
  (assert (t_temp -2))
)

(defrule TR2
  ;(declare(salience 10))
  (temp ?temp)
  (test
    (and (< ?temp 25) (>= ?temp 15)))
  =>
  (printout t crlf "[Warm temperature]")
  ;(assert (t_temp "warm"))
  (assert (t_temp 1))
)

(defrule TR3
  ;(declare(salience 20))
  (temp ?temp)
  (test
    (and (< ?temp 15) (>= ?temp 4)))
  =>
  (printout t crlf "[Normal temperature]")
  ;(assert (t_temp "normal"))
  (assert (t_temp 0))
)

(defrule TR4
  ;(declare(salience 30))
  (temp ?temp)
  (test
    (and (< ?temp 4) (>= ?temp -10)))
  =>
  (printout t crlf "[Pretty cold, huh?]")
  ;(assert (t_temp "cold"))
  (assert (t_temp -2))
)

(defrule TR5
  ;(declare(salience 40))
  (temp ?temp)
  (test
    (< ?temp -10))
  =>
  (printout t crlf "[Very cold]")
  ;(assert (t_temp "very cold"))
  (assert (t_temp -4))
)

(defrule WR1
  (weather ?weather)
  (test
    (= (str-compare ?weather "sun") 0))
  =>
  (printout t crlf "[Sunny day]")
  (assert (w_temp 2))
)

(defrule WR2
  (weather ?weather)
  (test
    (= ?weather cloudy))
  =>
  (printout t crlf "[Cloudy]")
  (assert (w_temp 0))
)

(defrule WR3
  (weather ?weather)
  (test
    (= ?weather snow))
  =>
  (printout t crlf "[Snow]")
  (assert (w_temp -1))
)

(defrule WR4
  (weather ?weather)
  (test
    (= ?weather rain))
  =>
  (printout t crlf "[It's raining]")
  (assert (w_temp -2))
)

(defrule R1
	(days ?days)
	(works ?works)
	(test
    (and (= ?days 0) (< ?works 15))
  )
=>
(printout t crlf crlf "BEDTIME" crlf)
(assert (freetime "not at all")))

(defrule R2
	(days ?days)
	(works ?works)
  (test
    (and (< ?days 0) (< ?works 15))
  )
=>
(printout t crlf crlf "BEDTIME" crlf)
(assert (freetime "no")))

(defrule R3
	(days ?days)
	(works ?works)
	(test (and (< ?days 3) (< ?works 70)))
=>
(printout t crlf crlf "SO-SO" crlf)
(assert (freetime "a-little")))

(defrule R4
	(days ?days)
	(works ?works)
	(test (and (< ?days 5) (< ?works 30)))
=>
(printout t crlf crlf "OK1" crlf)
(assert (freetime "a-little")))

(defrule R5
	(days ?days)
	(works ?works)
	(test (and (< ?days 5) (< ?works 70)))
=>
(printout t crlf crlf "OK2" crlf)
(assert (freetime "a-little")))

(defrule R6
	(days ?days)
	(works ?works)
	(test (and (> ?days 5) (> ?works 100)))
=>
(printout t crlf crlf "OK3" crlf)
(assert (freetime "a-little")))

(reset)
(run)
2
15
-15
sun
(facts)
(exit)
