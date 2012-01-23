#!/bin/awk -f
#this is the begin block run once at the beginning
#use it to initialize everything
BEGIN { FS="\t"; newgacc = oldgacc = newyear = oldyear = 0;  
	
	totalAssignments =0;
	totalAssignmentsOver7 = 0;
	totalNumDays = 0;
	totalNumDaysLessTrav = 0;
	totalNumDaysOver7LessTrav = 0;
	averageNumDays = 0;
	averageNumDaysLessTrav = 0;
	averageNumDaysOver7LessTrav = 0;	
	
	yeartotalAssignments =0;
	yeartotalAssignmentsOver7 = 0;
	yeartotalNumDays = 0;
	yeartotalNumDaysLessTrav = 0;
	yeartotalNumDaysOver7LessTrav = 0;
	yearaverageNumDays = 0;
	yearaverageNumDaysLessTrav = 0;
	yearaverageNumDaysOver7LessTrav = 0;	

	grandtotalAssignments =0;
	grandtotalAssignmentsOver7 = 0;
	grandtotalNumDays = 0;
	grandtotalNumDaysLessTrav = 0;
	grandtotalNumDaysOver7LessTrav = 0;
	grandaverageNumDays = 0;
	grandaverageNumDaysLessTrav = 0;
	grandaverageNumDaysOver7LessTrav = 0;	
} 

#Each of these blocks triggers when the regular expression matches the line	

#When you get a new GACC print the
#counts, set the GACC variable and reset all the counts	
	/(Inc GACC Org Name:)|(Inc Calendar Year: 2...)/  {
		newgacc = $1;
		if (oldgacc != 0)
		{
			if (totalAssignments == 0)
			{
				averageNumDays = 0;
				averageNumDaysLessTrav = 0;
				averageNumDaysOver7LessTrav = 0;
			}
			
			else 
			{#compute averages
			averageNumDays = totalNumDays / totalAssignments;
			averageNumDaysLessTrav = totalNumDaysLessTrav /	totalAssignments;
				if (totalAssignmentsOver7 != 0)
				{		
averageNumDaysOver7LessTrav = totalNumDaysOver7LessTrav / totalAssignmentsOver7;	
				}
			}
			print oldgacc, "\t", totalAssignments, "\t", 
			totalAssignmentsOver7, "\t", totalNumDays, "\t",
			totalNumDaysLessTrav, "\t",totalNumDaysOver7LessTrav,
			"\t",averageNumDays,"\t", averageNumDaysLessTrav,"\t", 
			averageNumDaysOver7LessTrav;
			totalAssignments = 0;
			totalAssignmentsOver7 = 0;
			totalNumDays = 0;
			totalNumDaysLessTrav = 0;
			totalNumDaysOver7LessTrav = 0;
			averageNumDays = 0;
			averageNumDaysLessTrav = 0;
			averageNumDaysOver7LessTrav = 0;

		}
		oldgacc = newgacc;
	}

#When new year set the year variable
	/Inc Calendar Year: 2.../ {
		newyear = $1;
		if (oldyear != 0)
		{
		if (yeartotalAssignments != 0)
		{	#compute averages
			yearaverageNumDays = yeartotalNumDays / yeartotalAssignments;
	yearaverageNumDaysLessTrav = yeartotalNumDaysLessTrav /	yeartotalAssignments;
}
	if (yeartotalAssignmentsOver7 != 0)
	{
yearaverageNumDaysOver7LessTrav = yeartotalNumDaysOver7LessTrav / yeartotalAssignmentsOver7;	}

			print oldyear, "\t", yeartotalAssignments,"\t", 
			yeartotalAssignmentsOver7,"\t", yeartotalNumDays,"\t",
			yeartotalNumDaysLessTrav, "\t", yeartotalNumDaysOver7LessTrav, "\t", yearaverageNumDays, "\t",  yearaverageNumDaysLessTrav, "\t", 
			yearaverageNumDaysOver7LessTrav;

		yeartotalAssignments =0;
		yeartotalAssignmentsOver7 = 0;
		yeartotalNumDays = 0;
		yeartotalNumDaysLessTrav = 0;
		yeartotalNumDaysOver7LessTrav = 0;
		yearaverageNumDays = 0;
		yearaverageNumDaysLessTrav = 0;
		yearaverageNumDaysOver7LessTrav = 0;	

	}
	oldyear = newyear;
}
		
	{
		#count stuff only if it is a fire incident
		if ( index($4, "Fire") > 0)
		{
			totalAssignments += 1; #count each assignment
			grandtotalAssignments +=1;
			yeartotalAssignments += 1;
		if ($10 >= 7) {
			totalAssignmentsOver7 += 1;
			grandtotalAssignmentsOver7 += 1;
			yeartotalAssignmentsOver7 +=1;
			totalNumDaysOver7LessTrav += $10 - 2;
			grandtotalNumDaysOver7LessTrav += $10 - 2;
			yeartotalNumDaysOver7LessTrav += $10 - 2;
			}

		totalNumDays += $10;
		grandtotalNumDays += $10;
		yeartotalNumDays += $10;
		totalNumDaysLessTrav += $10 - 2;
		grandtotalNumDaysLessTrav +=$10 - 2;
		yeartotalNumDaysLessTrav +=$10 - 2;
	}
}	

	 
END {print "Total Number of Records: " NR;
	grandaverageNumDays = grandtotalNumDays / grandtotalAssignments;
	grandaverageNumDaysLessTrav = grandtotalNumDaysLessTrav / grandtotalAssignments;
grandaverageNumDaysOver7LessTrav = grandtotalNumDaysOver7LessTrav / grandtotalAssignmentsOver7;

			print "Grand Totals: ","\t", grandtotalAssignments,"\t", 
			grandtotalAssignmentsOver7, "\t",grandtotalNumDays,
			"\t",grandtotalNumDaysLessTrav,"\t", 
			grandtotalNumDaysOver7LessTrav,"\t",
			grandaverageNumDays,"\t", grandaverageNumDaysLessTrav, 
			"\t",grandaverageNumDaysOver7LessTrav;
}
