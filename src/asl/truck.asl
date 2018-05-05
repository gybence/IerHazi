// Agent truck in project ierHazi

/* Initial beliefs and rules */
maxLoad(25). //tfh ennyi hely van a kamionban 
currentLoad(math.ceil(math.random(25))). //tfh ennyi doboz van rajta a letrehozaskor (ennyivel erkezik meg eloszor)
/* Initial goals */

/* Plans */

+arrived : true  //environment allitja be egy kulon szalrol! megerkezik a kamion, szol a kapunak (ember)
		<- .my_name(N);
			.send(entryGate,tell,arrived(N)).

+comein : true   //a kamion jelzest kapott hogy bejohet
		<- .print("bejutottam a raktarba");
		
			vmi; //oke ugy tunik igy az environmentnek lehet jelezni!!!!!!!!!!!!!!!!!!!!!! FONTOS
			
			.abolish(arrived[source(percept)]). //a kamion is elfelejtheti mar h megerkezett mert nem fontos
			//TODO: szolni a shelfnek vagy a forklifteknek

+vmi : true // ez a jelzes az environmenttol jott
		<- .print("vki meghivta ezt a fura fv-t teszteles celjabol").

+truck(box) : true
		<- truck(box); 
			.send(forklift1,tell,truck); 
			//.send(forklift2,tell,truck);
			.print("truck arrived").