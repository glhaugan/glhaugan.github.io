# Millenium Challenge Corporation Ghana Power Compact Surveys
Leading a survey of businesses in Accra, Ghana to understand their electricity consumption and how the country's electric grid strangles economic growth.

### Context
Costs in Ghana's power sector utilities run higher than their revenue, making it difficult for them to maintain and improve their infrastructure and resulting in an unreliable power grid that is an impediment to economic growth. The $498 million Ghana Power Compact aims to improve the quality and reliability of power distribution systems and improve access to legal connections for micro, small, and medium-sized businesses.

### My Work
I served as the Lead Statistician on a team for a survey of businesses in Accra, aiming to understand their electricity consumption. I led sampling design for a multistage, clustered random sample of businesses, where we would first randomly sample enumeration areas (EAs), then send a field team to list all of the businesses in each sampled EA, and finally randomly select businesses from each EA.

Almost as soon as I got started, I encountered a major problem: I was able to obtain an (outdated) census of businesses in Accra, which included the locality of the city where they were located. But it did not contain their specific address or the EA or census block where they were located. Any information about the census blocks for this business census had been lost to time - I would have to create the enumeration areas from scratch!

To do this, I developed and executed the following plan:
- **Step 1.** Using the business census, I counted the number of businesses in each locality.

- **Step 2.** I linked the locality-level business counts to shapefiles and mapped the localities. Below you can see this map, and clicking on any of the localities will show you information about the locality, including the number of businesses.
<iframe src="/assets/img/map1_gss_data.html" height="600px" width="100%" style="border:none;"></iframe>

- **Step 3.** The localities were much too big to use as the primary sampling unit. Sending a field team to list every business in a locality would have been very difficult (and expensive!). So I mapped the localities on top of Open Street Maps major roads, and used the roads to segment the localities with the [`mapedit`](https://github.com/r-spatial/mapedit) package in R. You can see in the map below how this was done.
![sementlocalities](/assets/img/sementlocalities.png)

- **Step 4.** Now that the localities had been segmented into more managable EAs, there was a new problem: I knew how many businesses were in each locality, but not how many were in each of the newly created EAs. I would need an EA-level count in order to generate sampling weights. To resolve this, I assumed that the number of businesses in an area would be correlated with nighttime light intensity, and I used nighttime light intensity raster data to estimate the distribution of enterprises within each locality, and obtain an estimate of the number of enterprises per EA. I did this with the [`raster`](https://rspatial.org/raster/pkg/index.html) package in R.

### Result
The process yielded a viable sample frame, with sampling weights assigned to each census block that we were able to use for sampling. You can see the full sampling frame in the map below. Clicking on a block will tell you more about it, including the number of estimated businesses. The GridWatch points on the map are grid monitoring stations that were used to stratify the sample. The areas in red are localities where there were no businesses in the census.
<iframe src="/assets/img/E EA Map.html" height="600px" width="100%" style="border:none;"></iframe>

I sampled EAs and sent field teams to visit each of the sampled EAs and list all businesses. As the graph below shows, the process for estimating the number of businesses did an excellent job of predicting the actual number that were found by the field teams.
![predictedbusinesses](/assets/img/predictedbusinesses.png)
