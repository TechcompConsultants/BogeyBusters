DO WHILE .T.
CLEAR
SET TALK OFF
SET ECHO OFF
STORE 'Q' TO mans
@ 7,26 SAY 'Bogie Busters Main Menu'
@ 9,27 SAY 'A => Enter New Golfer'
@ 11,27 SAY 'B => Enter Golf Scores'
@ 13,27 SAY 'C => Print Handicap Sheet'
@ 15,27 SAY 'D => Print Standing Sheet'

@ 17,15 SAY 'ENTER SELECTION ======> A thru D or Q to Quit: ' GET mans PICTURE '!'
READ

DO CASE  
  
   CASE mans = 'A'
    DO aplayer

   CASE mans = 'B'
    DO escore

   CASE mans = 'C'
    DO cscore
    DO pscore

   CASE mans = 'D'
    DO cstand

   OTHERWISE
    QUIT

ENDCASE
ENDDO