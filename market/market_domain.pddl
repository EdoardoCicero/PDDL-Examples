(define (domain market-domain)
    (:requirements :strips)
    (:predicates
        (light_on_at ?x) (customer_helped ?x) (fixed ?x) (customer_at ?x)
        (next ?section_x ?section_y) (at ?x ?section) (robot ?r) (section ?s) (customer ?c)
        (need_help ?c) (freezer ?f))

    (:action move
		:parameters (?r ?from_section ?to_section)
		:precondition (and (robot ?r) (section ?from_section)
			            (section ?to_section) (at ?r ?from_section) (next ?from_section ?to_section))
		:effect (and (at ?r ?to_section)
			
			(not (at ?r ?from_section)))
		)

	(:action help
		:parameters (?r ?section ?c)
		:precondition	(and (robot ?r) (customer ?c) (at ?r ?section) (at ?c ?section) (need_help ?c))
		:effect			(and (customer_helped ?c)))

	(:action fix
		:parameters (?r ?section ?f)
		:precondition	(and (robot ?r) (at ?r ?section) (at ?f ?section) (freezer ?f)
			(not (fixed ?f)))
		:effect 
			(and (fixed ?f)))

	(:action turn_on
		:parameters (?r ?section)
		:precondition	(and (robot ?r) (at ?r ?section) (section ?section)
			(not (light_on_at ?section)))
		:effect 	(and (light_on_at ?section)))
	)