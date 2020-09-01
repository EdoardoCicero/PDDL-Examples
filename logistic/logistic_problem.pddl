(define (problem logistic)
	(:domain logistic-domain)
	(:objects 
	    truck1 truck2 - truck
		gas_station1 - gas_station
		foundry1 - foundry
		airport1 - airport
		iron1 - iron
		iron_ingot1 - iron_ingot
		iron_site1 - iron_site
		garage1 garage2 - garage
		city1 city2 city3 - city
		plane1 plane2 - plane
		cross1 - cross

	)

	(:init 
		(at truck1 garage1) (at truck2 garage2) (in plane1 airport1) (in plane2 airport1)
		(connected garage1 gas_station1) (connected gas_station1 garage1) (connected garage1 cross1) (connected cross1 garage1)
		(connected iron_site1 cross1) (connected cross1 iron_site1) (connected cross1 gas_station1) (connected gas_station1 cross1)
		(connected cross1 foundry1) (connected foundry1 cross1) (connected foundry1 garage2) (connected garage2 foundry1)
		(connected garage2 gas_station1) (connected gas_station1 garage2) (connected gas_station1 airport1) (connected airport1 gas_station1)
		(connected garage2 airport1) (connected airport1 garage2)
		(connected airport1 city1) (connected airport1 city2) (connected airport1 city3)
		

		
		(= (total-cost) 0)
		(= (capacity truck1) 50)
		(= (capacity truck2) 100)
		(= (fuel truck1) 100)
		(= (fuel truck2) 100)
		(= (max_fuel truck1) 100)
		(= (max_fuel truck2) 100)
		(= (capacity plane1) 100)
		(= (capacity plane2) 100)
		(= (action-cost) 10)

		(= (obj_in_place iron1 city1) 0)
		(= (obj_in_place iron1 city2) 0)
		(= (obj_in_place iron1 city3) 0)
		(= (obj_in_place iron1 airport1) 0)
		(= (obj_in_place iron1 foundry1) 0)
		(= (obj_in_place iron1 iron_site1) 100)
		(= (obj_in_place iron_site1 city1) 0)
		(= (obj_in_place iron_site1 city2) 0)
		(= (obj_in_place iron_site1 city3) 0)
		(= (obj_in_place iron_site1 airport1) 0)
		(= (obj_in_place iron_site1 foundry1) 0)
		(= (obj_in_place iron_site1 iron_site1) 0)

    
		
	) 

	(:goal (and (= (obj_in_place iron1 city1) 100)))
		

)
