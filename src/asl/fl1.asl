// Agent fl1 in project ierHazi.mas2j
/* Initial beliefs and rules */
/* Initial goals */
!start.
/* Plans */
//+!start : true <- .print("hello world.").

+!start : true <- .send(fl2,tell,hello).

+hello[source(A)]
  <- .print("I receive an hello from ",A);
     .send(A,tell,hello).
