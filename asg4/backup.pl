diff(N,0,N) :- uint_num(N).
diff(s(N), s(M), Z) :- diff(N, M, Z).
    
quotient(0,N,0) :- uint_num(N).  
quotient(M, N, s(Z)) :- diff(M, N, W), quotient(W, N, Z).
/* quotient(s(s(s(s(s(s(s(s(0)))))))),s(s(s(s(0)))),X). */