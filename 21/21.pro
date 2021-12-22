% run with `gprolog` then when in the shell do `['21']. solution.`
% convert first dice to second dice object for each roll
roll(Increment1, Increment2, Increment3, d(OldTurn1, OldTurn2), d(NewTurn1, NewTurn2)) :-
    Increment1 = OldTurn1,
    Increment2 is Increment1+1,
    Increment3 is Increment2+1,
    NewTurn1 is Increment3+1,
    NewTurn2 is OldTurn2+3.

checkWin(Score1, Score2) :- Score1 >= 1000 ; Score2 >= 1000.

% if someone has 1000 points, end
check(Score1, Score2, d(_, Turns)) :-
    checkWin(Score1, Score2),
    format("Answer = ~d = ~d * ~d~n", [Score2*Turns, Score2, Turns]).

% roll then get square then calc score before checking and rolling again for opponent
turn(Square1, Player1, Square2, Player2, Dice) :-
    once(roll(Increment1, Increment2, Increment3, Dice, Dice1)),
    % get square which is the score
    Score1 is (Increment1 + Increment2 + Increment3 + Square1 - 1) rem 10 + 1,
    NewScore1 is Score1 + Player1,

    (check(NewScore1, Player2, Dice1), ! ;
        once(roll(Increment4, Increment5, Increment6, Dice1, Dice2)),
        Score2 is (Increment4 + Increment5 + Increment6 + Square2 - 1) rem 10 + 1,
        NewScore2 is Score2 + Player2,
        % recursive relation
        (check(NewScore2, NewScore1, Dice2), ! ;
            turn(Score1, NewScore1, Score2, NewScore2, Dice2)
        )
    ).

% initialize dice to 
% turn 1 for player 1 turn 0 for player 2
dice(d(1, 0)).

solution :-
    dice(Dice),
    % player 1 on square 6 and player 2 on square 2
    turn(6, 0, 2, 0, Dice).
