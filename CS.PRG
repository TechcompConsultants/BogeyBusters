STORE 0 TO mcnt
@ 3,10 SAY 'Enter number of rounds to use for calculation:' GET mcnt PICTURE '9'
READ

SELECT a
USE scores
COPY STRUCTURE EXTENDED TO temp02
USE temp02
APPEND BLANK
REPLACE field_name WITH 'hdcp'field_type WITH 'N',field_len WITH 002
CREATE temp01 FROM temp02
USE temp01
APPEND FROM scores
GOTO TOP

SELECT b
USE scores
GOTO TOP

SELECT c
USE players
COPY STRUCTURE EXTENDED TO temp04
USE temp04
APPEND BLANK
REPLACE field_name WITH 'points'field_type WITH 'N',field_len WITH 004
CREATE temp03 FROM temp04
USE temp03
APPEND FROM players
GOTO TOP

  DO WHILE .NOT. EOF( )
  SELECT a
  SET FILTER TO code = c->code
  GOTO TOP
  STORE 0 TO mtot
  STORE 0 TO mno
    DO WHILE .NOT. EOF( )
    STORE score+mtot TO mtot
    STORE mno+1 TO mno
    SKIP
    IF .NOT. EOF( )
    REPLACE hdcp WITH ROUND(mhdcp,0)
    ENDIF
    ENDDO
  SELECT c
  SKIP
  ENDDO

SELECT a
GOTO TOP
SELECT c
GOTO TOP
  DO WHILE .NOT. EOF( )
  SELECT a
  SET FILTER TO code = c->code .AND. CTOD(dateplyd) > CTOD('07/01/97')
  INDEX ON (score-hdcp) TO temp01.ndx
  GOTO TOP
  STORE 0 TO mpoints
  STORE 0 TO mcnt1
    DO WHILE mcnt1<mcnt .AND. .NOT. EOF( )
    STORE mpoints+(score-hdcp) TO mpoints
    STORE mcnt1+1 TO mcnt1
    SKIP
    ENDDO
  SET INDEX TO
  DELETE FILE temp01.ndx
  SELECT c
    IF mcnt1 = mcnt
    REPLACE points WITH mpoints
    ELSE
    REPLACE points WITH 0
    ENDIF
  SKIP
  ENDDO
INDEX ON points TO temp02.NDX
SET FILTER TO points <> 0
GOTO TOP
SET DEVICE TO PRINT
*SET DEVICE TO FILE TEMP01.txt
STORE 3 TO mline
STORE 1 TO mpage
@ mline,1 SAY 'PAGE 1'
@ mline,31 SAY 'Bogie Busters Standings'
@ mline+1,38 SAY DATE( )
@ mline+2,34 SAY 'Using'
@ mline+2,40 SAY mcnt Picture '9'
@ mline+2,43 SAY 'Rounds'
STORE mline+5 TO mline

  DO WHILE .NOT. EOF( )
  @ mline,10 SAY TRIM(fname)+' '+TRIM(lname)
  @ mline,27 SAY ' ======>Handicap:'
  @ mline,45 SAY hdcp
  @ mline,52 SAY 'Total Points:'
  @ mline,65 SAY points
  SELECT a
  SET FILTER TO code=c->code .AND. CTOD(dateplyd) > CTOD('07/01/97')
  GOTO TOP
    STORE 10 TO mcol
    DO WHILE .NOT. EOF( )
    IF mcol = 10
    @ mline+1,mcol SAY 'Scores:'
    @ mline+1,mcol+13 SAY score PICTURE '99'
    STORE mcol+13 TO mcol
    ELSE
    @ mline+1,mcol SAY score PICTURE '99'
    ENDIF
    SKIP
    STORE mcol+4 TO mcol
  ENDDO
  GOTO TOP
    STORE 10 TO mcol
    DO WHILE .NOT. EOF( )
    IF mcol = 10
    @ mline+2,mcol SAY 'Handicaps:'
    @ mline+2,mcol+13 SAY hdcp PICTURE '99'
    STORE mcol+13 TO mcol
    ELSE
    @ mline+2,mcol SAY hdcp PICTURE '99'
    ENDIF
    SKIP
    STORE mcol+4 TO mcol
    ENDDO
  GOTO TOP
    STORE 10 TO mcol
    DO WHILE .NOT. EOF( )
    IF mcol = 10
    @ mline+3,mcol SAY 'NETS:'
    @ mline+3,mcol+13 SAY (score-hdcp) PICTURE '99'
    STORE mcol+13 TO mcol
    ELSE
    @ mline+3,mcol SAY (score-hdcp) PICTURE '99'
    ENDIF
    SKIP
    STORE mcol+4 TO mcol
    ENDDO
  SELECT c
  SKIP
  STORE mline+6 TO mline
    IF mline > 55
