// Agent entryGate in project ierHazi

/* Initial beliefs and rules */
//vmi(false).
/* Initial goals */

+forklift(T) : true						
		<- .my_name(N);
			.send(T,tell,entryGate(N));
			.
			

/* Plans */
			 
+arrived(T,Cl,O) : true    //egy kamion szolt, hogy megerkezett
		<- .print("truck arrived: ", T). //kapu szol nekunk

-arrived(T,_,_) : true
		<- deletepercepts(T);
			.
		
+opengate(T) : true   		 //a felhasznalo megnyomja a beengedes gombot, ekkor a kapu jelez a kamionnak, hogy bejohet
		<- !opengategoal.


+!opengategoal : opengate(T) & free(F)
		<- .send(T,tell,comein);
			//.print(F,T);
			?arrived(_,C,O);
			.send(F,tell,truck(T,C,O));
			.

+!opengategoal : opengate(T) & not free(F) //nem vol szabad fl
		<- .print("fml");
			.
			