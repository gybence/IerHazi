// Agent truck in project ierHazi

/* Initial beliefs and rules */
deposit(math.ceil(math.random(25))). //tfh ennyi doboz van rajta a letrehozaskor (ennyivel erkezik meg eloszor)
withdraw(math.ceil(math.random(25))). //megrendeles

/* Initial goals */

/* Plans */

+arrived : true //environment allitja be egy kulon szalrol! megerkezik a kamion, szol a kapunak
		<- .my_name(N);
			?deposit(D);
			?withdraw(W);
			.print("deposit boxes: ", D, ", withdraw boxes: ", W);
			.send(entryGate,tell,arrived(N,D,W)).

+finished : true 
		<- .print("leaving storehouse");
			!reset
			.

+!reset : true 
		<- .abolish(finished);
			.my_name(N);
			.send(entryGate,untell,arrived(N,_,_));
			-+deposit(math.ceil(math.random(25)));
			-+withdraw(math.ceil(math.random(25)));
			.
			
						
+needempty : true
		<- .print("leaving without depositing, will come back empty")
			!setempty
			.
+!setempty : true
		<- .abolish(needempty)
			.my_name(N);
			.send(entryGate,untell,arrived(N,_,_));
			-+deposit(0);
			-+withdraw(math.ceil(math.random(25)));
			.	