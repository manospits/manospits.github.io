flatten_ilist([],[]).
flatten_ilist([[A,B]|R],[(A,1,0),(B,0,1)|R1]):-
    flatten_ilist(R,R1).

merge_ilse(A,B,R):-
    flatten_ilist(A, Af),
    flatten_ilist(B, Bf),
    merge_ilse2(Af,Bf, R).

merge_ilse2([],[],[]).
merge_ilse2([],[B|BR],[B|BR]).
merge_ilse2([A|AR],[],[A|AR]).

merge_ilse2([(T,Sa,Ea)|Atail], [(T,Sb,Eb)|BTail], [(T,S,E)|R]):-
   S is Sa + Sb,
   E is Ea + Eb,
   merge_ilse2(Atail, BTail, R).

merge_ilse2([(Ta,Sa,Ea)|Atail], [(Tb,Sb,Eb)|BTail], [(Ta,Sa,Ea)|R]):-
   Ta < Tb,
   merge_ilse2(Atail, [(Tb,Sb,Eb)|BTail], R).

merge_ilse2([(Ta,Sa,Ea)|Atail], [(Tb,Sb,Eb)|BTail], [(Tb,Sb,Eb)|R]):-
   Ta > Tb,
   merge_ilse2([(Ta,Sa,Ea)|Atail], BTail, R).
   

%single scan temporal union
compute_union_intervals([],_,_,_,[]).
compute_union_intervals([(TS,SC,EC)|R], 0, E, _, IL):-
    SC > 0,
    EN is E+EC,
    compute_union_intervals(R, SC, EN, TS, IL).

compute_union_intervals([(TE,SC,EC)|R],S,E,TS,[[TS,TE]|IL]):-
    S \= 0,
    SN is S+SC,
    EN is E+EC,
    SN=EN,
    compute_union_intervals(R,0,0,_,IL).

compute_union_intervals([(_,SC,EC)|R],S,E,TS,IL):-
    S \= 0,
    SN is S+SC,
    EN is E+EC,
    SN\=EN,
    compute_union_intervals(R,SN,EN,TS,IL).

temporal_union(A,B,L):-
    merge_ilse(A,B,R),
    compute_union_intervals(R,0,0,_,L).



































%merge se, from two instant lists create a single one that has
%triples (instant,membershipinfirst, membershipinsecond)
merge_se([],[B|EP],[(B,0,1)|R]):-merge_se([],EP,R).
merge_se([A|SP],[],[(A,1,0)|R]):-merge_se(SP,[],R).
merge_se([],[],[]).

merge_se([A|SP],[B|EP],[(A,1,1)|R]):-
    B=A,merge_se(SP,EP,R).
merge_se([A|SP],[B|EP],[(A,1,0)|R]):-
    A<B,merge_se(SP,[B|EP],R).
merge_se([A|SP],[B|EP],[(B,0,1)|R]):-
    B<A,merge_se([A|SP],EP,R).

