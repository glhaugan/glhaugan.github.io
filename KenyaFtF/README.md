# Kenya Feed the Future Survey
#### Highlighted Skills: Sampling design, problem solving, Stata

Leading a household survey in rural Kenya to understand agricultural productivity, food security, materal health, and child nutrition.

### Context
Feed the Future (FtF) is a multi-country initiative from the United States government to advance agricultural development, increase food production, and improve nutrition. Progress in each country is measured by statistics collected in household surveys. 

I served as the Lead Statistician on a team for a FtF survey of 6,000 households in Kenya. I led sampling design and oversaw data quality, analysis, and reporting.

### Problem
During the proposal phase for this project, my team had estimated labor requirements for analysis and reporting based on an FtF report template that existed at that time, which was around 75 pages long and included approximately 25 tables. Once we began our work however, we realized the client was in the process of developing a new template and that they would actually expect two final reports, and each report would be around 400 pages and include approximately 100 tables. 

The problem was further complicated by the fact that the tables were quite complex and there was no immediately obvious way to auto-populate them. It looked like they would have to be populated manually and each cell of each table would need to be calculated line-by-line in the statistical code, which would require around two hours per table (or around 400 total hours) and likely result in many errors during manual population.

My team huddled to discuss how we should approach this - should we push back on such an enormous increase in our scope of work from what we had expected, and which there had been no way of anticipating at the time we signed the contract? 

### My Work
I studied the tables and began noticing patterns. While they were complicated and there was no existing program to automate their production, I began to see the how such a program could be written.

I wrote a program called ftftable in Stata to handle all of the analysis and table production. Rather than calculating each cell of each table in Stata line by line and manually populating each cell individually, my program allowed our analysts to handle each table in a single line of code, which performed all the analysis for each table and produced a fully formatted table that could simply be copied and pasted into the report.

### Result
With my program, each table only took about five minutes to calculate and copy into the report, reulting in time savings of over 95%. The deliverable was now manageable within the original budget. 
