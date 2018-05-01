// Agent entryGate in project ierHazi

/* Initial beliefs and rules */

/* Initial goals */

//!start.

/* Plans */


+truck(N) : true 
		<-	//.print("entry megmondva", N,"-nek");
			 .send(N,tell,entryGate).
			 
+arrived(T) : true
		<- .print("kamion jott: ", T).
		
+opengate(T) : true
		<- .send(T,tell,letin).
			
			