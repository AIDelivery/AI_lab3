(defrule data-input
  (initial-fact)
=>
  (printout t crlf "Number of days until exam (integer): ")
  (bind ?days (read))

 (if (numberp ?days)
	then (assert (days ?days))
	else (printout t crlf "Input number: " crlf))


  (printout t "Number of finished LR (%): ")
  (bind ?works (read))
  (assert (works ?works))

  (printout t "Temperature (celsium): ")
  (bind ?temp (read))
  (assert (temp ?temp))

  (printout t "Weather (sun/rain/snow/cloudy): ")
  (bind ?weather (read))
  (assert (weather ?weather)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule WR1
  (declare(salience 10))
  (temp ?temp)
  (weather ?weather)
  (test
    (or
      (and (= (str-compare ?weather "rain") 0) (< temp -15))
      (and (= (str-compare ?weather "snow") 0) (< temp -15))
    )
  )
  =>
  (printout t crlf "[Bad weather]")
  (assert (wt_bonus "bad"))
)

(defrule WR2
  (declare(salience 10))
  (temp ?temp)
  (weather ?weather)
  (test
    (or
      (and (= (str-compare ?weather "sun") 0) (< ?temp -15))
      (and (= (str-compare ?weather "cloudy") 0) (< ?temp -15))
    )
  )
  =>
  (printout t crlf "[The weather could be better]")
  (assert (wt_bonus "bearable"))
)

(defrule WR3
  (declare(salience 10))
  (temp ?temp)
  (weather ?weather)
  (test
    (and
      (and (>= ?temp -15) (< ?temp 5))
      (or (= (str-compare ?weather "sun") 0) (= (str-compare ?weather rain) 0))
    )
  )
  =>
  (printout t crlf "[Pretty good weather]")
  (assert (wt_bonus "good"))
)

(defrule WR4
  (declare(salience 10))
  (temp ?temp)
  (weather ?weather)
  (test
    (and
      (and (>= ?temp -15) (< ?temp 5))
      (or (= (str-compare ?weather "snow") 0) (= (str-compare ?weather "cloudy") 0))
    )
  )
  =>
  (printout t crlf "[Normal weather]")
  (assert (wt_bonus "normal"))
)

(defrule WR5
  (declare(salience 10))
  (temp ?temp)
  (weather ?weather)
  (test
    (and
      (and (>= ?temp 5) (< ?temp 20))
      (or (= (str-compare ?weather "rain") 0) (= (str-compare ?weather "cloudy") 0))
    )
  )
  =>
  (printout t crlf "[Good weather]")
  (assert (wt_bonus "good"))
)

(defrule WR6
  (declare(salience 10))
  (temp ?temp)
  (weather ?weather)
  (test
    (and
      (and (>= ?temp 5) (< ?temp 20))
      (or (= (str-compare ?weather "snow") 0) (= (str-compare ?weather "sun") 0))
    )
  )
  =>
  (printout t crlf "[Bad weather]")
  (assert (wt_bonus "bad"))
)

(defrule WR7
  (declare(salience 10))
  (temp ?temp)
  (weather ?weather)
  (test
    (and
      (>= ?temp 20)
      (or (= (str-compare ?weather "rain") 0) (= (str-compare ?weather "sun") 0))
    )
  )
  =>
  (printout t crlf "[Great weather]")
  (assert (wt_bonus "great"))
)

(defrule WR8
  (declare(salience 10))
  (temp ?temp)
  (weather ?weather)
  (test
    (and
      (>= ?temp 20)
      (or (= (str-compare ?weather "snow") 0) (= (str-compare ?weather "cloudy") 0))
    )
  )
  =>
  (printout t crlf "[Bad weather]")
  (assert (wt_bonus "bad"))
)


(defrule FTR1
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (= ?days 0)
      (<= ?works 0)
    )
  )
  =>
  (printout t crlf "[Zero chance]")
  (assert (time_bonus 0))
)

(defrule FTR2
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (= ?days 0)
      (and (> ?works 0) (<= ?works 15))
    )
  )
  =>
  (printout t crlf "[No chance]")
  (assert (time_bonus 1))
)

(defrule FTR3
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (= ?days 0)
      (and (> ?works 15) (<= ?works 50))
    )
  )
  =>
  (printout t crlf "['Like, maybe' chance]")
  (assert (time_bonus 3))
)

(defrule FTR4
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (= ?days 0)
      (and (> ?works 50) (< ?works 100))
    )
  )
  =>
  (printout t crlf "['Maybe' chance]")
  (assert (time_bonus 5))
)

(defrule FTR5
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (= ?days 0)
      (= ?works 100)
    )
  )
  =>
  (printout t crlf "[Still the whole night ahead]")
  (assert (time_bonus 6))
)

(defrule FTR6
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (= ?days 1)
      (<= ?works 0)
    )
  )
  =>
  (printout t crlf "[Zero chance]")
  (assert (time_bonus 0))
)

(defrule FTR7
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (= ?days 1)
      (and (> ?works 0) (<= ?works 15))
    )
  )
  =>
  (printout t crlf "[No chance]")
  (assert (time_bonus 1))
)

(defrule FTR8
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (= ?days 1)
      (and (> ?works 15) (<= ?works 50))
    )
  )
  =>
  (printout t crlf "['Maybe' chance]")
  (assert (time_bonus 3))
)

