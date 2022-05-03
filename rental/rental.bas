'FILENAME: RENTAL.BAS
'PROGRAMMER: Ly, Max
'DATE: 12/04/2022
'VERSION: Not Final

'PURPOSE: The purpose of this program is to calculate the cost of renting a car based on the type of car they rented, what insurance plan they have, how long they rented and how long they travelled

'INPUT:  This program will require the user to enter the type of car they rented, which (out of 2 options) insurance plan they have, how many days they rented the car for and how long they travelled within that time period

'PROCESSING:  The program will calculate the total basic rental charge, the total mileage charge and the total amount owed to "Acme Car Rental Company"

'OUTPUT:  The program will output the total basic rental charge, the total mileage charge, the total insurance charge and the total amount owed with appropriate headings.

'Data Dictionary

'Data Name       Data Type   Represents

'CAR.TYPE$       String      Type of car rented
'DAYS%           Integer     Amount of days car has been rented for
'KMS%            Integer     Distance driven throughout the rental period
'INSURANCE%      Integer     Type of insurance plan
'BASIC.CHG!      Float       Daily rental charge
'MLG.CHG!        Float       Mileage charge
'INS.CHG!        Float       Insurance fee
'TOTAL.CHG!      Float       Total amount owed
'-------------------------------------------------------------------------------------------------------------------------------

'clear screen
CLS

DO UNTIL CAR! = 4

    CAR! = 0
    INPUT "Type of Car Rented (economy, sport or luxury): ", CAR.TYPE$
    CAR.TYPE$ = LCASE$(CAR.TYPE$)

    IF CAR.TYPE$ = "economy" THEN
        CAR! = CAR! + 1
        BASIC.CHG! = 20
        MLG.CHG! = 0.5
    END IF

    IF CAR.TYPE$ = "sport" THEN
        CAR! = CAR! + 1
        BASIC.CHG! = 40
        MLG.CHG! = 0.65
    END IF

    IF CAR.TYPE$ = "luxury" THEN
        CAR! = CAR! + 1
        BASIC.CHG! = 75
        MLG.CHG! = 0.8
    END IF

    IF CAR! = 1 THEN
        CAR! = 4
    ELSE
        CLS
        PRINT "INVALID DATA!"
    END IF

LOOP

DO UNTIL DAYS% > 0
    INPUT "Amount of Days Rented: ", DAYS%
    IF DAYS% <= 0 THEN
        CLS
        PRINT "INVALID DATA!"
    END IF
LOOP
BASIC.CHG! = DAYS% * BASIC.CHG!

DO UNTIL KMS% > 0
    INPUT "Distance Travelled (KMS): ", KMS%
    IF KMS% <= 0 THEN
        CLS
        PRINT "INVALID DATA!"
    END IF

LOOP
MLG.CHG! = KMS% * MLG.CHG!

DO WHILE (INSURANCE% < 1) OR (INSURANCE% > 2)
    INPUT "Insurance Plan (1 or 2): ", INSURANCE%
    IF (INSURANCE% < 1) OR (INSURANCE% > 2) THEN
        CLS
        PRINT "INVALID DATA!"
    END IF
LOOP

IF INSURANCE% = 1 THEN
    INS.CHG! = 0.2 * (BASIC.CHG! + MLG.CHG!)
ELSE
    INS.CHG! = 15 * DAYS%
END IF

TOTAL.CHG! = BASIC.CHG! + MLG.CHG! + INS.CHG!

PRINT , , "Acme Car Rental Company"
PRINT , , "The Tax Evasion Calculator"
PRINT , , "--------------------------"
PRINT
PRINT
PRINT , "Basic Charge", , "Mileage Charge"
PRINT , "------------", , "--------------"
PRINT , BASIC.CHG!, , MLG.CHG!,
PRINT
PRINT , "Insurance Charge", "Total Charge"
PRINT , "----------------", "------------"
PRINT , INS.CHG!, , TOTAL.CHG!

