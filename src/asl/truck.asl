// Agent truck in project ierHazi

/* Initial beliefs and rules */
currentLoad(math.ceil(math.random(25))). //tfh ennyi doboz van rajta a letrehozaskor (ennyivel erkezik meg eloszor)
order(math.ceil(math.random(25))). //megrendeles
/* Initial goals */

/* Plans */

+arrived : true //environment allitja be egy kulon szalrol! megerkezik a kamion, szol a kapunak (ember)
		<- .my_name(N);
			?currentLoad(CL);
			?order(O);
			.send(entryGate,tell,arrived(N,CL,O)).

+comein : true   //a kamion jelzest kapott hogy bejohet
		<- .print("in the storehouse");
		
			//vmi; //oke ugy tunik igy az environmentnek lehet jelezni!!!!!!!!!!!!!!!!!!!!!! FONTOS
			
			//.abolish(arrived[source(percept)]); //a kamion is elfelejtheti mar h megerkezett mert nem fontos
			//TODO: szolni a shelfnek vagy a forklifteknek
			.

+finished : true 
		<- .print("bye");
			!reset
			.

+!reset : true 
		<- .abolish(finished); .abolish(comein);
			.my_name(N);
			.send(entryGate,untell,arrived(N,_,_));
			-+currentLoad(math.ceil(math.random(25)));
			-+order(math.ceil(math.random(25)));
			.