% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Connor Song
%
% Documentation: Utilized the provided HW 7 code as a starting point
%

ufo(weather_balloon).
ufo(kite).
ufo(fighter_aircraft).
ufo(cloud).

c4c(smith).
c4c(garcia).
c4c(jones).
c4c(chen).

day(tuesday).
day(wednesday).
day(thursday).
day(friday).

% The query to get the answer(s) or that there is no answer
% ?- solve.
solve :-
    ufo(SmithUFO), ufo(GarciaUFO), ufo(JonesUFO), ufo(ChenUFO),
    all_different([SmithUFO, GarciaUFO, JonesUFO, ChenUFO]),
    
    day(SmithDay), day(GarciaDay),
    day(JonesDay), day(ChenDay),
    all_different([SmithDay, GarciaDay, JonesDay, ChenDay]),
    
    Triples = [ [smith, SmithUFO, SmithDay],
                [garcia, GarciaUFO, GarciaDay],
                [jones, JonesUFO, JonesDay],
                [chen, ChenUFO, ChenDay] ],
    
    % 1. C4C Smith did not see a weather balloon, nor kite
    \+ member([smith, weather_balloon, _], Triples),
    \+ member([smith, kite, _], Triples),
    
    % 2. The one who saw the kite isn’t C4C Garcia
    \+ member([garcia, kite, _], Triples),
    
    % 3. Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    ( (member([chen, _, friday], Triples));
      (member([_, fighter_aircraft, friday], Triples))  ),
    
    % 4. The kite was not sighted on Tuesday.
    \+ member([_, kite, tuesday], Triples),
    
    % 5. Neither C4C Garcia nor C4C Jones saw the weather balloon
    \+ member([garcia, weather_balloon, _], Triples),
    \+ member([jones, weather_balloon, _], Triples),
    
    % 6. C4C Jones did not make their sighting on Tuesday.
    \+ member([jones, _, tuesday], Triples),

    % 7. C4C Smith saw an object that turned out to be a cloud.
    member([smith, cloud, _], Triples),

    % 8. The fighter aircraft was spotted on Friday.
    member([_, fighter_aircraft, friday], Triples),

    % 9. The weather balloon was not spotted on Wednesday.
    \+ member([_, weather_balloon, wednesday], Triples),

    tell(Smith, SmithUFO, SmithDay),
    tell(Garcia, GarciaUFO, GarciaDay),
    tell(Jones, JonesUFO, JonesDay),
    tell(Chen, ChenUFO, ChenDay).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
    write('C4C '), write(X), write(' saw the '), write(Y),
    write(' on '), write(Z), write('.'), nl.
