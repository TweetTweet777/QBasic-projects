Cls

GoSub printheadings
GoSub printsubheadings
Read NAME$, TEST1%, TEST2%, TEST3%, CREDITS%
GoSub calculate
GoSub printoutput

End

calculate:
AVGSCORE! = (TEST1% + TEST2% + TEST3%) / 3
If (AVGSCORE! >= 70 And CREDITS% >= 18) Then PASS$ = "Pass" Else PASS$ = "Fail"
Return

printheadings:
Print Tab(30); "Year 11 Programming"
Print Tab(31); "Term 1 Final Mark"
Print Tab(30); String$(19, "*")
Print
Return

printsubheadings:
Print Tab(7); "Student";
Print Tab(23); "Term 1 Average";
Print Tab(47); "Credits";
Print Tab(64); "Term 1 Status"
Print Tab(7); String$(7, "*"); Tab(23); String$(14, "*"); Tab(47); String$(7, "*"); Tab(64); String$(13, "*")
Return

printoutput:
Print Tab(alignfraction(NAME$, 1, 4)); NAME$;
Print Tab(alignfraction(Str$(AVGSCORE!), 2, 4)); AVGSCORE!;
Print Tab(alignfraction(Str$(CREDITS%), 3, 4)); CREDITS%;
Print Tab(alignfraction(PASS$, 4, 4)); PASS$
Return

Function alignfraction (in$, position%, slots%)
    slots% = 80 / slots%
    position% = (position% - 1) * slots%
    tabspot% = (slots% - Len(in$)) / 2
    alignfraction = tabspot% + position%
End Function

Data "Poopy McPants",87,35,85,19
