(define (domain logistic-domain)
	(:requirements :equality :typing :adl :negative-preconditions :action-costs :conditional-effects)
	(:types
		truck
		plane
		garage airport gas_station foundry iron_site cross city - place
		iron_site foundry airport city - load_place
		iron iron_ingot - object
		city - airport
		truck plane - vehicle
		)

	(:predicates
		(at ?t - truck ?p - place)
		(in ?p - plane ?a - airport)
		(connected ?p - place ?pp - place)
		(can_fly_to ?p - plane ?c - city)
		(full ?v - vehicle)
		(carry ?v - vehicle ?m - object)
		
	)

    (:functions
        (total-cost)
        (capacity ?v - vehicle)
        
    	(fuel ?t - truck)
    	(max_fuel ?t - truck)
    	(obj_in_place ?o - object ?p - load_place)
    	(action-cost)
    
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
		:precondition (and (at ?t ?place) (> (obj_in_place ?object ?place) 0) (not (full ?t)))
		:effect (and (full ?t) (carry ?t ?object) )    
		)

	(:action unload_truck
		:parameters (?t - truck ?place - load_place ?object - object)
		:precondition (and (at ?t ?place) (full ?t))
		:effect (and (not (full ?t)) (increase (obj_in_place ?object ?place) (capacity ?t)) )
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
		:precondition (and (in ?p ?place) (> (obj_in_place ?object ?place) 0) (not (full ?p)))
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
		:parameters (?p - plane ?a - airport ?c - city)
		:precondition (and (in ?p ?a) (connected ?a ?c))
		:effect (and (in ?p ?c) (not (in ?p ?a)))
	)
)