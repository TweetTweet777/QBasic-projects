'clears screen
CLS

'calls subroutines in set order
GOSUB printheadings
GOSUB printsubheadings
GOSUB reading
GOSUB calculate
GOSUB validation
GOSUB printoutput

END

'sub for reading data
reading:
READ NAME$, TEST1%, TEST2%, TEST3%, CREDITS%
RETURN

'sub for calculating score average and whether the student passes or not
calculate:
AVGSCORE! = (TEST1% + TEST2% + TEST3%) / 3
IF (AVGSCORE! >= 70 AND CREDITS% >= 18) THEN PASS$ = "Pass" ELSE PASS$ = "Fail"
RETURN

'prints headings
printheadings:
PRINT TAB(30); "Year 11 Programming"
PRINT TAB(31); "Term 1 Final Mark"
PRINT TAB(30); STRING$(19, "*")
PRINT
RETURN

'prints subheadings
printsubheadings:
PRINT TAB(7); "Student";
PRINT TAB(23); "Term 1 Average";
PRINT TAB(47); "Credits";
PRINT TAB(64); "Term 1 Status"
PRINT TAB(7); STRING$(7, "*"); TAB(23); STRING$(14, "*"); TAB(47); STRING$(7, "*"); TAB(64); STRING$(13, "*")
RETURN

'prints output
printoutput:
PRINT TAB(alignfraction(NAME$, 1, 4)); NAME$;
PRINT TAB(alignfraction(STR$(AVGSCORE!), 2, 4)); AVGSCORE!;
PRINT TAB(alignfraction(STR$(CREDITS%), 3, 4)); CREDITS%;
PRINT TAB(alignfraction(PASS$, 4, 4)); PASS$
RETURN

'sub for data validation
validation:
IF TEST1% < 0 OR TEST2% < 0 OR TEST3% < 0 OR CREDITS% < 0 THEN
    NAME$ = "Contains Invalid Data!"

END IF
RETURN

'function for aligning text (not own work)
FUNCTION alignfraction (in$, position%, slots%)
    slots% = 80 / slots%
    position% = (position% - 1) * slots%
    tabspot% = (slots% - LEN(in$)) / 2
    alignfraction = tabspot% + position%
END FUNCTION

'data
DATA "David Bowie",80,55,75,17
