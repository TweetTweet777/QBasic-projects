'Clears screen
Cls

'Collects all inputs
Input "Input car type (economy, luxury or sport): ", CAR.TYPE$: CAR.TYPE$ = LCase$(CAR.TYPE$): Input "Input number of days: ", DAYS%: Input "Input kilometers to be travelled: ", KMS%: Input "Input insurance plan (1 or 2): ", INSURANCE%

'Calculates BASIC.CHG! and MLG.CHG!
If CAR.TYPE$ = "economy" Then
    BASIC.CHG! = 20 * DAYS%
    MLG.CHG! = 0.5 * KMS%
ElseIf CAR.TYPE$ = "sport" Then
    BASIC.CHG! = 40 * DAYS%
    MLG.CHG! = 0.65 * KMS%
ElseIf CAR.TYPE$ = "luxury" Then
    BASIC.CHG! = 75 * DAYS%
    MLG.CHG! = 0.8 * DAYS%
End If

'Calculates INS.CHG!
If INSURANCE% = 1 Then
    INS.CHG! = 0.2 * (BASIC.CHG! + MLG.CHG!)
Else
    INS.CHG! = DAYS% * 15
End If

'Calculates TOTAL.CHG!
TOTAL.CHG! = BASIC.CHG! + MLG.CHG! + INS.CHG!

'Prints stuff
Cls: Print Tab(27); "Acme Car Rental Company"
Print Tab(27); String$(23, "*")
Print
Print , "BASIC", "MILEAGE", "INSURANCE", "TOTAL"
Print , "CHARGE", "CHARGE", "CHARGE", "CHARGE"
Print , "******", "*******", "*********", "******"
Print , "$" + Str$(BASIC.CHG!), "$" + Str$(MLG.CHG!), "$" + Str$(INS.CHG!), "$" + Str$(TOTAL.CHG!)

'literally that
End

'NOTE: input validation and other fancy stuff on other thingie
