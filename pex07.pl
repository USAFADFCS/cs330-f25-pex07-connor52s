% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Connor Song
%
% Documentation: Utilized the provided HW 7 code as a starting point
%

UFO(weather_balloon)
UFO(kite).
UFO(fighter_aircraft).
UFO(cloud).

C4C(Smith).
C4C(Garcia).
C4C(Jones).
C4C(Chen).

Day(Tuesday).
Day(Wednesday).
Day(Thursday).
Day(Friday).

% The query to get the answer(s) or that there is no answer
% ?- solve.
solve :-
    UFO(SmithUFO), UFO(GarciaUFO), UFO(JonesUFO), UFO(ChenUFO),
    all_different([SmithUFO, GarciaUFO, JonesUFO, ChenUFO]),
    
    relative(SmithDay), relative(GarciaDay),
    relative(JonesDay), relative(ChenDay),
    all_different([SmithDay, GarciaDay, JonesDay, ChenDay]),
    
    Triples = [ [Smith, SmithUFO, SmithDay],
                [Garcia, GarciaUFO, GarciaDay],
                [Jones, JonesUFO, JonesDay],
                [Chen, ChenUFO, ChenDay] ],
    
    % 1. C4C Smith did not see a weather balloon, nor kite
    \+ member([Smith, weather_balloon, _], Triples),
    \+ member([Smith, kite, _], Triples),
    
    % 2. The one who saw the kite isn’t C4C Garcia
    \+ member([Garcia, kite, _], Triples),
    
    % 3. Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    ( (member([Chen, _, Friday], Triples));
      (member([_, fighter_aircraft, Friday], Triples))  ),
    
    % 4. The kite was not sighted on Tuesday.
    \+ member([_, kite, Tuesday], Triples),
    
    % 5. Neither C4C Garcia nor C4C Jones saw the weather balloon
    \+ member([Garcia, weather_balloon, _], Triples),
    \+ member([Jones, weather_balloon, _], Triples),
    
    % 6. C4C Jones did not make their sighting on Tuesday.
    \+ member([Jones, _, Tuesday], Triples),

    % 7. C4C Smith saw an object that turned out to be a cloud.
    member([Smith, cloud, _], Triples),

    % 8. The fighter aircraft was spotted on Friday.
    member([_, fighter_aircraft, Friday], Triples),

    % 9. The weather balloon was not spotted on Wednesday.
    \+ member([_, weather_balloon, Wednesday], Triples),

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
