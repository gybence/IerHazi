// Agent shelf in project ierHazi

/* Initial beliefs and rules */
capacity(100).
load(0).

/* Initial goals */

/* Plans */

+forklift(T) : true
		<- .my_name(N);
		.send(T,tell,shelf(N)).
		
+deposit(D)[source(S)] : (load(L) & capacity(C) & L + D <= C) //sikeresen be lehet meg rakni a dobozokat a raktarba (van hely)
		<- -+load(L + D);
			?load(X);
			.print("load level after put: ", X);
			refresh(X);
			.send(S,tell,putSuccess);
			.
			
+deposit(D)[source(S)] : not (load(L) & capacity(C) & L + D <= C) //nincs eleg hely
		<- .print("ERROR, not enough space in storehouse");
			write("ERROR, not enough space in storehouse");
			.send(S,tell,putFailure);
			.
			
+withdraw(W)[source(S)] : (load(L) & capacity(C) & L - W >= 0) //sikerult kivenni a raktarbol a megrendeleshez elegendo dobozt
		<- -+load(L - W);
			?load(X);
			.print("load level after take: ", X);
			refresh(X);
			.send(S,tell,done);
			.
			
+withdraw(W)[source(S)] : not (load(L) & capacity(C) & L - W >= 0) //nem volt eleg doboz
		<- .print("ERROR, not enough items in storehouse");
			write("ERROR, not enough items in storehouse");
			.send(S,tell,done);
			.