SELECT a
USE players
SET FILTER TO hdcp < 99.9
INDEX on lname TO temp01.ndx

SELECT b
USE scores

SELECT a
GOTO TOP
SET DEVICE TO FILE Temp01.txt
STORE 3 TO mline
STORE 1 TO mpage
@ mline,1 SAY 'Page 1'
@ mline,31 SAY 'Bogie Busters Score Sheet'
@ mline+1,38 SAY DATE ( )
STORE mline+5 TO mline

  DO WHILE .NOT. EOF ( )
  @ mline,10 SAY TRIM(fname)+' '+TRIM(lname)+' Handicap:'
  @ mline,10+(LEN(TRIM(fname)+' '+TRIM(lname)+' Handicap:')) SAY hdcp
  SELECT b
  SET FILTER TO code=a->code
  GOTO TOP
    STORE 10 TO mcol
    DO WHILE .NOT. EOF ( )
    @ mline+1,mcol SAY LTRIM(STR(score))
    SKIP
    STORE mcol+4 TO mcol
    ENDDO
  SELECT a
  SKIP
  STORE mline+3 TO mline
    IF mline > 65
@ 68,1 SAY 'Continued on Next Page'
    STORE 3 TO mline
    STORE mpage+1 TO mpage
    @ mline,1 SAY 'Page'
    @ mline,6 SAY mpage Picture '9'
    @ mline,31 SAY 'Bogie Busters Score Sheet'
    @ mline+1,38 SAY DATE ( )
    STORE mline+5 TO mline
    ENDIF
  ENDDO
@ 68,1 SAY 'Last Page'
SET DEVICE TO SCREEN

CLOSE DATABASES ALL

USE REPORTtxt
GOTO TOP
APPEND MEMO note1 FROM temp01.txt OVERWRITE
CLOSE DATABASES ALL
REPORT FORM reporttxt1 PREVIEW
CLOSE DATABASES ALL
CLEAR
DELETE FILE temp01.NDX
DELETE FILE temp01.txt