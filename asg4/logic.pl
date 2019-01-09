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

/* 1a */
/* Define uint_num(X) which is true if X is a natural number. */
uint_num(0).
uint_num(s(X)) :- uint_num(X).

/* 1b */
/* Define gt(X,Y) which is true if X is greater than Y. */   
gt(s(N),0) :- uint_num(N).
gt(s(X),s(Y)) :- gt(X,Y).

/* 1c */
/* Give a query to list all natural numbers less than 3. */
/* gt(s(s(s(0))),X). */

/* 1d */
/* Based on sum/3, define product(X,Y,Z) which is true if Z is the product of X and Y. */
/*product()*/
sum(0,N,N) :- uint_num(N).
sum(N,0,N) :- uint_num(N).
sum(s(M),N,s(Z)) :- sum(M,N,Z).
    
product(0,N,0) :- uint_num(N).
product(N,0,0) :- uint_num(N).
product(s(M),N,Z) :- gt(N,s(M)), product(M,N,W), sum(W,N,Z).
    
/* 1e */
/* Give a query to compute the product of 2 and 3. */
/* product(s(s(0)),s(s(s(0))),X). */

/* 1f */
/* Give a query to compute the result of 8 divided by 4. */
/* product(X,s(s(s(s(0)))),s(s(s(s(s(s(s(s(0))))))))). */

/* 2a */
/* Define nth(X,L,N) which is true if the N th element in list L is X. */
nth(X,[X|_],1).
nth(X,[_|T],N) :- nth(X,T,M), N is M + 1.

/* 2b */
/* Based on nth/3 or otherwise, define third(X,L) which is true if the third element in list L is X. */
third(X,L) :- nth(X,L,3).

