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

(* 1a *)
(*
    (λc.c(λa.λb.b))((λa.λb.λf.f a b)p q)
=>β (λa.λb.b)((λa.λb.λf.f a b)p q)
=>β (λb.b)
*)

(* 1b *)
(*
    (λc.c(λa.λb.b))((λa.λb.λf.f a b)p q)
=>β (λc.c(λa.λb.b))((λb.λf.f p b)q)
=>β (λc.c(λa.λb.b))(λf.f p q)
=>β (λa.λb.b)(λf.f p q)
=>β (λb.b)
*)

(* 2a *)
(*
    (λx.λy.(mul x((λx.(add x 3))y)))7 8
=>α (((λx.λy.(mul x((λx.(add x 3))y)))7)8)
=>β ((λy.(mul 7((λx.(add x 3))y)))8)
=>β (mul 7((λx.(add x 3))8))
=>β mul 7(add 8 3)
=>δ 77
*)

(* 2b *)
(*
    (λx.λy.(mul x((λx.(add x 3))y)))7 8
=>α (((λx.λy.(mul x((λx.(add x 3))y)))7)8)
=>β (((λx.λy.(mul x(λx.(add y 3))))7)8)
=>β ((λy.(mul 7(λx.(add y 3))))8)
=>β mul 7(add 8 3)
=>δ 77
*)

(* 2c *)
fun f x y = x*(y+3)
(* Example query: f 7 8 *)

(* 3a *)
(*
output of 1st printf: 2
This is because f1(m=1) = λx.(add x 1) 1.
    λx.(add x 1) 1
=>β add 1 1
=>δ 2

output of 2nd printf: 8
This is because f2 = (λg.g 5)(λx.(x+3)).
    (λg.g 5)(λx.(x+3))
=>β 5(λx.(x+3))
=>β 5+3
=>δ 8

output of 3rd printf: 8
This is because swap(k,m)=swap(2,8). k will become 8 and m will become 2.

output of 4th printf: 5 11
This is because loop will change the value of k and m. 
loop = for(i=1;i<=3;i++){
           pi (k,m){
               w=k+1;
               k=m+1;
               m=w;
           } 
       }
When i=1, k=3 and m=9. When i=2, k=10 and m=4. When i=3, k=5 and m=11.
*)

(* 3b *)
(*
Yes, there is only one way to solve f1.
    f1(m) = λx.(add x 1)m
=>β add m 1
*)

(* 3c *)
(*
Variable x is a parameter variable and variable t is a local variable. 
The scope and the lifetime of x is the entire body of the swap procedure.
As variable t is declared at the start of the procedure, the scope and lifetime of t is also the entire body of swap.
*)

(* 3d *)
(* 
If dynamic scoping is used in Lapi, it provides a great convenience to users. For examples:
    int y = 3;
    f1 = lambda x.(add x 1) y;
    k = eval_normal(f1);
k will be 4 if dynamic scoping is used. Users do not have to use parameter variables to input values into the function.
Although dynamic scoping is powerful and flexible, it reduces readability, reliability and security.

However, using static scoping can ensure the reliability and security of the program as the program can bind the required variables before compilation. It can protect local variables that we are not going to use from being accessed to by subprograms.
*)
