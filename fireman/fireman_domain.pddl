(define (domain burning_house)
	(:requirements :strips :adl :conditional-effects :negative-preconditions)
	(:predicates 
		(at ?r ?x) (next ?from ?to) (holding ?x) (empty-hands ?r) (half-broken ?h) (wall-between ?x ?y) (fire-in ?x) 
		(robot ?r) (cat ?c) (hammer ?h) (extinguisher ?e) (place ?p) (safe-place ?s) (rescued ?c) (broken ?x) (empty-sack ?r) (in_sack ?c))

	(:action move
		:parameters (?r ?from ?to)
		:precondition (and (robot ?r) (at ?r ?from) (next ?from ?to) (next ?to ?from) (place ?from) (or (place ?to) (safe-place ?to))
						(not (wall-between ?from ?to)) (not (wall-between ?to ?from)) (not (fire-in ?to)))
		:effect ( and (at ?r ?to) (not (at ?r ?from)))
			 
	)
	
	(:action rescue_cat
	    :parameters (?r ?p ?c)
	    :precondition (and (robot ?r) (cat ?c) (safe-place ?p) (in_sack ?c) (at ?r ?p))
	    :effect (and (rescued ?c) (empty-sack ?r) (not (in_sack ?c)))
	    )

	(:action grab_tool
		:parameters (?r ?p ?t)
		:precondition (and (robot ?r) (place ?p) (at ?r ?p) (at ?t ?p) (empty-hands ?r) (or (hammer ?t) (extinguisher ?t))
				)
		:effect (and (holding ?t) (not (empty-hands ?r)) (not (at ?t ?p)))
	)

	(:action drop_tool
		:parameters (?r ?p ?t)
		:precondition (and (robot ?r) (place ?p) (at ?r ?p) (holding ?t) (or (hammer ?t) (extinguisher ?t)) )
		:effect (and (at ?t ?p) (empty-hands ?r) (not (holding ?t)))
	)

	(:action put_in_sack
		:parameters (?r ?p ?c)
		:precondition (and (robot ?r) (cat ?c) (place ?p) (at ?r ?p) (at ?c ?p) (empty-sack ?r))
		:effect ( and (in_sack ?c) (not (empty-sack ?r)) (not (at ?c ?p)))
	)


	(:action break_wall
		:parameters (?r ?from ?to ?h)
		:precondition (and (robot ?r) (place ?from) (place ?to) (hammer ?h) (at ?r ?from)  (wall-between ?from ?to)
						(holding ?h) (not (broken ?h)))
		:effect (and (not (wall-between ?from ?to)) (not (wall-between ?to ?from))
			(when (half-broken ?h) (broken ?h)) (when (not (half-broken ?h)) (and (half-broken ?h))))
	)

	(:action extinguish_fire
		:parameters (?r ?from ?to ?e)
		:precondition (and (robot ?r) (place ?from) (place ?to) (next ?from ?to) (next ?to ?from) (extinguisher ?e) (at ?r ?from) (fire-in ?to) (holding ?e))
		:effect (and (not (fire-in ?to)))
	)

)