@ 58,1 SAY 'Continued on next page'
*  @ mLine+2,0 SAY '
EJECT
    STORE 3 TO mline
    STORE mpage+1 TO mpage
    @ mline,1 SAY 'Page'
    @ mline,6 SAY mpage Picture '9'
    @ mline,31 SAY 'Bogie Busters Standings'
    @ mline+1,38 SAY DATE( )
    @ mline+2,34 SAY 'Using'
    @ mline+2,40 SAY mcnt Picture '9'
    @ mline+2,43 SAY 'Rounds'
    STORE mline+5 TO mline
    ENDIF
  ENDDO
@ 58,1 SAY 'Continued on Next Page'
*@ 58,1 SAY 'Last Page'
SET FILTER TO points = 0
GOTO TOP
*SET DEVICE TO PRINT
STORE 3 TO mline
STORE mpage+1 TO mpage
@ mline,1 SAY 'Page'
@ mline,6 SAY mpage Picture '9'
@ mline,31 SAY 'Bogie Busters Standings'
@ mline+1,38 SAY DATE( )
@ mline+2,34 SAY 'Using'
@ mline+2,40 SAY mcnt Picture '9'
@ mline+2,43 SAY 'Rounds'

STORE mline+5 TO mline

  DO WHILE .NOT. EOF( )
  @ mline,10 SAY TRIM(fname)+' '+TRIM(lname)
  @ mline,27 SAY ' ======>Handicap:'
  @ mline,45 SAY hdcp
  @ mline,52 SAY 'Total Points:'
  @ mline,65 SAY points
  SELECT a
  SET FILTER TO code =c->code .AND. CTOD(dateplyd) > CTOD('07/01/97')
  GOTO TOP
    STORE 10 TO mcol
    DO WHILE .NOT. EOF( )
    IF mcol = 10
    @ mline+1,mcol SAY 'Scores:'
    @ mline+1,mcol+13 SAY score PICTURE '99'
    STORE mcol+13 TO mcol
    ELSE
    @ mline+1,mcol SAY score PICTURE '99'
    ENDIF
    SKIP
    STORE mcol+4 TO mcol
    ENDDO
  GOTO TOP
    STORE 10 TO mcol
    DO WHILE .NOT. EOF( )
    IF mcol = 10
    @ mline+2,mcol SAY 'Handicaps:'
    @ mline+2,mcol+13 SAY hdcp PICTURE '99'
    STORE mcol+13 TO mcol
    ELSE
    @ mline+2,mcol SAY hdcp PICTURE '99'
    ENDIF
    SKIP
    STORE mcol+4 TO mcol
    ENDDO
  GOTO TOP
    STORE 10 TO mcol
    DO WHILE .NOT. EOF ( )
    IF mcol = 10
    @ mline+3,mcol SAY 'Nets:'
    @ mline+3,mcol+13 SAY (score-hdcp) PICTURE '99'
    STORE mcol+13 TO mcol
    ELSE
    @ mline+3,mcol SAY (score-hdcp) PICTURE '99'
    ENDIF
    SKIP
    STORE mcol+4 TO mcol
    ENDDO
  SELECT c
  SKIP
  STORE mline+6 TO mline
    IF mline > 55
@ 58,1 SAY 'Contiued on Next Page'
      *  @ mLine+2,0 SAY '
EJECT
    STORE 3 TO mline
    STORE mpage+1 TO mpage
    @ mline,1 SAY 'Page'
    @ mline,6 SAY mpage Picture '9'
    @ mline,31 SAY 'Bogie Busters Standings'
    @ mline+1,38 SAY DATE( )
    @ mline+2,34 SAY 'Using'
    @ mline+2,40 SAY mcnt Picture '9'
    @ mline+2,43 SAY 'Rounds'
    STORE mline+5 TO mline
    ENDIF
  ENDDO
@ 58,1 SAY 'Last Page'
*SET DEVICE TO SCREEN
*MODI FILE TEMP01.TXT
*STORE 'Y' TO mprt
*CLEAR
*@ 3,10 SAY "Do you wish to print: (Y<->N)" GET mprt PICTURE 'Y'
*READ
* IF mprt = 'Y'
* PRINT FILE TEMP01.TXT
* ENDIF
CLOSE DATABASES
DELETE FILE temp01.dbf
DELETE FILE temp02.dbf
DELETE FILE temp03.dbf
DELETE FILE temp04.dbf
DELETE FILE temp02.ndx
DELETE FILE temp01.txt