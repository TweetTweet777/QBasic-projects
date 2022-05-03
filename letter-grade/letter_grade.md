LETTER_GRADE Exercise

Design a flowchart 
Create an Initial Test Plan and use the “MANUAL RESULTS” column as your Desk Check for your flowchart.  You are to create ALL the test data based on the requirements (see below)
Code, Test and Debug 

The teacher needs a program that will determine the letter grade assigned to a student based on his/her average for the term.  The program should read the student’s name (STU.NAME$), Test Average (TEST.AVG%), and Daily Work Average (DAILY.AVG%).  The program must calculate the student’s Term Average (TERM.AVG!).  The term average will be 50% the test average and 50% the daily average.  The program must assign a NCEA mark for the term (NCEA.GRADE$) based on the student’s Term Average. The NCEA grade will be determined by the following range:  
	
100-90 = Excellence		89.99-80 = Merit	
79.99-50 = Achieved		Below 50 = Not Achieved

The program must print the student’s name, term average and NCEA grade, with appropriate headings.

REQUIRED SPECIFICATIONS FOR FLOWCHART AND CODE:  
Flowchart must use 4 (or more) subroutines.
Your logic must use logical expressions (e.g. using AND -or- OR) with Boolean operators (e.g. =, >=, <=, <> ,etc.).
The detail line output must be on ONE line.  For example:

Chris Hemsworth		87		Merit

Use PRINT USING for, at minimum, the detail lines.  (Give this a try…it will be hard, but you have to use it in your assessments this year.  Google how to use PRINT USING in QB64 if you need some extra help. ) 

TEST DATA CHALLENGE:  you need to come up with numbers that will result in the Term Average equaling a boundary case value for ALL the different NCEA grades.  You may work with a partner to create your comprehensive Test Data ☺ .  This will require some CRITICAL THINKING!

For example,  you need Term Averages to cover all the boundary cases for the “Achieved” letter grade range:

Below			                            Right On 			                    	Above
49 (should result in “Not Achieved”)	50 (should result in “Achieved”)		51 (should result in “Achieved”)
			
