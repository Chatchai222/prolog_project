% 2022 Oct 23 
% This is helper predicate for Prolog Project

operator(a). % Add,        +
operator(s). % Subtract,   - 
operator(m). % Multiply,   *
operator(d). % Divide,     /

% All item inside list is operator
all_operator([]).
all_operator([H|T]):-
    operator(H),
    all_operator(T).

% Get a list of operator at a certain length
get_operator_list(Len, X):-
    length(X, Len),
    all_operator(X).

% Concatenation of list
% List1 + List2 = List3
concat_list([], List, List).
concat_list([H|List1], X, [H|List3]):-
    concat_list(List1, X, List3).

% Get a concatenated list from number list then operator list
% such that len(numList) = len(operatorList) + 1
% The result will be all number_list + all possible selection of operator
% Input: ([2,7,3], X) // [2,7,3,a,a] [2,7,3,a,s] [2,7,3,a,m] ... [2,7,3,d,d]
get_number_operator_list(NumList, X):-
    length(NumList, NumListLength),
    OperatorListLength is NumListLength-1,
    get_operator_list(OperatorListLength, OperatorList),
    concat_list(NumList, OperatorList, X).

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


% calculate_rpn(Ans, stack_operator, rpn)
% calculate_rpn(8, [8], [])
% calculate_rpn(8, [], [2,7,3,s,m])
calculate_rpn(Result, [Result], []):- !.

% Incoming infix token is number
% Example cases:
% calculate_rpn(8, [], [2|7,3,s,m]):-
%   number(2),
%   calculate_rpn(8, [2], [7,3,s,m]).
% -----------
% calculate_rpn(8, [7,2], [3|s,m]):-
%   number(3),
%   calculate_rpn(8, [3,7,2], [s,m]).
calculate_rpn(R, S, [Num|T]):-
    number(Num),
    push(Num, S, PushedStack),
    !,
    calculate_rpn(R, PushedStack, T).

% Incoming infix token is "a" (which is addition or '+')
% (Explaination is better for subtract case)
calculate_rpn(X, S, [Operator|T]):-
    Operator = a,
    pop(S, Operand1, S1),
    pop(S1, Operand2, S2),
    Operated_result is Operand2 + Operand1,
    !,
    calculate_rpn(X, [Operated_result|S2], T).

% Incoming infix token is "s" (which is substract or '-')
% Example case:
% calculate_rpn(8, [3,7,2], [S|m]):-
%   S = s,
%   pop([3,7,2], 3, [7,2]),
%   pop([7,2], 7, [_|2]),
%   operator_result is 7 - 3,
%   calculate_rpn(8, [operator_result|2], [m]).
calculate_rpn(X, S, [Operator|T]):-
    Operator = s,
    pop(S, Operand1, S1),
    pop(S1, Operand2, S2),
    Operated_result is Operand2 - Operand1,
    !,
    calculate_rpn(X, [Operated_result|S2], T).

% Incoming infix token is "m" (which is multiple or '*')
calculate_rpn(X, S, [Operator|T]):-
    Operator = m,
    pop(S, Operand1, S1),
    pop(S1, Operand2, S2),
    Operated_result is Operand2 * Operand1,
    !,
    calculate_rpn(X, [Operated_result|S2], T).

% Incoming infix token is "d" (which is multiple or '/')
calculate_rpn(X, S, [Operator|T]):-
    Operator = d,
    pop(S, Operand1, S1),
    pop(S1, Operand2, S2),
    Operated_result is Operand2 / Operand1,
    !,
    calculate_rpn(X, [Operated_result|S2], T).

% Get valid RPN notation
% valid_rpn(ListOfNumber, RPNform)
%
% valid_rpn([2,7,3], [2,7,3,s,m], RPNResult) // [2,7,3,a,a] [2,7,3,a,s] [2,7,3,a,m] ... [2,7,3,d,d]
% valid_rpn([2,7,3], [2,7,m,3,s], RPNResult) // [2,7,a,3,a] [2,7,a,3,s] [2,7,a,3,m] ... [2,7,d,3,d]
%
valid_rpn(NumList, RPNNotation, RPNResult):-
    get_number_operator_list(NumList, NumOperatorList),
    permutation(NumOperatorList, RPNNotation),
    calculate_rpn(RPNResult, [], RPNNotation). % if can calculate then the notation is valid

% Solve countdown
solve_countdown(NumList, Target, RPNNotation):-
    valid_rpn(NumList, RPNNotation, Target).





