// Agent shelf in project ierHazi

/* Initial beliefs and rules */
capacity(100).
load(0).
/* Initial goals */

+forklift(T) : true
		<- .send(T,tell,shelf).

/* Plans */

+putOnIt[source(W)] :  capacity(T) & T > 0
	<- .print(W," put a box on the shelf");
		X = T -1; // ez igy nem jo :S
		.print("kapacitas: ",X).
	
+takeOffIt[source(W)] : capacity(T) & T < 100
	<- .print(W," took a box off the shelf");
				T = T +1;
		capacity(T);
		print("kapacitas: ",T).