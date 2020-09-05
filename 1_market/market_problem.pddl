(define (problem market)
	(:domain market-domain)
		(:objects
			robot customer1 customer2 freezer frozen_food fruit bakery personal_care meat center
		)
		(:init
			(robot robot) (customer customer1) (customer customer2) (section frozen_food) (section fruit)
			(section bakery) (section personal_care) (section meat) (section center) (freezer freezer)

			(next center fruit) (next fruit meat) (next meat frozen_food) (next frozen_food bakery)
			(next bakery personal_care) (next personal_care center)
			(next fruit center ) (next meat fruit) (next frozen_food meat) (next bakery frozen_food)
			(next personal_care bakery) (next center personal_care)


			(at robot center) (at freezer frozen_food) (at customer1 bakery) (at customer2 personal_care)
			(need_help customer1) (need_help customer2))
		(:goal
			(and (customer_helped customer1) (customer_helped customer2) (light_on_at meat) (fixed freezer)))
)