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
			.print("uj toltottsegi szint: ", X);
			loadchanged(X);
			.send(S,tell,putSuccess);
			.
			
+put(CL)[source(S)] : not (load(L) & capacity(C) & L + CL <= C)
		<- .print("bajvan, nem fert fel xdd");
			.send(S,tell,putFailure);
			.
			
+take(O)[source(S)] : (load(L) & capacity(C) & L - O >= 0)
		<- -+load(L - O);
			?load(X);
			.print("uj toltottsegi szint: ", X);
			loadchanged(X);
			.send(S,tell,takeSuccess);
			.