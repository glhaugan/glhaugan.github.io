# Beheading a Hydra: Kingpin Extradition, Homicides, Education Outcomes, and the End of Medellin’s Pax Mafiosa
#### Highlighted Skills: Causal inference, quantitative research, R, GIS and geospatial analysis

What happens when the leadership is severed from a highly consolidated, violent mafia organization? If it increases violence, are the consequences confined to gang-affiliated individuals, or are there costs for society as a whole?

### Context
In 2008, a major narcotics kingpin named Don Berna was extradited from Colombia to the United States. In his stronghold of Medellin, the resulting power vacuum in the
city’s criminal economy set off an internecine war for power that saw homicide rates in the city double, before organized crime governance structures finally re-consolidated and violence returned to pre-extradition levels.

![HomicidesPer](/assets/img/HomicidesPer.png)


### My Work
I identified the areas of the city controlled by Don Berna and studied the evolution of homicides before and after the extradition in the areas under his control and in those not under his control. I compared the monthly trends in homicides for Berna-controlled areas to other other areas. As you can see, the trends run parallel right up until the extradition, at which point homicides spike much more in the Berna-controlled areas.

![BernaTrend](/assets/img/BernaTrend.png)

I was curious how this increased students' exposure to violence and whether increased exposure to violence impacted education outcomes. To do this, I mapped homicides and schools, and wrote a program to count the annual number of homicides within 250 meters of each public school in the city. The map below shows homicides and schools for 2007 and 2010, and you can verify that homicide counts are correct by clicking on any school and checking against the homicides within its 250m buffer.

<iframe src="/assets/img/MedellinMap.html" height="600px" width="100%" style="border:none;"></iframe>

I then used quasi-experimental difference-in-differences and instrumental variables strategies to estimate the effect of the extradition on exposure to violence, test scores, dropout, and teacher turnover.
  
### Result
My findings suggest that Don Berna’s extradition caused an average of 1.2 more homicides within 250 meters of a school each year during the years immediately following the extradition. The results also show that each additional homicide within 250 meters of a school led to a 1.1 percent decline in math test scores, equivalent to 0.05 standard deviations.

You can find the full paper [here](https://dx.doi.org/10.2139/ssrn.4880218). I presented results at the 2023 Meeting of the Latin American and Caribbean Economic Association. A [research brief](https://www.cato.org/research-briefs-economic-policy/beheading-hydra-kingpin-extradition-homicides-education-outcomes) was published by the Cato Institute and the paper is currently under peer review at _Journal of Development Economics_.

### Code
Please see the [repository](https://github.com/glhaugan/Beheading-a-Hydra) for my code for this project. Due to the sensitive nature of the student- and teacher-level data, I am not able to make all of my data publicly available, but I have put together a school-level dataset and R script to demonstrate some of my R skills. I originally programmed this work in Stata, and my Stata do-files are also found in the repository.

