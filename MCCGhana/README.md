# Millenium Challenge Corporation Ghana Power Compact Surveys
Leading a survey of businesses in Accra, Ghana to understand their electricity consumption and how the country's electric grid strangles economic growth.

### Context
Costs in Ghana's power sector utilities run higher than their revenue, making it difficult for them to maintain and improve their infrastructure and resulting in an unreliable power grid that is an impediment to economic growth. The $498 million Ghana Power Compact aims to improve the quality and reliability of power distribution systems and improve access to legal connections for micro, small, and medium-sized businesses.

### My Work

- Step 1. Use business census to count enterprises per locality
- Step 2. Link locality-level enterprise counts to shapefiles and map the localities.
<iframe src="/assets/img/map1_gss_data.html" height="600px" width="100%" style="border:none;"></iframe>
- Step 3. Map the localities on top of Open Street Maps major roads, and use the roads to segment the localities.
![sementlocalities](/assets/img/sementlocalities.png)
- Step 4. Step 4. Use nighttime light intensity raster data to estimate the distribution of enterprises within the locality, and obtain an estimate of the number of enterprises per EA.

### Result
The process yielded a viable sample frame, with sampling weights assigned to each census block that we were able to use for sampling. You can see the full sampling frame in the map below. Clicking on a block will tell you more about it, including the number of estimated businesses. The GridWatch points on the map are grid monitoring stations that were used to stratify the sample.
<iframe src="/assets/img/E EA Map.html" height="600px" width="100%" style="border:none;"></iframe>

Field teams visited each of the blocks and listed all businesses. As the graph below shows, the process for estimating the number of businesses did an excellent job of predicting the actual number that were found by the field teams.
![predictedbusinesses](/assets/img/predictedbusinesses.png)
