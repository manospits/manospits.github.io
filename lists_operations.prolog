% delete(1, [1,2,3,4,1], [2,3,4,1])
% delete(1, [1,2,3,4,1], [1,2,3,4])
%
%
mydelete(X, [X|L], L).
mydelete(A, [B|L1], [B|L2]):-
    mydelete(A,L1,L2).

insert(X, List, IList):-
    mydelete(X, IList, List).

%permutation([1,2,3],L)
% [1,2,3]
% [1,3,2]
% [2,1,3]
% [2,3,1]
% [3,1,2]
% [3,2,1]
%
permutation([],[]).
permutation([X|L],P):-
    permutation(L, L1),
    insert(X,L1,P).


permutation2([],[]).
permutation2(L, [X|P]):-
    mydelete(X,L,L1),
    permutation2(L1,P).

%mysublist(S,L)
%mysublist([1,2],[1,2,3,4]).
%
mysublist([],_).
mysublist(S,L):-
    append(_,L1,L),
    append(S,_,L1),
    S\=[].

%mylength([1,2,3],3).
%
mylength([],0).
mylength([_|L],X):-mylength(L,X1), X is  X1+1.

