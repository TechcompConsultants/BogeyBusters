SELECT a
USE players EXCLUSIVE
INDEX ON code TO temp01.NDX
GOTO BOTTOM
STORE VAL(code) TO mcode
STORE mcode+1 TO mcode
STORE LTRIM(STR(INT(mcode))) TO mtcode

  DO WHILE LEN(mtcode)<3
  STORE '0'+mtcode TO mtcode
  ENDDO

APPEND BLANK
DO FORM aPlayer