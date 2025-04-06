
union([], L2, L2).
union([X|L1], L2, [X|L]):-
    \+ member(X, L2),!,
    union(L1, L2, L).
union([_|L1], L2, L):-
    union(L1, L2, L).
