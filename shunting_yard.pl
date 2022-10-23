/*
Shunting yard algorithm
Convert infix notation to become postfix or the reverse polish notation
so that parenthesis is not needed in a mathematical expression where there is
numbers and the operator add, subtract, multiply, divide

Input: 2 * (3 + 5)
Output: 2 3 5 + *

Input: ( (8-5) * ((4+2)/3) ) 
Output: 8 5 - 4 2 + 3 / *

https://en.wikipedia.org/wiki/Shunting_yard_algorithm
*/

% shunting_yard(Output, Stack_operator, Infix_notation)
shunting_yard([], X, X):- !.

% Token is a number
shunting_yard([A|B], C, [A|D]):-
    number(A),
    shunting_yard(B, C, D).

% Token is a add operator
shunting_yard(A, C, [+|D]):-
    shunting_yard(A, [+|C], D).


    


