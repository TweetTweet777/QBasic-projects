'clears screen and makes fullscreen
CLS
_FULLSCREEN
calculator

'halts execution
END

SUB calculator
    COLOR 10
    PRINT
    PRINT "Sum/Average Calculator"
    PRINT "----------------------"
    PRINT

    'prompts user for 3 numbers
    COLOR 9
    INPUT "Enter Number 1/3: ", NUM1%
    INPUT "Enter Number 2/3: ", NUM2%
    INPUT "Enter Number 3/3: ", NUM3%

    ' calculates average and sum
    SUM% = NUM1% + NUM2% + NUM3%
    AVG! = (NUM1% + NUM2% + NUM3%) / 3

    PRINT ""
    PRINT ""
    PRINT ""
    COLOR 11

    ' displays results
    PRINT "Sum & Average Calculator"
    PRINT "----------------------"
    PRINT
    PRINT "Results: "
    PRINT
    PRINT "Inputed numbers"
    PRINT " Number 1: "; NUM1%
    PRINT " Number 2: "; NUM2%
    PRINT " Number 3: "; NUM3%
    PRINT ""
    PRINT " Sum: "; SUM%
    PRINT ""
    PRINT " Average: "; AVG!

    COLOR 12
    PRINT
    PRINT
    PRINT

    ' asks user if they want to restart
    PRINT "Would you like to restart? (y/n)"
    INPUT "", RESTART$
    IF RESTART$ = "y" THEN
        CLS
        calculator
    END IF
    ' terminates sub
END SUB
