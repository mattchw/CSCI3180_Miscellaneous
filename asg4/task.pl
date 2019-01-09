/*
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
*/


task(t1, 2, 4).
task(t2, 4, 6).
task(t3, 3, 7).
task(t4, 8, 9).
task(t5, 1, 10).
task(t6, 10, 1).

/* 1a */
 check_task(T) :- 
    task(T,Start,End),Start =< End.
    
/* example query: check_task(t1); 
   result: yes */

/* 1b */
compatible(T1,T2) :-
    check_task(T1),check_task(T2),task(T1,Start1,End1),task(T2,Start2,End2),(End1 =< Start2;End2 =< Start1).
    
/* example query: compatible(t1, t2); 
   result: yes */

/* 1c */
check_compatible(_Tk,[]).
check_compatible(T1,L) :- L=[HeadTask|Remain],compatible(T1,HeadTask),check_compatible(T1,Remain).
compatible_list([]).
compatible_list([H|T]):- check_compatible(H,T),compatible_list(T).
    
/* example query: compatible_list([t1, t2, t3]);   
   result: no */

