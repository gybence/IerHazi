// Agent shelf in project ierHazi

/* Initial beliefs and rules */
capacity(100).
load(25).
/* Initial goals */

+forklift(T) : true
		<- .send(T,tell,shelf).

/* Plans */

