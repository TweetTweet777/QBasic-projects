'Output file format:
'
'Student Name
'[Test Average] [Daily Average]

On Error GoTo handler

Cls
line$ = "*"
L00p% = 0

GoSub getinput
Cls
GoSub headings

Do Until EOF(1) Or L00p% = 18
    Input #1, student$, testavg%, dailyavg%
    GoSub calculate
    GoSub printoutput
    L00p% = L00p% + 1
Loop

End

printoutput:
Print Tab(fractionalign(student$, 1, 3)); student$;
Print Using "##.#"; Tab(fractionalign("##.#", 2, 3)); termavg!;
Print "%";
Print Tab(fractionalign(ncea$, 3, 3)); ncea$
Return

calculate:
termavg! = (testavg% + dailyavg%) / 2
ncea$ = "Not Achieved"
If termavg! >= 90 Then
    ncea$ = "Excellence"
ElseIf termavg! >= 80 Then
    ncea$ = "Merit"
ElseIf termavg! >= 50 Then
    ncea$ = "Achieved"
End If
Return

headings:
maintitle$ = "Year 11 Programming"
subtitle$ = "Term 1 Final Mark"
Print middlealign(maintitle$)
Print middlealign(subtitle$)
Print middlealign(String$(Len(maintitle$), line$))
title1$ = "Student"
title2$ = "Term Average"
title3$ = "NCEA Grade"
Print
Print Tab(fractionalign(title1$, 1, 3)); title1$; Tab(fractionalign(title2$, 2, 3)); title2$; Tab(fractionalign(title3$, 3, 3)); title3$
title1$ = String$(Len(title1$), line$)
title2$ = String$(Len(title2$), line$)
title3$ = String$(Len(title3$), line$)
Print Tab(fractionalign(title1$, 1, 3)); title1$; Tab(fractionalign(title2$, 2, 3)); title2$; Tab(fractionalign(title3$, 3, 3)); title3$
Return

getinput:
chek% = 0
Do While (LOF(1) = 0)
    If chek% = 1 Then GoSub invalid
    Cls
    Input "Input file name: ", file$
    If (Not ((Right$(file$, 4)) = ".txt")) Then file$ = file$ + ".txt"
    Open file$ For Input As #1
    chek% = 1
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

Function fractionalign (in$, position%, tol%)
    tol% = 80 / tol%
    position% = (position% - 1) * tol%
    tabspot% = (tol% - Len(in$)) / 2
    fractionalign = tabspot% + position%
End Function
