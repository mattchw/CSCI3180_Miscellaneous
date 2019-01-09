(* 
/∗
∗ CSCI3180 Principles of Programming Languages 
∗
∗ --- Declaration --- 
∗
∗ I declare that the assignment here submitted is original except for source
∗ material explicitly acknowledged. I also acknowledge that I am aware of
∗ University policy and regulations on honesty in academic work, and of the
∗ disciplinary guidelines and procedures applicable to breaches of such policy
∗ and regulations, as contained in the website
∗ http://www.cuhk.edu.hk/policy/academichonesty/ 
∗
∗ Assignment 4
∗ Name : Wong Cho Hin
∗ Student ID : 1155070355
∗ Email Addr : wongch6@cse.cuhk.edu.hk 
∗/
*)

val tasks = [
  ("t1", 2, 4),
  ("t2", 4, 6),
  ("t3", 3, 7),
  ("t4", 8, 9),
  ("t5", 1, 10),
  ("t6", 10, 1)
];


(* 1a *)

fun check_task(T:string, nil):bool = false
 | check_task(T:string, (t:string,s:int,e:int)::ys):bool = if (T=t)andalso(e>=s) then true else check_task(T,ys)

(* example query: check_task("t1", tasks); *)
(* result: val it = true : bool *)

 
(* 1b *)

fun compatible(T1:string, T2:string, nil):bool = false
 | compatible(T1:string, T2:string, (t:string,s:int,e:int)::ys):bool = 
  let
     fun task1(T1:string, (t:string,s:int,e:int)::ys) = if (T1=t) then (s,e) else task1(T1,ys)
      | task1(T1:string, nil) = (0,0)
     fun task2(T2:string, (t:string,s:int,e:int)::ys) = if (T2=t) then (s,e) else task2(T2,ys)
      | task2(T2:string, nil) = (0,0)
  in
     if (not(check_task(T1,(t,s,e)::ys))) orelse (not(check_task(T2,(t,s,e)::ys))) then false 
     else if((#2(task1(T1,(t,s,e)::ys))) <= (#1(task2(T2,(t,s,e)::ys))))orelse((#2(task2(T2,(t,s,e)::ys))) <= (#1(task1(T1,(t,s,e)::ys)))) then true
     else false
  end

(* example query: compatible("t1", "t2", tasks); *)
(* result: val it = true : bool *)
         

(* 1c *)
fun compatible_list((T:string)::tl, tasklist:(string * int * int) list):bool = 
  let
     fun check_compatible(t1:string,(t2:string)::cctl) = 
         if (compatible(t1,t2,tasklist)) then check_compatible(t1,cctl)
         else false
      | check_compatible(t1:string,nil) = true
  in
     if (check_compatible(T,tl)) then compatible_list(tl,tasklist)
     else false
  end
 | compatible_list(nil, tasklist:(string * int * int) list):bool = true

(* example query: compatible_list(["t1", "t2", "t3"], tasks); *)
(* result: val it = false : bool *)

         
         
         
         
         
         
         
         
         
