// Agent truck in project ierHazi

/* Initial beliefs and rules */
capacity(25). //tfh ennyi hely van a kamionban 
/* Initial goals */

!start.

/* Plans */
 
+!start : true
		<- .print("truck letrehozva").

+arrived : true
		<- .my_name(N);
			.send(entryGate,tell,arrived(N)).

+comein : true
		<- .print("bejutottam a raktarba").
			//TODO: szolni a shelfnek vagy a forklifteknek


+truck(box) : true
		<- truck(box); 
			.send(forklift1,tell,truck); 
			//.send(forklift2,tell,truck);
			.print("truck arrived").