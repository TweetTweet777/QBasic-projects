On Error GoTo handler
line$ = "%"
check% = 0
loops% = 0
Cls

GoSub getinput

Cls

GoSub headings

Do Until EOF(1) Or loops% = 18
    Input #1, student$, test1%, test2%, test3%, credits%
    avgscore! = (test1% + test2% + test3%) / 3
    If (avgscore! >= 70 And credits% >= 18) Then pass$ = "Pass" Else pass$ = "Fail"
    GoSub outputs
    loops% = loops% + 1
Loop

Close #1

End

headings:
maintitle$ = "Year 11 Programming"
subtitle$ = "Term 1 Final Mark"
Print middlealign(maintitle$)
Print middlealign(subtitle$)
Print middlealign(String$(Len(maintitle$), line$))
Print
Print Tab(twenty("Student", 1, 4)); "Student"; Tab(twenty("Term 1 Average", 2, 4)); "Term 1 Average"; Tab(twenty("Credits", 3, 4)); "Credits"; Tab(twenty("Term 1 Status", 4, 4)); "Term 1 Status"
Print Tab(twenty(String$(Len("Student"), line$), 1, 4)); String$(Len("Student"), line$);
Print Tab(twenty(String$(Len("Term 1 Average"), line$), 2, 4)); String$(Len("Term 1 Average"), line$);
Print Tab(twenty(String$(Len("Credits"), line$), 3, 4)); String$(Len("Credits"), line$);
Print Tab(twenty(String$(Len("Term 1 Status"), line$), 4, 4)); String$(Len("Term 1 Status"), line$);
Return

outputs:
Print Tab(twenty(student$, 1, 4)); student$;
Print Tab(twenty(Str$(avgscore!), 2, 4)); avgscore!;
Print Tab(twenty(Str$(credits%), 3, 4)); credits%;
Print Tab(twenty(pass$, 4, 4)); pass$
Return

getinput:
Do While (LOF(1) = 0)
    If check% = 1 Then GoSub invalid
    Cls
    Input "Input file name: ", file$
    If (Not ((Right$(file$, 4)) = ".txt")) Then file$ = file$ + ".txt"
    Open file$ For Input As #1
    check% = 1
Loop
Return

invalid:
Cls
Print "Input file name: ";
Color 4
Print "INVALID INPUT!"
Color 7
Sleep 1
Cls
Return

handler:
errorflag = Err
Resume Next

Function middlealign$ (align$)
    spacer! = 40 - Int(Len(align$) / 2 - .5)
    middlealign = String$(spacer!, " ") + align$
End Function

Function twenty (in$, position%, tol%)
    tol% = 80 / tol%
    position% = (position% - 1) * tol%
    tabspot% = (tol% - Len(in$)) / 2
    twenty = tabspot% + position%
End Function
