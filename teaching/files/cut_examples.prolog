
% A :- B, C, D, !, E, F, G.
% A :- H, I, J.


male(bob).


% my_flatten([[1,2,[3],[[[4]]],[[5],[[[6]]]]], [1,2,3,4,5]).

my_flatten([],[]):-!.
my_flatten([A|B], FL):-!,
    my_flatten(A, FL1),
    my_flatten(B, FL2),
    append(FL1, FL2, FL).
my_flatten(X, [X]).

%:- X\=[_|_], X\=[].
% bob \= alice
%

max(X, Y, X):- X >= Y, !.
max(_X, Y, Y). 

intersection([], _, []).
intersection([X|L1], L2, [X|L]):-
    member(X, L2),!,
    intersection(L1, L2, L).
intersection([_|L1], L2, L):-
    intersection(L1, L2, L).


