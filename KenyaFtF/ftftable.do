/*We will create a program called starmaker. The purpose of the program is to 
calculate significance stars for hypothesis tests when we create results tables 
via putexcel. This works by running a regression and then typing 
"starmaker varname" in the command line. This will save the significance stars 
for the variable "varname" in a global macro called $stars*/

capture program drop starmaker // define the starmaker program
program define starmaker
				local coef: display %9.3f round(_b[`1'], 0.001) // Store regression coefficient
				local se: display %9.3f round(_se[`1'], 0.001) // Store standard error
				local t = abs(_b[`1']/_se[`1']) // Compute t-statistic
				local p = 2*ttail(e(df_r), `t') // Compute p-value
						if `p' >= 0.05{ // Significance stars
							local stars = "n/s"
						}
						if `p' < 0.05{
							local stars = "*"
						}
						if `p' < 0.01{
							local stars = "**"
						}				
						if `p' < 0.001{
							local stars = "***"
						}
global coef = ltrim("`coef'")
global se = ltrim("`se'")
global stars = ltrim("`stars'")
end

                          
/*We will create a program called ftftable. This is a program that will help
us automate the construction of the FTF outcome indicator tables.*/
capture program drop ftftable // drop the program if it already exists, and redefine.

program define ftftable //ftftable was created by Greg Haugan at NORC

syntax [varlist] , ///
	disaggregates(varlist numeric) /// variables to disaggregate by
	tablename(string) /// name of Excel table to output to
  rounddecimals(integer) // how many decimals do you want to round to?


putexcel set "$path/_out/Baseline Analysis/$S_DATE/`tablename'.xlsx" , replace // set up table
putexcel A2 = "Household Characteristic" B2 = "Mean" C2 = "95% CI" D2 = "Sig." E2 = "N" ///
	F2 = "Mean" G2 = "95% CI" H2 = "Sig." I2 = "N" /// Table Column Headings
	J2 = "Mean" K2 = "95% CI" L2 = "Sig." M2 = "N" ///
	B1 = "Combined" F1 = "NAL" J1 = "HR1/SA2", ///
	overwritefmt font("Gill Sans MT" , 10 , black) bold

local row = 2
foreach outcome of varlist `varlist'{ // loop through outcome list

local lab: variable label `outcome' //heading for variable
putexcel A`row' = "`lab'" , overwritefmt font("Gill Sans MT" , 10 , black) bold
local row = `row' + 1

capture svy, : mean `outcome' if inlist(FTFZONE , 2 , 3) //Combined survey area - all households
	local mean = "^" // default values for variables with no observations
	global ci = "^"
	global stars = "^"
	local N = "0"
	if _rc==0{		// if there are observations, then:
		matrix b = e(b)
		matrix df = e(df_r)
		matrix V = e(V)
		matrix N = e(N)
		local mean : di %9.`2'f b[1,1] //sample-weighted mean
		local l : di %9.`2'f (b[1,1] - (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate lower
		local u : di %9.`2'f (b[1,1] + (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate upper
		local l = trim("`l'") //trim leading spaces
		local u = trim("`u'")
		global ci = "[`l' - `u']" // confidence interval
		local N : di %9.0f N[1,1] //N
			if `N' < 30{ //Don't report if fewer than 30 observations
				local mean = "^"
				global ci = "^"
			}
	}
	putexcel A`row' = "All Households" B`row' = "`mean'" C`row' = "$ci" ///
		D`row' = "" E`row' = "`N'" , overwritefmt ///
		font("Gill Sans MT" , 10 , black)
		
capture svy, : mean `outcome' if inlist(FTFZONE , 3) //NAL - all households
	local mean = "^"
	global ci = "^"
	global stars = "^"
	local N = "0"
	if _rc==0{		
		matrix b = e(b)
		matrix df = e(df_r)
		matrix V = e(V)
		matrix N = e(N)
		local mean : di %9.`2'f b[1,1] //sample-weighted mean
		local l : di %9.`2'f (b[1,1] - (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate lower
		local u : di %9.`2'f (b[1,1] + (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate upper
		local l = trim("`l'") //trim leading spaces
		local u = trim("`u'")
		global ci = "[`l' - `u']"
		local N : di %9.0f N[1,1] //N
			if `N' < 30{ //Don't report if fewer than 30 observations
				local mean = "^"
				global ci = "^"
			}
	}
	putexcel F`row' = "`mean'" G`row' = "$ci" ///
		H`row' = "" I`row' = "`N'" , overwritefmt ///
		font("Gill Sans MT" , 10 , black)
		
capture svy, : mean `outcome' if inlist(FTFZONE , 2) // HR1/SA2 - all households
	local mean = "^"
	global ci = "^"
	global stars = "^"
	local N = "0"
	if _rc==0{		
		matrix b = e(b)
		matrix df = e(df_r)
		matrix V = e(V)
		matrix N = e(N)
		local mean : di %9.`2'f b[1,1] //sample-weighted mean
		local l : di %9.`2'f (b[1,1] - (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate lower
		local u : di %9.`2'f (b[1,1] + (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate upper
		local l = trim("`l'") //trim leading spaces
		local u = trim("`u'")
		global ci = "[`l' - `u']"
		local N : di %9.0f N[1,1] //N
			if `N' < 30{ //Don't report if fewer than 30 observations
				local mean = "^"
				global ci = "^"
			}
	}
	putexcel J`row' = "`mean'" K`row' = "$ci" ///
		L`row' = "" M`row' = "`N'" , overwritefmt ///
		font("Gill Sans MT" , 10 , black)		
	
local row = `row' + 1

	foreach subgroup of varlist "`disaggregates'"{ //sample-weighted means for sub-groups
	
	local lab: variable label `subgroup' //heading for sub-group name
	putexcel A`row' = "`lab'" , overwritefmt font("Gill Sans MT" , 10 , black) bold
	local row = `row' + 1
	
	levelsof `subgroup' , local(groups)
	foreach group in `groups'{ //for each sub-group
		
		loc vallab: val label `subgroup' //store heading for sub-group category
		local lab : label `vallab' `group'
		
	*sub-group - combined survey area		
		capture svy, : mean `outcome' if inlist(FTFZONE , 2 , 3) & `subgroup' == `group'
			local mean = "^"
			global ci = "^"
			global stars = "^"
			local N = "0"
			
		if _rc==0{		
			matrix b = e(b)
			matrix df = e(df_r)
			matrix V = e(V)
			matrix N = e(N)
			local mean : di %9.`2'f b[1,1] //sample-weighted mean, all households
			local l : di %9.`2'f (b[1,1] - (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate lower
			local u : di %9.`2'f (b[1,1] + (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate upper
			local l = trim("`l'") //trim leading spaces
			local u = trim("`u'")
			global ci = "[`l' - `u']"			
			local N : di %9.0f N[1,1] //N, all households			
		
			svy: reg `outcome' `group'.`subgroup' if inlist(FTFZONE , 2 , 3)
			starmaker `group'.`subgroup'
				if `N' < 30{ //Don't report if fewer than 30 observations
					local mean = "^"
					global ci = "^"
					global stars = "^"
				}	
		}
		
		putexcel A`row' = "`lab'" B`row' = "`mean'" C`row' = "$ci" ///
			D`row' = "$stars" E`row' = "`N'" , ///
			overwritefmt font("Gill Sans MT" , 10 , black)
			
		*sub-group - NAL	
		capture svy, : mean `outcome' if inlist(FTFZONE , 3) & `subgroup' == `group' 
			local mean = "^"
			global ci = "^"
			global stars = "^"
			local N = "0"
			
		if _rc==0{		
			matrix b = e(b)
			matrix df = e(df_r)
			matrix V = e(V)
			matrix N = e(N)
			local mean : di %9.`2'f b[1,1] //sample-weighted mean
			local l : di %9.`2'f (b[1,1] - (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate lower
			local u : di %9.`2'f (b[1,1] + (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate upper
			local l = trim("`l'") //trim leading spaces
			local u = trim("`u'")
			global ci = "[`l' - `u']"			
			local N : di %9.0f N[1,1] //N			
			
			svy: reg `outcome' `group'.`subgroup' if inlist(FTFZONE , 3)
			starmaker `group'.`subgroup'
				if `N' < 30{ //Don't report if fewer than 30 observations
					local mean = "^"
					global ci = "^"
					global stars = "^"
				}				
		}
		
		putexcel F`row' = "`mean'" G`row' = "$ci" H`row' = "$stars" ///
			I`row' = "`N'" , overwritefmt font("Gill Sans MT" , 10 , black)			
			
		
		*sub-group - HR1/SA2
		capture svy, : mean `outcome' if inlist(FTFZONE , 2) & `subgroup' == `group' //sub-group - HR1/SA2
			local mean = "^"
			global ci = "^"
			global stars = "^"
			local N = "0"
			
		if _rc==0{		
			matrix b = e(b)
			matrix df = e(df_r)
			matrix V = e(V)
			matrix N = e(N)
			local mean : di %9.`2'f b[1,1] //sample-weighted mean
			local l : di %9.`2'f (b[1,1] - (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate lower
			local u : di %9.`2'f (b[1,1] + (invttail(df[1,1],.025) * sqrt(V[1,1]))) //calculate upper
			local l = trim("`l'") //trim leading spaces
			local u = trim("`u'")
			global ci = "[`l' - `u']"			
			local N : di %9.0f N[1,1] //N			
			
			svy: reg `outcome' `group'.`subgroup' if inlist(FTFZONE , 2)
			starmaker `group'.`subgroup'
				if `N' < 30{ //Don't report if fewer than 30 observations
					local mean = "^"
					global ci = "^"
					global stars = "^"
				}				
		}
		
		putexcel J`row' = "`mean'" K`row' = "$ci" L`row' = "$stars" ///
			M`row' = "`N'" , overwritefmt font("Gill Sans MT" , 10 , black)		
		
		local row = `row' + 1
		}
	}

}
end
