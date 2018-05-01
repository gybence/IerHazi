// Agent shelf in project ierHazi

/* Initial beliefs and rules */
capacity(100).
/* Initial goals */

!start.

/* Plans */

+!start : true <- .print("hello world.").

+putOnIt[source(W)] :  capacity(T) & T > 0
	<- .print("W"," put a box on the shelf");
		capacity = capacity-1.
	
+takeOffIt[source(W)] : capacity(T) & T < 100
	<- .print("W"," took a box off the shelf");
		capacity = capacity+1.