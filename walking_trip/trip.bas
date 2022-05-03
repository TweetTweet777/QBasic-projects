'FILENAME: TRIP.BAS
'PROGRAMMER: Ly, Max
'DATE: 18/03/2022
'VERSION: Final

'PURPOSE: The purpose of this program is to calculate the return trip distance between 2 cities and the total cost of petrol when driving the return trip distance

'INPUT:  This program will require the user to enter the city they are leaving from, the city they are travelling to, and the one-way distance. Cost of Petrol and Mileage are assigned

'PROCESSING:  The program will calculate the return trip distance and the total cost of petrol.

'OUTPUT:  The program will output the departure city, the destination city, the total kilometres travelled and the total cost of petrol with appropriate headings.

'Data Dictionary

'Data Name       Data Type   Represents
'MLG%            Integer     Milage of the car
'PTRL.LTR!       Decimal     Cost of petrol per litre
'DEPART$         String      Name of place of origin
'DIST!           Decimal     Distance one way between 2 places (in km)
'DESTN$          String      Name of Destination
'TOT.DIST!       Decimal     Distance of round trip (in km)
'TOT.COST!       Decimal     Total cost of fuel ($)
'-------------------------------------------------------------------------------------------------------------------------------

'clear screen
CLS

'makes program fullscreen and changes color
_FULLSCREEN

'sets constants for later equations
MLG! = 10
PTRL.LTR! = 2.1


'prompts user to enter Origin, Destination and one way distance
PRINT
PRINT "Trip Calculator"
PRINT "Round Trip Fuel Cost"
PRINT "--------------------"
PRINT

INPUT "Name of Origin: ", DEPART$
INPUT "Name of Destination: ", DESTN$
INPUT "One-Way Distance: ", DIST!

'checks if distance is a positive value
IF DIST! < 0 THEN
    PRINT
    PRINT "DISTANCE CANNOT BE A NEGATIVE VALUE!"
    PRINT
    END
END IF

'calculations to work out total distance and fuel cost
LET TOT.DIST! = DIST! * 2

LET TOT.COST! = (TOT.DIST! / MLG!) * PTRL.LTR!

'Print Headings
PRINT: PRINT
PRINT "Trip Calculator"
PRINT "Round Trip Fuel Cost"
PRINT "--------------------"
PRINT: PRINT

'prints Origin, Destination, Total distance and total fuel cost
PRINT "ORIGIN", "", "", "DESTINATION   "
PRINT "------", "", "", "-----------   "
PRINT DEPART$, "", "", DESTN$
PRINT
PRINT "ROUND TRIP DISTANCE", "", "TOTAL COST OF FUEL"
PRINT "-------------------", "", "------------------   "
PRINT TOT.DIST!; "km", "", "", "$"; TOT.COST!

' terminates program
END

