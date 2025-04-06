print_all_lines(File):-
    open(File, read, IFd, [alias(input)]),
    print_lines(IFd),
    close(IFd).

print_lines(IFd):-
    read_string(IFd, "\n", "\r", Sep, String), 
    print_lines2(IFd, Sep, String).

print_lines2(_IFd, -1, _String).
print_lines2(IFd, PrevSep, PrevString):- 
    PrevSep \= -1, 
    writeln(PrevString),
    read_string(IFd, "\n", "\r", Sep, String),
    print_lines2(IFd, Sep, String).






% open('./beers.input', read, _, [alias(beerinput)]).
% assert_event(beerinput, 2)
%
assert_events(Alias, T):-
    stream_property(IFd, alias(Alias)),
    stream_property(IFd, position(Position)),
    read_string(IFd, "\n", "\r", Sep, String), 
    assert_events2(IFd, T, Sep, Position, String).

assert_events2(_IFd, _T, -1, _Position, _String).
assert_events2(IFd, T, Sep, Position, String):-
    Sep \= -1,
    term_string(event(_,T1), String),
    T1 > T, 
    set_stream_position(IFd, Position).

assert_events2(IFd, T, PrevSep, _PrevPosition, PrevString):-
    PrevSep \= -1,
    term_string(event(E,T1), PrevString),
    T1 =< T, 
    assert(event(E,T1)),
    stream_property(IFd, position(Position)),
    read_string(IFd, "\n", "\r", Sep, String), 
    assert_events2(IFd, T, Sep, Position, String).


forget_events(T):-
    findall(_, (
                event(E,T1), T1 =< T, retract(event(E, T1))
            ),_).



