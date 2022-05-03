CLS

INPUT " Date (dd-mm-yyyy) ", D$

PRINT

INPUT " Amount of sundaes sold: ", SUNDAE!
INPUT " Amount of cones sold: ", CONE!
INPUT " Amount of shakes sold: ", SHAKE!

ICE! = ((200 * SUNDAE!) + (170 * CONE!) + (300 * SHAKE!)) / 1000
SAUCE! = ((60 * SUNDAE!) + (30 * SHAKE!)) / 1000
NUT! = (SUNDAE! * 30) / 1000

PRINT
PRINT , "ICE CREAM", "SAUCE", "NUTS", "CONES"
PRINT D$, ICE!; "kg", SAUCE!; "kg", NUT!; "kg", CONE!; "kg"
