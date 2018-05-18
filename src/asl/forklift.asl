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
			
+truck(T) : true
		<- .print("megkaptam: ", T);
		.my_name(N);
		.abolish(free(_));
		.send(entryGate,untell,free(N));
		//nemertem
		!unload
		.
		
		
+!unload : not truck(T)
		<- .print("asdasdasd")
		.
		
-!unload : truck(T)
		<- !unload.
+!unload : truck(T)
		<- .print("csinaltam valamit ",T,"-vel").
		
+nemertem : true 
		<- .print("asdasd").