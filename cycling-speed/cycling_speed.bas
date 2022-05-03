'








'DATA Dictionary

'Data Name       Data Type   Represents

'wheelrev!       Decimal     Wheel Revolutions
'mins!           Decimal     Time Cycling (in minutes)
'Circumference!  Decimal     Wheel Circumference (in mm)
'kmtravel!       Decimal     Distance travelled (in km)
'avgspeed!       Decimal     Average Speed (in km/h)

'clear screen
10 CLS

'makes program fullscreen and changes color
_FULLSCREEN
calculations

SUB calculations
    'prompts user to enter circumference, revolutions and minutes
    30 INPUT "wheel circumference (mm): ", pain!
    40 INPUT "amount of wheel revolutions: ", wheelrev!
    50 INPUT "minutes cycling: ", mins!

    'calculations for average speed and distance
    70 kmtravel! = (pain! / 1000000) * wheelrev!
    80 avgspeed! = kmtravel! / (mins! / 60)

    'gives the user false hope by making them think the program is taking time to process the information
    'RND function gives a random integer of 0 or 1
    100 PRINT ""
    PRINT "Calculating..."
    SLEEP (RND + RND + RND + RND + RND + RND + RND + RND + RND + RND)
    PRINT ""
    PRINT "Hold on..."
    PRINT ""
    SLEEP (RND + RND + RND + RND + RND)
    PRINT "Nearly there..."
    PRINT ""
    SLEEP (RND + RND + RND)

    'outputs distance covered and average speed
    PRINT ""
    PRINT ""
    PRINT "CYCLING SPEED"
    PRINT "AVERAGE CALCULATOR"
    PRINT "------------------"
    PRINT ""
    PRINT ""
    PRINT "KILOMETERS", "", "AVERAGE   "
    PRINT "TRAVELLED", "", "SPEED     "
    PRINT "----------", "", "-------   "
    PRINT kmtravel!; "kms", "", avgspeed!; "km/h"
    'stops program execution
END SUB
