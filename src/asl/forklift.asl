// Agent forklift in project ierHazi

/* Initial beliefs and rules */
/* Initial goals */

!start.
/* Plans */

+!start : true 
		<- //.print("new forklift added");
			.my_name(N);
			.send(shelf,tell,forklift(N));
			.send(entryGate,tell,free(N));
			.send(entryGate,tell,forklift(N));
			.
			
+truck(T,CL,O) : true
		<- //.print("truck assigned: ", T);
		.my_name(N);
		.send(entryGate,untell,free(N));
		!unload
		.


+!unload : truck(T,CL,O)
		<- .print("unload started with ", T);
			.send(shelf,tell,put(CL));
			.

+putSuccess : true
		<- ?truck(T,CL,O);
			.send(shelf,tell,take(O));
			.send(shelf,untell,put(CL));
			.
			
+putFailure : true
		<- ?truck(T,CL,O);
			.send(T,tell,finished); 
			!done;
			.
						
+done : true 
		<- ?truck(T,CL,O);
			.send(T,tell,finished); 
			!done;
			.

+!done : true
		<- 
			.abolish(putSuccess); .abolish(putFailure); .abolish(takeSuccess); .abolish(truck(_,_,_)); .abolish(done); 
			.send(shelf,untell,take(O));
			.my_name(N);
			.send(entryGate,tell,free(N));
			.print("loading finished");
			.
			