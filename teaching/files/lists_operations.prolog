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

mylength([],0).
mylength([_|L],N):-
    mylength(L,N1),
    N is N1+1.

mylength2(L,N):-
    mylength3(L, 0 , N).

mylength3([], N, N).
mylength3([_|T], NPrev, N):-
    N1 is NPrev + 1,
    mylength3(T, N1, N). 

mylength4([],0).
mylength4([_|L], N):-
    N > 0,
    M is N-1,
    mylength4(L, M).

mylength6([], 0).
mylength6([_|L], N+1):-
    mylength6(L, N).

max(X,Y,X):- X>=Y.
max(X,Y,Y):- Y>X.

maxlist([X],X).
maxlist([X|L], Max):-
    maxlist(L, MaxL),
    max(MaxL, X, Max).

maxlist2([],X,X).
maxlist2([X|L],MaxPrev, Max):-
    max(X, MaxPrev, MaxCurrent),
    maxlist2(L, MaxCurrent, Max).

sumlist([], Sum, Sum).
sumlist([X|L], PrevSum, Sum):-
    NewSum is X+PrevSum,
    sumlist(L, NewSum, Sum).

ordered([_]).
ordered([X,Y|L]):-
    X =< Y, ordered([Y|L]).

% subsum([1,2,3],5,[2,3])
%

subsum([], 0, []).
subsum([H|Tail], Sum, [H|R]):-
    NewSum is Sum - H,
    subsum(Tail, NewSum, R).

subsum([_|Tail], Sum, R):-
    subsum(Tail, Sum, R).

% between(1, 5, X)
% 1
% 2
%
between(L, R, L):-
    L =< R.
between(L, R, X):-
    L1 is L + 1,
    L =< R,
    between(L1, R, X).

%allbetween(1,5,[1,2,3,4,5])
allbetween(L, R, []):- L > R.
allbetween(L, R, [L|Tail]):-
    L =< R,
    L1 is L + 1,
    allbetween(L1, R, Tail).

between2(L,R,X):-
    allbetween(L,R,List),
    member(X, List).

allbetween2(L, R, List):- findall(X,between(L,R,X),List).

