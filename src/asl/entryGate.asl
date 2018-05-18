// Agent entryGate in project ierHazi

/* Initial beliefs and rules */
//vmi(false).
/* Initial goals */

+forklift(T) : true						// & vmi(X) & X = true //forklift(F) & asdasd(F)
		<- .my_name(N);
			.send(T,tell,entryGate(N));
			//.print("asd")    	//ez csak mindenfele teszt kod xdd
			//?asdasd(F); //igy is lehet beliefet elkerni, de ha nem talalja meg akkor kiakad az agens
			//.print(F, " egy uj forklift").
			//.print(F, " vmi teszt").
			.
			

/* Plans */
			 
+arrived(T) : true    //egy kamion szolt, hogy megerkezett
		<- .print("kamion jott: ", T).
		
+opengate(T) : true   		 //a felhasznalo megnyomja a beengedes gombot, ekkor a kapu jelez a kamionnak, hogy bejohet
		<- !opengategoal.


+!opengategoal : opengate(T) & free(F)
		<- .send(T,tell,comein);
			.print(F,T);
			.send(F,tell,truck(T));
			//.findall(X,free(X),L);
			//assignTruckToForklift(L, T);
			.abolish(arrived(_)); //el lehet felejteni h a kamion megerkezett, nem fontos mar
			.

+!opengategoal : opengate(T) & not free(F) //nem vol szabad fl
		<- .print("fml");
			.
			