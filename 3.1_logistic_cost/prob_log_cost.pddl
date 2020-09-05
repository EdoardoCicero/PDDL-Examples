(define (problem logistic)
	(:domain logistic-domain)
	(:objects 
	    truck1 truck2 - truck
		gas_station1 - gas_station
		foundry1 - foundry
		
		iron1 - iron
		iron_ingot1 iron_ingot2 iron_ingot3 - iron_ingot
		iron_site1 - iron_site
		garage1 garage2 - garage
		city1 city2 city3 - city
		airport1 - airport
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
		

		(can_reach city1 airport1) (can_reach city2 airport1) (can_reach city3 airport1)
        (can_reach airport1 city1) (can_reach airport1 city2) (can_reach airport1 city3)
		(is_site iron_site1)
		
		(obj_in_place iron1 iron_site1)
		
		(= (total-cost) 0)
		(= (drive-cost) 10)
    	(= (load-unload-cost) 2)
    	(= (fly-cost) 20)


    
		
	) 
   
	(:goal (and (delivered iron_ingot1) (delivered iron_ingot2) (delivered iron_ingot3)))
		

)
