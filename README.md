# PDDL-Examples

### UPDATE 1
_Added PLANimator.exe (GUI)_

This repository contains folders of pddl examples with this structure:
- pddl domain
- pddl problem
- a graphical representation of the setting of the problem

The features highlighted are those that i could test with two planners:
- [PDDL Solver](http://solver.planning.domains/)
- [Fast Downward](http://www.fast-downward.org/)  

  
### Market problem
_Description_: A robot has to walk accross the market to help people, fix broken freezers and turn on lights when needed.

  - **Problem features**: strips

_Note_: Simple problem in closed world assumption where everything set in the init is true, everything not set is false; different predicates are used to identify the different objects like robot, customer ecc...
	that are used in the preconditions of the actions.  

  
### Fireman problem
_Description_: A robot has to save two stuck cats in a building, put them in a sack and place them in a safe place, where there are breakable walls and exstinguishible fire.
	It has to grab an exstinguisher and a hammer (not having both in hands) and use them to achieve the task.

  - **Problem features**: strips, conditional effects, negative precondition

_Conditional effect example_:<br/><br/>

	(:action break_wall<br/>
		...<br/>
		:effect (... (when (half-broken ?h) (broken ?h)) ...)<br/>
	)<br/>
<br/>
<br/>
_Note_: Conditional effects are in the effects ahd they are like "if x is true then y is true" and in this case it is used in the "break wall" action because the hammer breaks after that
	two walls are broken. When the robot hit the wall with the hammer and it was never used it becomes "half-broken" otherwise it becomes broken if it was already "half-broken".  

  
### Logistic problem
_Description_: 3 packages of mineral iron has to be transformed into iron ingots, delivered to 3 cities, there are 2 trucks that can move accross the map where there are:
	an iron site where mineral iron can be loaded on the truck, a foundry where the iron can be transformed into an iron ingot,
	an airport where 3 planes can load objects and fly back and forth to the cities and airport.
  
  - **Problem features**: strips, conditional effects, negative preconditions, typing, quantifiers

_Note_: Typing is a useful feature that assign a type to a variable in the domain file (in market example i had to use a predicate to express the "type" of an object like (robot ?r))
	and it can be specified the type of the variables that are in the preconditions of the actions. Another introduction wrt the previous examples 
	are the universal quantifiers: since a vehicle can carry any type of object but it can load one at a time they are used to check if "all objects are not being carryed by the vehicle"
	before loading it (an existential quantifier could have been used as it is the complement, like "it doesn't exist an object that is being carryed by the vehicle).  

  
### Logistic problem with cost
_Description_: Same as previous problem.

  - **Problem features**: strips, conditional effects, negative preconditions, typing, quantifiers, action cost

_Note_: here every action has a different cost, useful to plan a sequence of action considering to minimize the total cost.  

  
### Logistic problem with derivative predicates
_Description_: Similar to previous problem but here there's no action to make true that the iron ingot is been delivered.

  - **Problem features**: strips, conditional effects, negative preconditions, typing, quantifiers, action cost, derivative predicates

_Note_: Derivative predicates are a powerful and useful feature because could be used to simplify problems since i can derive that
  	if something is true then something else it is, without setting a conditional effect for every action: in this case
  	there's no more an action to set the predicate (delivered ?x) to true because i can derive that if an object is in a city it has been delivered.  

  
### Logistic problem with numbers
_Description_: Similar to logistic problem

  - **Problem features**: strips, conditional effects, negative preconditions, typing, quantifiers, action cost, numerical fluents

_Note_: Unfortunatly i could not test this example because the feature i implemented, numerical fluents, was not supported by the planners i tried,
	and so the problem and domain files surely have mistakes to fix, but i wanted to add it to the list because it was the first logistic problem i wrote.
	This is complex and interesting because the action "move" has a precondition over the quantity of fuel in the tank of the vehicle: in the precondition
	there's the check of the amount of fuel, if it is less than the cost of the action to move the vehicle it cannot use that action. Of course there's
	also another action "refuel" to refill the tank of a truck if it is at the gas station.




## How to run
You can use fast downward following the instructions from the site above or use pddl solver through planner.py.
In console "python ./planner.py path_to_domain.pddl path_to_problem.pddl"

You can use also *PLANimator.exe* only on Windows and you can test only Market, Fireman and Logistic problem through the online pddl solver
("Logistic problem with derivative predicates" requires fast downward).