(defrule FTR9
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (= ?days 1)
      (and (> ?works 50) (< ?works 100))
    )
  )
  =>
  (printout t crlf "[Bearable, I assume...]")
  (assert (time_bonus 4))
)

(defrule FTR10
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (= ?days 1)
      (= ?works 100)
    )
  )
  =>
  (printout t crlf "[Pretty bearable]")
  (assert (time_bonus 6))
)

(defrule FTR11
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (and (>= ?days 2) (< ?days 4))
      (<= ?works 0)
    )
  )
  =>
  (printout t crlf "['Like, maybe' chance]")
  (assert (time_bonus 2))
)

(defrule FTR12
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (and (>= ?days 2) (< ?days 4))
      (and (> ?works 0) (<= ?works 15))
    )
  )
  =>
  (printout t crlf "['Maybe' chance]")
  (assert (time_bonus 3))
)

(defrule FTR13
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (and (>= ?days 2) (< ?days 4))
      (and (> ?works 15) (<= ?works 50))
    )
  )
  =>
  (printout t crlf "['Maybe' chance]")
  (assert (time_bonus 5))
)

(defrule FTR14
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (and (>= ?days 2) (< ?days 4))
      (and (> ?works 50) (< ?works 100))
    )
  )
  =>
  (printout t crlf "['I can do it' chance]")
  (assert (time_bonus 6))
)

(defrule FTR15
  (declare(salience 10))
  (days ?days)
	(works ?works)
  (test
    (and
      (and (>= ?days 2) (< ?days 4))
      (= ?works 100)
    )
  )
  =>
  (printout t crlf "[Peace of cake]")
  (assert (time_bonus 9))
)

(defrule FTR16
  (declare(salience 10))
  (days ?days)
  (test (>= ?days 4))
  =>
  (printout t crlf "[Easy-peasy!]")
  (assert (time_bonus 15))
)


(defrule RMIN
  (declare(salience 20))
  (time_bonus ?time_bonus)
  (wt_bonus ?wt_bonus)
  (test
    (< ?time_bonus 3)
  )
  =>
  (printout t crlf crlf "YOU FAILED")
  (printout t crlf "[RMIN]" crlf)
  (exit)
)

(defrule RMAX
  (declare(salience 20))
  (time_bonus ?time_bonus)
  (wt_bonus ?wt_bonus)
  (test
    (>= ?time_bonus 15)
  )
  =>
  (printout t crlf crlf "YOU PASS")
  (printout t crlf "[RMAX]" crlf)
  (exit)
)

(defrule R1
  (declare(salience 20))
  (time_bonus ?time_bonus)
  (wt_bonus ?wt_bonus)
  (test
    (and
      (and (< ?time_bonus 5) (>= ?time_bonus 3))
      (<> (str-compare ?wt_bonus "great") 0)
    )
  )
  =>
  (printout t crlf crlf "YOU FAILED")
  (printout t crlf "[R1]" crlf)
  (exit)
)

(defrule R2
  (declare(salience 20))
  (time_bonus ?time_bonus)
  (wt_bonus ?wt_bonus)
  (test
    (and
      (>= ?time_bonus 3) (< ?time_bonus 5)
      (= (str-compare ?wt_bonus "great") 0)
    )
  )
  =>
  (printout t crlf crlf "YOU CAN DO IT")
  (printout t crlf "[R2]" crlf)
  (exit)
)

(defrule R3
  (declare(salience 20))
  (time_bonus ?time_bonus)
  (wt_bonus ?wt_bonus)
  (test
    (and
      (>= ?time_bonus 5) (< ?time_bonus 9)
      (and (<> (str-compare ?wt_bonus "bad") 0) (<> (str-compare ?wt_bonus "bearable") 0))
    )
  )
  =>
  (printout t crlf crlf "YOU CAN DO IT")
  (printout t crlf "[R3]" crlf)
  (exit)
)

(defrule R4
  (declare(salience 20))
  (time_bonus ?time_bonus)
  (wt_bonus ?wt_bonus)
  (test
    (and
      (>= ?time_bonus 5) (< ?time_bonus 9)
      (or (= (str-compare ?wt_bonus "bad") 0) (= (str-compare ?wt_bonus "bearable") 0))
    )
  )
  =>
  (printout t crlf crlf "YOU FAILED")
  (printout t crlf "[R4]" crlf)
  (exit)
)

(defrule R5
  (declare(salience 20))
  (time_bonus ?time_bonus)
  (wt_bonus ?wt_bonus)
  (test
    (and
      (>= ?time_bonus 9) (< ?time_bonus 15)
      (<> (str-compare ?wt_bonus "bad") 0)
    )
  )
  =>
  (printout t crlf crlf "YOU PASS")
  (printout t crlf "[R5]" crlf)
  (exit)
)

(defrule R6
  (declare(salience 20))
  (time_bonus ?time_bonus)
  (wt_bonus ?wt_bonus)
  (test
    (and
      (>= ?time_bonus 9) (< ?time_bonus 15)
      (= (str-compare ?wt_bonus "bad") 0)
    )
  )
  =>
  (printout t crlf crlf "YOU CAN DO IT")
  (printout t crlf "[R6]" crlf)
  (exit)
)

(reset)
(run)
2
100
15
sun
(facts)
(exit)
