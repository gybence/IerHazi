// Agent entryGate in project ierHazi

/* Initial beliefs and rules */
//vmi(false).
/* Initial goals */

+forklift(T) : true// & vmi(X) & X = true //forklift(F) & asdasd(F)
		<- .send(T,tell,entryGate);
			//.print("asd")    	//ez csak mindenfele teszt kod xdd
			//?asdasd(F); //igy is lehet beliefet elkerni, de ha nem talalja meg akkor kiakad az agens
			//.print(F, " egy uj forklift").
			//.print(F, " vmi teszt").
			.
			

/* Plans */
			 
+arrived(T) : true    //egy kamion szolt, hogy megerkezett
		<- .print("kamion jott: ", T);
			.send(T,tell,entryGate).
		
+opengate(T) : true    //a felhasznalo megnyomja a beengedes gombot, ekkor a kapu jelez a kamionnak, hogy bejohet
		<- .send(T,tell,comein);
			.findall(X,forklift(X),L);
			notifyFls(L, T);
			.abolish(arrived(T)[source(T)]). //el lehet felejteni h a kamion megerkezett, nem fontos mar
		
