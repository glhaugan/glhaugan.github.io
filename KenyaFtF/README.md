# Kenya Feed the Future Survey
#### Highlighted Skills: Sampling design, problem solving, R

Leading a household survey in rural Kenya to understand agricultural productivity, food security, materal health, and child nutrition, and finding solutions for drastically reducing the effort required for reporting the results.

### Context
Feed the Future (FtF) is a multi-country initiative from the United States government to advance agricultural development, increase food production, and improve nutrition. Progress in each country is measured by statistics collected in household surveys. 

I served as the Lead Statistician on a team for a FtF survey of 6,000 households in Kenya. I led sampling design and oversaw data quality, analysis, and reporting.

### Problem
FtF provides templates for reports and statistical programming for calculating results. During the proposal phase for this project, my team had estimated labor requirements for analysis and reporting based on an FtF report template that existed at that time, which was around 75 pages long and included approximately 25 tables. Once we began our work however, we realized the client was in the process of developing a new template and that they would actually expect two final reports, and each report would be around 400 pages and include approximately 100 tables. 

The tables were also quite complex and there was no immediately obvious way to auto-populate them. From FtF's statistical code template, it was clear they expected the tables to be populated manually and each cell of each table would need to be calculated line-by-line, requiring around two hours per table (or around 400 total hours) and likely result in many errors during manual population. They expected custom features like surpressing results where there were fewer than 30 observations - again, very difficult if you're doing this by hand across 200 tables with so many rows and columns. You can see below an example of what these tables looked like.

My team huddled to discuss how we should approach this - should we push back on such an enormous increase in our scope of work from what we had expected, and which there had been no way of anticipating at the time we signed the contract? 

![KenyaTables](/assets/img/KenyaTables.png)


### My Work
I studied the tables and began noticing patterns. While they were complicated and there was no existing program to automate their production, I began to see the how such a program could be written.

I wrote a program called **ftftable** in Stata (and later in R) to handle all of the analysis and table production. Rather than calculating each cell of each table in Stata line by line and manually populating each cell individually, my program allowed our analysts to handle each table in a single line of code, which performed all the analysis for each table and produced a fully formatted table that could simply be copied and pasted into the report. The analyst would just need to write something like the following for each table:

```bash
ftftable(data, oucome = "outcome", disaggregates = c("Age", "Education" , 
              "PregnancyStatus" , "GenderedHouseholdType" , "PovertyStatus" , 
              "WealthQuintile"), col_var = "Region", decimals=3)
```

In other words, they would just need to tell the command what dataset (and survey design) they are using, specify the outcome variable, a list of variables to disaggregate by, optionally specify an additional disaggregate variable for the columns, and the number of decimals to round to.

### Result
With my program, each table only took about five minutes to calculate and copy into the report, resulting in time savings of over 95%, and allowing the team to complete the work within budget. Overall, I estimate this resulted in cost savings equal to around 10% of our labor budget.

Perhaps more importantly, we provided FtF with the program at the end of the project for them to incorporate into their template. These surveys are run in 20 countries, implying potential savings of around 7,500 hours! 

### Code
Please see the [repository](https://github.com/glhaugan/KenyaFtF) for my code for this program. The repository includes both Stata and R versions of the program.
