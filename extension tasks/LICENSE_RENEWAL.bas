CLS

INPUT "First Name: ", fname$
INPUT "Surname: ", sname$

sname$ = UCASE$(sname$)
fname$ = UCASE$(fname$)
letter$ = LEFT$(sname$, 1)
ascii% = ASC(letter$)

IF (ascii% >= 65) AND (ascii% <= 70) THEN
    month$ = "JANUARY"
ELSEIF (ascii% >= 71) AND (ascii% <= 76) THEN
    month$ = "FEBRUARY"
ELSEIF (ascii% >= 77) AND (ascii% <= 81) THEN
    month$ = "MARCH"
ELSEIF (ascii% >= 81) AND (ascii% <= 90) THEN
    month$ = "APRIL"
ELSE
    PRINT "Invalid Data!"
    END
END IF

PRINT

PRINT "First Name", , "Surname", , "Month of Renewal"
PRINT "----------", , "-------", , "----------------"
PRINT fname$, , sname$, , month$

END
