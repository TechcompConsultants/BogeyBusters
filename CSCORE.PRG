SELECT a
USE players
GOTO TOP

SELECT b
USE scores

SELECT a

  DO WHILE .NOT. EOF( )
  SELECT b
  SET FILTER TO code = a->code
  GOTO TOP
    IF .NOT. EOF()
    COUNT FOR code = a->code TO mno
    SUM score TO mtot
    STORE ( (mtot/mno)-36)*.8 TO mhdcp
    ELSE
    STORE 99.9 TO mhdcp
    ENDIF
    
  SELECT a
  REPLACE hdcp WITH mhdcp
  SKIP
  ENDDO


CLOSE DATABASES