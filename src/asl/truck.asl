// Agent truck in project ierHazi

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- .print("hello world.").
+truck(box) <- truck(box); .send(forklift1,tell,truck); .send(forklift2,tell,truck);.print("truck arrived").