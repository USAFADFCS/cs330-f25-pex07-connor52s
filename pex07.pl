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

cadet(smith).
cadet(garcia).
cadet(jones).
cadet(chen).

day(tuesday).
day(wednesday).
day(thursday).
day(friday).

% The query to get the answer(s) or that there is no answer
% ?- solve.
solve :-
    ufo(TuesdayUFO), ufo(WednesdayUFO), ufo(ThursdayUFO), ufo(FridayUFO),
    all_different([TuesdayUFO, WednesdayUFO, ThursdayUFO, FridayUFO]),
    
    cadet(TuesdayCadet), cadet(WednesdayCadet),
    cadet(ThursdayCadet), cadet(FridayCadet),
    all_different([TuesdayCadet, WednesdayCadet, ThursdayCadet, FridayCadet]),
    
    Triples = [ [tuesday, TuesdayUFO, TuesdayCadet],
                [wednesday, WednesdayUFO, WednesdayCadet],
                [thursday, ThursdayUFO, ThursdayCadet],
                [friday, FridayUFO, FridayCadet] ],
    
    % 1. C4C Smith did not see a weather balloon, nor kite
    \+ member([_, weather_balloon, smith], Triples),
    \+ member([_, kite, smith], Triples),
    
    % 2. The one who saw the kite isn’t C4C Garcia
    \+ member([_, kite, garcia], Triples),
    
    % 3. Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    ( (member([friday, _, chen], Triples));
      (member([friday, fighter_aircraft, _], Triples))  ),
    
    % 4. The kite was not sighted on Tuesday.
    \+ member([tuesday, kite, _], Triples),
    
    % 5. Neither C4C Garcia nor C4C Jones saw the weather balloon
    \+ member([_, weather_balloon, garcia], Triples),
    \+ member([_, weather_balloon, jones], Triples),
    
    % 6. C4C Jones did not make their sighting on Tuesday.
    \+ member([tuesday, _, jones], Triples),

    % 7. C4C Smith saw an object that turned out to be a cloud.
    member([_, cloud, smith], Triples),

    % 8. The fighter aircraft was spotted on Friday.
    member([friday, fighter_aircraft, _], Triples),

    % 9. The weather balloon was not spotted on Wednesday.
    \+ member([wednesday, weather_balloon, _], Triples),

    tell(tuesday, TuesdayUFO, TuesdayCadet),
    tell(wednesday, WednesdayUFO, WednesdayCadet),
    tell(thursday, ThursdayUFO, ThursdayCadet),
    tell(friday, FridayUFO, FridayCadet).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
    write('On '), write(X), write(', C4C '), write(Z),
    write(' saw '), write(Y), write('.'), nl.
