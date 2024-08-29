---Murphi model for perfect connect4-----



Const
  num_columns : 7
  num_rows: 6
Type
  turn_t : 1 .. 2;
  player : 0 .. 2; -- each player is 1 or 2, 0 is an empty
  column_index_t : 0 .. num_columns - 1;
  row_size_t : 0 .. num_rows- 1;
  column : array [row_size_t] of player; --length of cols is the row_size_t
  columns : array [column_index_t] of column;
Var
  board : columns
  turn : turn_t

-------Check board fullness-----------------------
function isFull() : boolean;
begin
  For i: column_index_t Do
    For j: row_size_t Do
      If board[i][j] = 0 then
        return false;
      end;
    End;
  End;

  return true;
end;


--------"Drop" a player token on the board--------
Function DropToken(loc: column_index_t; color : player) : boolean ;
begin

  --Look through the column for an empty spot
  For i: row_size_t Do
    If board[loc][i] = 0 then
      board[loc][i] := color;

      --set the turn to the other player
      If turn = 1 then
        turn := 2;
      Else
        turn := 1;
      End;

      return true;
    End;
  End;

  return false;
end;

-----Check when a winner is a certain player------------
function checkWinner(p : player) : boolean;
begin
  --check vertical connect4
  for i: 0 .. (num_rows - 4) do
    for j: column_index_t do
      if board[j][i] == p &&
         board[j][i+1] == p &&
         board[j][i+2] == p &&
         board[j][i+3] == p then

          return true;
      end;
    end;
  end;

  --check horizontal connect4
  for i: 0 .. (num_columns - 4) do
    for j: row_size_t do
      if board[i][j] == p &&
         board[i+1][j] == p &&
         board[i+2][j] == p &&
         board[i+3][j] == p then

         return true;
      end;
    end;
  end;

  --check diagonal
  for i: 3 .. (num_columns - 1) do
    for j: 0 .. (num_rows - 4) do
      if board[i][j] == p &&
         board[i-1][j+1] == p &&
         board[i-2][j+2] == p &&
         board[i-3][j+3] == p then

         return true;
      end;
    end;
  end;

  --checking other diagonal
  for i: 3 .. (num_columns - 1) do
    for j: 3 .. (num_rows - 1) do
      if board[i][j] == p &&
         board[i-1][j-1] == p &&
         board[i-2][j-2] == p &&
         board[i-3][j-3] == p then

         return true;
      end;
    end;
  end;

  return false;
end;

--FIRST PLAYER MOVES
--------------------------------------------------------
Rule "First player drops token in first column"
turn = 1 --first players turn to go
==>
DropToken(0, 1) -- player 1 drops token in col 0
EndRule;

--------------------------------------------------------
Rule "First player drops token in second column"
turn = 1
==>
DropToken(1, 1) -- player 1 drops token in col 1
EndRule;

--------------------------------------------------------
Rule "First player drops token in third column"
turn = 1
==>
DropToken(2, 1) -- player 1 drops token in col 2
EndRule;

--------------------------------------------------------
Rule "First player drops token in fourth column"
turn = 1
==>
DropToken(3, 1) -- player 1 drops token in col 3
EndRule;

--------------------------------------------------------
Rule "First player drops token in fifth column"
turn = 1
==>
DropToken(4, 1) -- player 1 drops token in col 4
EndRule;

--------------------------------------------------------
Rule "First player drops token in sixth column"
turn = 1
==>
DropToken(5, 1) -- player 1 drops token in col 5
EndRule;

--------------------------------------------------------
Rule "First player drops token in seventh column"
turn = 1
==>
DropToken(6, 1) -- player 1 drops token in col 6
EndRule;
--------------------------------------------------------



--SECOND PLAYER MOVES
--------------------------------------------------------
Rule "Opponent drops token in first column"
turn = 2
==>
DropToken(0, 2) -- player 2 drops token in col 0
EndRule;

--------------------------------------------------------
Rule "Opponent drops token in second column"
turn = 2
==>
DropToken(1, 2) -- player 2 drops token in col 1
EndRule;

--------------------------------------------------------
Rule "Opponent drops token in third column"
turn = 2
==>
DropToken(2, 2) -- player 2 drops token in col 2
EndRule;

--------------------------------------------------------
Rule "Opponent drops token in fourth column"
turn = 2
==>
DropToken(3, 2) -- player 2 drops token in col 3
EndRule;

--------------------------------------------------------
Rule "Opponent drops token in fifth column"
turn = 2
==>
DropToken(4, 2) -- player 2 drops token in col 4
EndRule;

--------------------------------------------------------
Rule "Opponent drops token in sixth column"
turn = 2
==>
DropToken(5, 2) -- player 2 drops token in col 5
EndRule;

--------------------------------------------------------
Rule "Opponent drops token in seventh column"
turn = 2
==>
DropToken(6, 2) -- player 2 drops token in col 6
EndRule;
--------------------------------------------------------

Startstate --init board to empty
Begin
    turn := 1;
    For i: column_index_t Do
      For j: row_size_t Do
        board[i][j] := 0;
      End;
    End;
End;

--Invariant: second player not in winning configuration
invariant !isFull() --&& !checkWinner(1)

--discard situations in which first player loses
assume !checkWinner(2)
