CLS
INPUT "SURNAME: ", sname$
INPUT "Exam Rating: ", X
INPUT "Personality Rating: ", A
INPUT "Course Rating: ", B
INPUT "Assignment Rating: ", C

Z = X + A - (X * B) + (C / X)
Rating! = X + Z * 0.85

PRINT "Teacher", , "Rating"
PRINT "-------", , "------"
PRINT sname$, , Rating!
