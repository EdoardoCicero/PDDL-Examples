(define (domain logistic-domain)
	(:requirements :adl)
	(:types
		truck
		plane
		city - airport
		garage gas_station foundry iron_site cross airport - place
		iron_site foundry airport city - load_place
		iron iron_ingot - object
		truck plane - vehicle
		
		)

	(:predicates
		(at ?t - truck ?p - place)
		(in ?p - plane ?a - airport)
		(connected ?p - place ?pp - place)
		(can_reach ?p - airport ?c - airport)
		(full ?v - vehicle)
		(carry ?v - vehicle ?m - object)
		(delivered ?o - object)
		
	)

    (:functions
        (total-cost) - number
        (capacity ?v - vehicle) - number
    	(fuel ?t - truck) - number
    	(max_fuel ?t - truck) - number
    	(obj_in_place ?o - object ?p - load_place) - number
    	(action-cost) - number
    
    )

	(:action move
		:parameters (?t - truck ?from - place ?to - place)
		:precondition (and (at ?t ?from) (connected ?from ?to) (> (fuel ?t) (action-cost)))
		:effect (and (at ?t ?to) (not (at ?t ?from))
				(increase (total-cost) (action-cost))
				(decrease (fuel ?t) (action-cost)))

	)

	(:action load_truck
		:parameters (?t - truck ?place - load_place ?object - object)
		:precondition (and (at ?t ?place) (not (carry ?t ?object)) (not (full ?t))
		            (> (obj_in_place ?object ?place) 0) (not (full ?t)))
		:effect (and (full ?t) (carry ?t ?object)
		        (decrease (obj_in_place ?object ?place) (capacity ?t)) )   
		)

	(:action unload_truck
		:parameters (?t - truck ?place - load_place ?object - object)
		:precondition (and (at ?t ?place) (full ?t) (carry ?t ?object))
		:effect (and (not (full ?t)) (not (carry ?t ?object))
		        (increase (obj_in_place ?object ?place) (capacity ?t)) )
	)

	(:action refuel
		:parameters (?t - truck ?place - gas_station)
		:precondition (and (at ?t ?place) (< (fuel ?t) (max_fuel ?t)) )
		:effect (and (assign (fuel ?t) (max_fuel ?t) ) )
	)

	(:action transform
		:parameters (?f - foundry ?i - iron ?ingot - iron_ingot)
		:precondition (and (> (obj_in_place ?i ?f) 0))
		:effect (and (assign (obj_in_place ?ingot ?f) (obj_in_place ?i ?f))
					(assign (obj_in_place ?i ?f) 0))
	)
	


	(:action load_plane
		:parameters (?p - plane ?place - airport ?object - object)
		:precondition (and (in ?p ?place) (not (carry ?p ?object))
		            (> (obj_in_place ?object ?place) 0) (not (full ?p)))
		:effect (and (full ?p) (carry ?p ?object) (decrease (obj_in_place ?object ?place) (capacity ?p)))    
		)

	(:action unload_plane
		:parameters (?p - plane ?place - airport ?object - object)
		:precondition (and (in ?p ?place) (full ?p) (carry ?p ?object))
		:effect (and (not (full ?p)) (not (carry ?p ?object))
				(increase (obj_in_place ?object ?place) (capacity ?p))
				)
	)

	(:action fly
		:parameters (?p - plane ?a - airport ?b - airport)
		:precondition (and (in ?p ?a) (can_reach ?a ?b))
		:effect (and (in ?p ?b) (not (in ?p ?a)))
	)
	
	(:action deliver
	    :parameters (?o - object ?c - city)
	    :precondition (and (not (> (obj_in_place ?o ?c) 0)))
	    :effect (delivered ?o)
	)
	
	
	
)