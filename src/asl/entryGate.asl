// Agent entryGate in project ierHazi

/* Initial beliefs and rules */

/* Initial goals */

//!start.

/* Plans */
			 
+arrived(T) : true
		<- .print("kamion jott: ", T);
			.send(T,tell,entryGate).
		
+opengate(T) : true
		<- .send(T,tell,comein).