// Agent forklift in project ierHazi

/* Initial beliefs and rules */
free(true).
/* Initial goals */

!start.

/* Plans */

+!start : true 
		<- //.print("new forklift added");
			.my_name(N);
			.send(shelf,tell,forklift(N));
			.send(entryGate,tell,free(N));
			.send(entryGate,tell,forklift(N)).

+truck(T)[source(percept)] : true
		<- .print("ezt le kene pakolni: ", T);
		nemertem.
		
+nemertem : true 
		<- .print("asdasd").