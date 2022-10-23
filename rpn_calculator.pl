/*
Calculates the math expression in Reverse polish notation or postfix notation
Where
a = +
s = -
m = *
d = /

Infix notation: 2 * (3 + 5)
Input: 2 3 5 a m
Ouput: 16

Infix notation: 2 * (7 - 3)
Input: 2 7 3 s m
Output: 8

Input: 8 5 s 4 2 a 3 d m 
Ouput: 6
*/

% Helper stack predicate
% Push X onto the stack
push(X, S, [X|S]).

% Pop X off the stack
pop([X|S], X, S).


% solve_rpn(Ans, stack_operator, rpn)
% solve_rpn(8, [8], [])
% solve_rpn(8, [], [2,7,3,s,m])
solve_rpn(Result, [Result], []):- !.

% Incoming infix token is number
% Example cases:
% solve_rpn(8, [], [2|7,3,s,m]):-
%   number(2),
%   solve_rpn(8, [2], [7,3,s,m]).
% -----------
% solve_rpn(8, [7,2], [3|s,m]):-
%   number(3),
%   solve_rpn(8, [3,7,2], [s,m]).
solve_rpn(R, S, [Num|T]):-
    number(Num),
    push(Num, S, PushedStack),
    !,
    solve_rpn(R, PushedStack, T).

% Incoming infix token is "a" (which is addition or '+')
% (Explaination is better for subtract case)
solve_rpn(X, S, [Operator|T]):-
    Operator = a,
    pop(S, Operand1, S1),
    pop(S1, Operand2, S2),
    Operated_result is Operand2 + Operand1,
    !,
    solve_rpn(X, [Operated_result|S2], T).

% Incoming infix token is "s" (which is substract or '-')
% Example case:
% solve_rpn(8, [3,7,2], [S|m]):-
%   S = s,
%   pop([3,7,2], 3, [7,2]),
%   pop([7,2], 7, [_|2]),
%   operator_result is 7 - 3,
%   solve_rpn(8, [operator_result|2], [m]).
solve_rpn(X, S, [Operator|T]):-
    Operator = s,
    pop(S, Operand1, S1),
    pop(S1, Operand2, S2),
    Operated_result is Operand2 - Operand1,
    !,
    solve_rpn(X, [Operated_result|S2], T).

% Incoming infix token is "m" (which is multiple or '*')
solve_rpn(X, S, [Operator|T]):-
    Operator = m,
    pop(S, Operand1, S1),
    pop(S1, Operand2, S2),
    Operated_result is Operand2 * Operand1,
    !,
    solve_rpn(X, [Operated_result|S2], T).

% Incoming infix token is "d" (which is multiple or '/')
solve_rpn(X, S, [Operator|T]):-
    Operator = d,
    pop(S, Operand1, S1),
    pop(S1, Operand2, S2),
    Operated_result is Operand2 / Operand1,
    !,
    solve_rpn(X, [Operated_result|S2], T).













    




