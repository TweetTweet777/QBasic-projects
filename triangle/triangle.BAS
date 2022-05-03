CLS
i& = _NEWIMAGE(800, 600, 32)
SCREEN i&
COLOR &HC0FFFF00, &H200000FF

f& = _LOADFONT("C:\Windows\Fonts\Courier.ttf", 25)



PRINT "Microsoft Windows [Version 21H2]"
PRINT "(c) 2021 Microsoft Comporation. All rights reserved"
30
PRINT
INPUT "C:\Windows\System32>", SEL$


IF SEL$ = "1" THEN
    PRINT
    triangle1
ELSEIF SEL$ = "2" THEN
    PRINT
    triangle2
ELSEIF SEL$ = "help" THEN
    PRINT
    PRINT "lmao no"
    GOTO 30
ELSE
    PRINT
    PRINT "Invalid Command"
    GOTO 30
END IF
END

SUB triangle1
    i& = _NEWIMAGE(800, 600, 32)
    SCREEN i&
    COLOR &HC0FFFF00, &H200000FF

    IF neg% = 1 THEN
        PRINT "Cannot be a negative value!"
    END IF
    neg% = 0


    INPUT "Input First Length: ", SIDE1%
    INPUT "Input Second Length: ", SIDE2%
    INPUT "Input Third Length: ", SIDE3%

    IF (SIDE1% <= 0) OR (SIDE2% <= 0) OR (SIDE3% <= 0) THEN
        neg% = 1
        triangle2
        END
    END IF

    IF SIDE1% = SIDE2% THEN

        IF SIDE2% = SIDE3% THEN
            TRI$ = "Equalateral"
        ELSE
            TRI$ = "Isosceles"
        END IF

    ELSEIF SIDE1% = SIDE3% THEN
        TRI$ = "Isosceles"
    ELSEIF SIDE2% = SIDE3% THEN
        TRI$ = "Isosceles"
    ELSE
        TRI$ = "Scalene"
    END IF

    PRINT: PRINT

    PRINT "Side 1", "Side 2", "Side 3"
    PRINT SIDE1%, SIDE2%, SIDE3%
    PRINT
    PRINT "Type of Triangle"
    PRINT TRI$
    PRINT "Would you like to restart? (y/n)"
    INPUT "", RESTART$
    IF RESTART$ = "y" THEN
        CLS
        triangle1
    END IF

END SUB

SUB triangle2
    i& = _NEWIMAGE(800, 600, 32)
    SCREEN i&
    COLOR &HC0FFFF00, &H200000FF
    IF neg% = 1 THEN
        PRINT "Cannot be a negative value!"
    END IF
    neg% = 0

    INPUT "Input First Length: ", SIDE1%
    INPUT "Input Second Length: ", SIDE2%
    INPUT "Input Third Length: ", SIDE3%

    IF (SIDE1% <= 0) OR (SIDE2% <= 0) OR (SIDE3% <= 0) THEN
        neg% = 1
        triangle2
        END
    END IF

    IF (SIDE1% = SIDE2%) AND (SIDE2% = SIDE3%) THEN
        TRI$ = "Equalateral"
    ELSEIF (SIDE1% = SIDE2%) OR (SIDE2% = SIDE3%) OR (SIDE1% = SIDE3%) THEN
        TRI$ = "Isosceles"
    ELSE
        TRI$ = "Scalene"
    END IF

    PRINT: PRINT

    PRINT "Side 1", "Side 2", "Side 3"
    PRINT SIDE1%, SIDE2%, SIDE3%
    PRINT
    PRINT "Type of Triangle"
    PRINT TRI$
    PRINT "Would you like to restart? (y/n)"
    INPUT "", RESTART$
    IF RESTART$ = "y" THEN
        CLS
        triangle2
    END IF

END SUB
