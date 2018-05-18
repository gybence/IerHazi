// Agent shelf in project ierHazi

/* Initial beliefs and rules */
capacity(100).
load(25).
/* Initial goals */

/* Plans */

+forklift(T) : true
		<- .my_name(N);
		.send(T,tell,shelf(N)).
		
+put(CL)[source(S)] : (load(L) & capacity(C) & L + CL <= C)
		<- -+load(L + CL);
			?load(X);
			.print("load level after put: ", X);
			refresh(X);
			.send(S,tell,putSuccess);
			.
			
+put(CL)[source(S)] : not (load(L) & capacity(C) & L + CL <= C)
		<- .print("ERROR, there is not enough capacity");
			.send(S,tell,putFailure);
			.
			
+take(O)[source(S)] : (load(L) & capacity(C) & L - O >= 0)
		<- -+load(L - O);
			?load(X);
			.print("load level after take: ", X);
			refresh(X);
			.send(S,tell,done);
			.
			
+take(O)[source(S)] : not (load(L) & capacity(C) & L - O >= 0)
		<- .print("ERROR, there are not enough items");
			.send(S,tell,done);
			.