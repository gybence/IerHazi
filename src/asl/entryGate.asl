// Agent entryGate in project ierHazi

/* Initial beliefs and rules */
		
/* Initial goals */

+forklift(T) : forklift(F)
		<- .send(T,tell,entryGate).
			//.print(F, " egy uj forklift").

/* Plans */
			 
+arrived(T) : true    //egy kamion szolt, hogy megerkezett
		<- .print("kamion jott: ", T);
			.send(T,tell,entryGate).
		
+opengate(T) : true    //a felhasznalo megnyomja a beengedes gombot, ekkor a kapu jelez a kamionnak, hogy bejohet
		<- .send(T,tell,comein);
			.findall(X,forklift(X),L);
			notifyFls(L, T);
			.abolish(arrived(T)[source(T)]). //el lehet felejteni h a kamion megerkezett, nem fontos mar
		
