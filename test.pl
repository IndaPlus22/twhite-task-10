% Taken and modified from https://gist.github.com/MuffinTheMan/7806903
% Get an element from a 2-dimensional list at (Row,Column)
% using 1-based indexing.
nth1_2d(Row, Column, List, Element) :-
    nth1(Row, List, SubList),
    nth1(Column, SubList, Element).

load_board(BoardFileName, Board):-
    see(BoardFileName),     % Loads the input-file
    read(Board),            % Reads the first Prolog-term from the file
    seen.                   % Closes the io-stream

% Top-level predicate
% Example query: `alive(4, 6, 'alive_example.txt').`
alive(Row, Column, BoardFileName) :-
    read_file(BoardFileName, Board),
    nth1_2d(Row, Column, Board, Stone),
    (Stone = b; Stone = w),
    check_alive(Row, Column, Board, Stone, []), !.

% Checks whether the group of stones connected to
% the stone located at (Row, Column) is alive or dead.
% some inspiration from azeez
check_alive(Row, Column, Board, Stone, Visited) :-
    \+ member((Row, Column), Visited),
    nth1_2d(Row, Column, Board, Stone_),
    (Stone_ = e;
    Stone = Stone_,
    Down is Row + 1,
    Up is Row - 1,
    Right is Column + 1,
    Left is Column - 1,
    (check_alive(Down, Column, Board, Stone, [(Row, Column)|Visited]);
    check_alive(Up, Column, Board, Stone, [(Row, Column)|Visited]);
    check_alive(Row, Left, Board, Stone, [(Row, Column)|Visited]);
    check_alive(Row, Right, Board, Stone, [(Row, Column)|Visited]))).