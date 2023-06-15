
clear 
set more off
capture log close
set type double

*Setting my working directories and folders and log file, change the path here to be able to reproduce my results.

	global path = "/Users/stevenjean/Documents/Econ 2708 Final Project/" 
	global output = "$path/Output"
	global input = "$path/Input"
	global scripts = "$path/Scripts"

	log using "$path/Logs/Econ 2708 Final Project Log", text replace
	
************************************
* Dataset 1 Input, cleaning and saving data *
*************************************
*here I import the CSV file containing the data on money aggregate demand m1 m1+ and m2
import delimited "/Users/stevenjean/Documents/Econ 2708 Final Project/Input/ATABLE_MONETARY_AGGREGATES.csv", varnames(20) clear 
*here I create a new variable with all the new variable names that I want.
generate str newname = "M1" in 1
replace newname = "M1v2" in 2
replace newname = "M2" in 3
*here I create a new variabel with all the old variables names that are already there
generate str oldname = "static_atable_v37151" in 1 
replace oldname = "static_atable_v37152" in 2 
replace oldname = "static_atable_v41552801" in 3


*here I create a forloop that renames all the old variable into the new variables
count if ~missing(newname)
    return list 
    local N = r(N)

    forvalues i=1(1)`N' {
        local vname = oldname in `i' 
        local newname  = newname in `i'
  
        rename `vname' `newname'
    }

*Here I label all my variables
label variable M1 "M1"
label variable M1v2 "M1+"
label variable M2 "M2"

*here I drop the variables with the old and new names since I do not need them anymore
drop newname
drop oldname

*dropping all the missing values
drop if missing(M1v2)
*here I save my dataset in my output folder
save "$path/Output/Money Aggregate Dataset Clean", replace

************************************
* Dataset 2 Input, cleaning and saving data *
*************************************

clear 

import delimited "/Users/stevenjean/Documents/Econ 2708 Final Project/Input/INDINF_CPI_2.csv", varnames(11) clear 

*here I create a new variable with all the new variable names that I want.
generate str newname = "Inflation" in 1
replace newname = "CPI_Target_Low" in 2
replace newname = "CPI_Target_High" in 3


*here I create a new variabel with all the old variables names that are already there
generate str oldname = "indinf_cpi_m" in 1 
replace oldname = "indinf_lowtarget" in 2 
replace oldname = "indinf_upptarget" in 3

*here I create a forloop that renames all the old variable into the new variables
count if ~missing(newname)
    return list 
    local N = r(N)

    forvalues i=1(1)`N' {
        local vname = oldname in `i' 
        local newname  = newname in `i'
  
        rename `vname' `newname'
    }
	
*Here I label all my variables
label variable Inflation "Inflation Rate"
label variable CPI_Target_Low "The Low Target for Inflation"
label variable CPI_Target_High "The High Target for Inflation"
*here I drop the variables that I no longer need
drop newname
drop oldname
drop CPI_Target_High
drop CPI_Target_Low

*here I save my dataset in my output folder
save "$path/Output/Inflation Dataset Clean", replace

************************************
* Merging The Datasets *
*************************************
* Here I clear my memory first
clear
* Here I open my money supply dataset
use "$path/Output/Money Aggregate Dataset Clean"
*Here I merge the money supply dataset with the inflation dataset using date as the key variable
merge 1:1 date using "$path/Output/Inflation Dataset Clean"
*here I only keep the observations that were matched
drop if _merge==2 | _merge==1

save "$path/Output/Final Project Dataset", replace




*here I generate new aggregate demand of money variables which are lagged by 12 months to see the actual effect supplying more money had on inflation.
gen M2_L1=M2[_n-12]

gen M1_L1=M1[_n-12]

gen M1v2_L1=M1v2[_n-12]
*here I do the regressions on the supply of money
regress Inflation M2_L1
outreg2 using "$output/regressionM2_L1", excel replace
regress Inflation M1_L1 
outreg2 using "$output/regressionM1_L1", excel replace
regress Inflation M1v2_L1 
outreg2 using "$output/regressionM1v2_L1", excel replace

*here I do the graph to see the effect supplying more money has on inflation.
graph twoway (lfit Inflation M2_L1) (scatter Inflation M2_L1), title("The effect of M2 on Inflation") xtitle("Money Supply") ytitle("Inflation Rate")
graph export "$path/Output/The Effect of M2 on Inflation.pdf", replace
*here i create a dummy variable which gives the value 1 to see when inflation was over 5.6 and we see that that was during Covid times.
generate CovidDummy = 0
replace CovidDummy = 1 if Inflation > 5.6

*End of Do-File
