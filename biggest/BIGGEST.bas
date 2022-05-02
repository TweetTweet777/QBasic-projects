On Error GoTo handler

Cls

Input "Input file name: ", file$

Cls

Print Tab(20); "Biggest"; Tab(50); "Smallest"
Print Tab(20); "*******"; Tab(50); "********"

Open file$ For Input As #1

Do

    Input #1, a!
    Input #1, b!
    Input #1, c!

    If (c! > a!) Then
        tmp! = a!
        a! = c!
        c! = tmp!
    End If

    If (c! > b!) Then
        tmp! = c!
        c! = b!
        b! = tmp!
    End If

    If (b! > a!) Then
        tmp! = a!
        a! = b!
        b! = tmp!
    End If

    If (a! = b! And a! = c!) Then
        Print Tab(27); "All numbers equal "; a!; "!"
    Else
        Print Tab(20); a!;
        Print Tab(50); c!
    End If

Loop Until (EOF(1))

Close #1

handler:
errorflag = Err
Resume Next

