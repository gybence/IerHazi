// Agent shelf in project ierHazi

/* Initial beliefs and rules */
capacity(100).
load(25).
/* Initial goals */

/* Plans */

+forklift(T) : true
		<- .my_name(N);
		.send(T,tell,shelf(N)).
		
+put(CL) : (load(L) & capacity(C) & L + CL <= C)
		<-
			-+load(L + CL);
			?load(S);
			.print("uj toltottsegi szint: ", S);
			loadchanged(S);
			.
			
+put(CL) : not (load(L) & capacity(C) & L + CL <= C)
		<- .print("bajvan, nem fert fel xdd");
			.