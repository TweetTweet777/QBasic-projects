ON ERROR GOTO handler

CLS

INPUT "Input file name: ", file$

CLS

PRINT TAB(20); "Biggest"; TAB(50); "Smallest"
PRINT TAB(20); "*******"; TAB(50); "********"

OPEN file$ FOR INPUT AS #1

DO

    INPUT #1, a!
    INPUT #1, b!
    INPUT #1, c!

    IF (c! > a!) THEN
        tmp! = a!
        a! = c!
        c! = tmp!
    END IF

    IF (c! > b!) THEN
        tmp! = c!
        c! = b!
        b! = tmp!
    END IF

    IF (b! > a!) THEN
        tmp! = a!
        a! = b!
        b! = tmp!
    END IF

    IF (a! = b! AND a! = c!) THEN
        PRINT TAB(27); "All numbers equal "; a!; "!"
    ELSE
        PRINT TAB(20); a!;
        PRINT TAB(50); c!
    END IF

LOOP UNTIL (EOF(1))

CLOSE #1

handler:
errorflag = ERR
RESUME NEXT


