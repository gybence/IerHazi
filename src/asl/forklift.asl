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
			.send(entryGate,tell,forklift(N));
			.
			
+truck(T,CL,O) : true
		<- //.print("megkaptam: ", T);
		.my_name(N);
		.abolish(free(_));
		.send(entryGate,untell,free(N));
		//nemertem
		!unload
		.


+!unload : truck(T,CL,O)
		<- .print("csinaltam valamit ",T,"-vel");
			.send(shelf,tell,put(CL));
			.

+putSuccess : true
		<- ?truck(T,CL,O);
			.send(shelf,tell,take(O));
			.send(shelf,untell,put(CL));
			.
			
+takeSuccess : true 
		<- ?truck(T,CL,O);
			.send(shelf,untell,take(O));
			.
			