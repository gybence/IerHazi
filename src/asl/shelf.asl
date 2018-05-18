// Agent shelf in project ierHazi

/* Initial beliefs and rules */
capacity(100).
load(25).
/* Initial goals */

/* Plans */

+forklift(T) : true
		<- .my_name(N);
		.send(T,tell,shelf(N)).