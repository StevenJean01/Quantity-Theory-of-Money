# Quantity-Theory-of-Money
Stata project on the Quantity Theory of Money

I recently completed a project where I tested my skills in data cleaning, manipulation, and analysis using Stata. The objective was to examine the quantity theory of money, which suggests that an increase in the money supply (m1, m1+, and m2) leads to higher inflation. To conduct the analysis, I obtained datasets on money supply and inflation from the Bank of Canada, which I will share below for others to replicate my findings.

Initially, I couldn't establish a direct link between money supply and inflation. However, upon closer examination of the datasets, I decided to create lagged variables for the money supply. This approach allowed me to observe the impact of increased money supply on inflation approximately 12 months later. By running multiple regressions using these lagged money supply variables and inflation, I obtained highly significant results. The t-scores were statistically significant, and the graph further confirmed that an increase in money supply leads to a corresponding increase in inflation.

I would greatly appreciate any feedback or thoughts you may have regarding this analysis.

**Please click on the Final Project Quantity Theory of Money.do to see the code**

                                          Variable Description
date:	The date variable shows the year month and exact date of the observation in the format (YYYY-MM-DD).
M1:	This Variable gives us the Currency kept outside of banks, personal and non-personal chequable deposits held at chartered banks, all chequable deposits held by trust and mortgage lending companies, credit unions, and caisses populaires (apart from deposits held by these organisations), as well as continuity adjustments.

M1v2:	The M1v2 variable is the M1 variable plus non-chequable notice deposits held at chartered banks plus all non-chequable deposits at trust and mortgage loan companies, credit unions and caisses populaires less interbank non-chequable notice deposits plus continuity adjustments.

M2: 	The M2 variable is the M1v2 plus Canada Savings Bonds and other retail instruments plus cumulative net contributions to mutual funds other than Canadian dollar money market mutual funds.
Inflation:	The Inflation variable is the amount of inflation at that time.

M2_L1:	M2_L1 is the M2 variable but lagged in this case it is lagged by 12 month so it shows as the growth of money but 12 months before the original variable M2.

M1_L1: 	M1_L1 is the M1 variable but lagged in this case it is lagged by 12 month so it shows as the growth of money but 12 months before the original variable M1.

M1v2_L1:	M1v2_L1 is the M1 variable but lagged in this case it is lagged by 12 month so it shows as the growth of money but 12 months before the original variable M1v2.


