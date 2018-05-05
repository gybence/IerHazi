// Agent forklift in project ierHazi

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true 
		<- //.print("new forklift added");
			.my_name(N);
			.send(shelf,tell,forklift(N));
			.send(entryGate,tell,forklift(N)).

+putBox(shelf) <- putBox(shelf); .
+truck[source(truck1)] : true <- .drop_desire(putBox(shelf)); .
+truck[source(truck2)] : true <- .drop_desire(putBox(shelf)); .
+truck[source(truck3)] : true <- .drop_desire(putBox(shelf)); .

+put: true
	<- .send(shelf,tell,putOnIt).

+take: true
	<- .send(shelf,tell,takeOffIt).