// Agent forklift in project ierHazi

/* Initial beliefs and rules */

/* Initial goals */
!start.

/* Plans */

+!start : true 
		<- .my_name(N);
			.send(shelf,tell,forklift(N));
			.send(entryGate,tell,free(N));
			.send(entryGate,tell,forklift(N));
			.
			
+truck(_,_,_) : true
		<- .my_name(N);
			.send(entryGate,untell,free(N));
			!unload
			.


+!unload : truck(T,D,W)
		<- .print("unload of truck: ", T, " started");
			.wait(100*D); //pakolas szimulalasa
			.send(shelf,tell,deposit(D));
			.

+putSuccess : true
		<- ?truck(T,D,W);
			.wait(100*W); //pakolas szimulalasa
			.send(shelf,tell,withdraw(W));
			.send(shelf,untell,deposit(_));
			.
			
+putFailure : true
		<- ?truck(T,D,W);
			.send(T,tell,needempty); 
			.send(shelf,untell,deposit(_));
			!done;
			.
						
+done : true 
		<- ?truck(T,D,W);
			.send(T,tell,finished); 
			!done;
			.

+!done : true
		<- .abolish(putSuccess); .abolish(putFailure); .abolish(takeSuccess); .abolish(truck(_,_,_)); .abolish(done); 
			.send(shelf,untell,withdraw(_));
			.my_name(N);
			.send(entryGate,tell,free(N));
			.print("truck loading finished");
			.
			