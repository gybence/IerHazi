// Agent entryGate in project ierHazi

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+free(F) : true
		<- freeforklift;
			.

+forklift(T) : true						
		<- .my_name(N);
			.send(T,tell,entryGate(N));
			.
		 
+arrived(T,_,_) : true    //egy kamion szolt, hogy megerkezett
		<- .print("truck arrived: ", T);
		enablebutton;
		. 

-arrived(T,_,_) : true
		<- removeEntryGatePercepts(T);
			.
		
+opengate(T) : true			//a felhasznalo megnyomja a beengedes gombot
		<- !opengategoal.


+!opengategoal : opengate(T) & free(F) //van szabad targonca, a kamiont osszeparositjuk az egyikkel
		<- 	?arrived(_,D,W);
			opensuccess;
			.send(F,tell,truck(T,D,W));
			.

+!opengategoal : opengate(T) & not free(F)		//nem volt szabad targonca, a kamion el lett kuldve
		<- .print("there are no free forklifts to assign");
			openfailure;
			.send(T,tell,finished);
			.
			