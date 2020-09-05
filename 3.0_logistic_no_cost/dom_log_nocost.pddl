(define (domain logistic-domain)
	(:requirements :adl :typing :conditional-effects :universal-preconditions)
	(:types
        iron_site
		city - airport
		iron_site foundry airport city - load_place
		garage gas_station foundry iron_site cross airport - place
		
		iron iron_ingot - object
		truck plane - vehicle

		)

	(:predicates
		(at ?t - truck ?p - place)
		(in ?p - plane ?a - airport)
		(connected ?p - place ?pp - place)
		(can_reach ?p - airport ?c - airport)
		(carry ?v - vehicle ?m - object)
		(delivered ?o - object)
		(obj_in_place ?o  - object ?p - place)
		(is_site ?i - load_place)

	)

	(:action move
		:parameters (?t - truck ?from - place ?to - place)
		:precondition (and (at ?t ?from) (connected ?from ?to) )
		:effect (and (at ?t ?to) (not (at ?t ?from))
				)
		
	)

	(:action load_truck
		:parameters (?t - truck ?place - load_place ?object - object)
		:precondition (and (at ?t ?place) (obj_in_place ?object ?place) (forall (?object - object) (not (carry ?t ?object))) )
		              
		:effect (and (when (is_site ?place) (obj_in_place ?object ?place)) (when (not (is_site ?place)) (not (obj_in_place ?object ?place)))
		            (carry ?t ?object)
		            )   
	)

	(:action unload_truck
		:parameters (?t - truck ?place - load_place ?object - object)
		:precondition (and (at ?t ?place) (carry ?t ?object))
		:effect (and (not (carry ?t ?object)) (obj_in_place ?object ?place) 
		           )
	)


	(:action transform
		:parameters (?f - foundry ?i - iron ?ingot - iron_ingot)
		:precondition (and (obj_in_place ?i ?f) )
		:effect (and (obj_in_place ?ingot ?f) (not (obj_in_place ?i ?f) ))
	)
	


	(:action load_plane
		:parameters (?p - plane ?place - airport ?object - object)
		:precondition (and (in ?p ?place) (obj_in_place ?object ?place) (forall (?object - object) (not (carry ?p ?object))))
		            
		:effect (and (carry ?p ?object) (not (obj_in_place ?object ?place) )
		         )
		)

	(:action unload_plane
		:parameters (?p - plane ?place - airport ?object - object)
		:precondition (and (in ?p ?place) (carry ?p ?object))
		:effect (and (not (carry ?p ?object)) (obj_in_place ?object ?place)
		           )
				
	)

	(:action fly
		:parameters (?p - plane ?a - airport ?b - airport)
		:precondition (and (in ?p ?a) (can_reach ?a ?b))
		:effect (and (in ?p ?b) (not (in ?p ?a))
		        )
	)
	
	(:action deliver
	    :parameters (?o - object ?c - city)
	    :precondition (and (obj_in_place ?o ?c) )
	    :effect (and (delivered ?o) (not (obj_in_place ?o ?c)))
	)
	
	
	
)