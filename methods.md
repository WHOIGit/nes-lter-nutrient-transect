Three projects, NES-LTER, Ocean Observatories Initiative (OOI), and MIT-WHOI Joint Program (JP), provide dissolved inorganic nutrient data from CTD rosette bottle and bucket sampling on NES-LTER Transect cruises. Methods are the same across the three projects.

From 2017 through 2022, spring and fall sample collection typically occurred on cruises funded and operated by the Ocean Observatories Initiative (OOI). These cruises are identified with the project_id OOI, and they include data collected for both the NES-LTER and OOI projects. Please note that OOI data are included here as a convenience to researchers wishing to use the data from both projects, and that the authoritative source for OOI data is the Raw Data Archive for Cruise Data from the Coastal Pioneer NES Array (https://rawdata.oceanobservatories.org/files/cruise_data/Pioneer-NES/).

MIT-WHOI Joint Program (JP) cruises (AR22, AR32, and AR38) are funded by WHOI Academic Programs Office.

# CTD Rosette Bottle and Bucket Sampling on NES-LTER cruises

Samples were collected from the water column at multiple depths using Niskin bottles on a CTD rosette system. Some samples were collected at the surface with a bucket.

# Nutrient Filtering Protocol

Prior to 2018, and for bucket samples: Wearing nitrile gloves, collect water from the Niskin or bucket with a clean bottle that is rinsed 3 times with the sample water. Rinse the full length of a 60 ml syringe with a small volume of sample water 3 times.
Completely fill syringe with sample water and force 60 ml through a EMD Millipore sterile Sterivex 0.22 um filter. Then refill the syringe.

2018 to present: Wearing nitrile gloves, connect AcroPak 200 Capsule with Super Membrane 0.2 um filter with barb and tubing to Niskin spigot and fill with water. Rinse filter with 3 times the volume of the filter. Then refill the filter.

All samples: Then, without touching filter to sample vial (acid-washed 20-ml scintillation vial), rinse sample vial with 5 ml of filtered water 3 times. For each rinse, replace the cap and shake vigorously. Filter 17 ml of sample directly into the sample vial and replace the cap and proceed to the next sample. Store samples in a -20 deg C freezer and keep frozen until analysis. If applicable, flush AcroPak filter with Milli-Q water and refrigerate for use on next cast (AcroPak filter may process up to 20 liters).

Note regarding ammonium: Due to the method of samples being filtered and frozen before analysis, ammonium data are subject to various potential artifacts. Ammonium samples are best analyzed immediately without freezing, but this is not feasible on NES cruises.

# WHOI Nutrient Facility Nutrient Analysis

Samples are stored at -20 degrees C until submitted to the Woods Hole Oceanographic Institution's Nutrient Analytical Facility
(https://web.whoi.edu/nutrient/) which operates a four-channel segmented flow SEAL AA3 HR Autoanalyzer. Duplicates and spiked additions are run for quality control. Standards are made daily and Certified Reference material is run daily to ensure the standards and/or reagents are good. If the samples fall outside of the duplicate or spike addition quality
control they are rerun until they fall within quality control parameters. Precision is 0.001 micromoles per liter. Please refer to the Facility's website for current detection limits which are different depending on the nutrient.

# Nutrient Data Cleaning

The data table is made by concatenating cruises called from the REST API of the NES-LTER data system. All Below Detection Limit values are set to zero. Nearest station is calculated based on the station location on the date of sample collection. Nearest\_station and station\_distance are provided wherever the distance between the station and the ship at the time of the sample is within 2 kilometers. Station locations have been consistent over the course of the project with the following exceptions: Station L5 was shifted 1 nautical mile due south during the first year of the project, in July 2018 for cruise EN617, and has remained there since. Stations L7, L8, and L9 were shifted at the start of 2023 (after the removal of the OOI Pioneer Array), moving L8 west to the main line and evenly spacing L7 and L9 along the main line.  Visit https://nes-lter.whoi.edu/about/#where for a table of all past and present station locations. 

Data assembly, cleaning, and metadata template assembly are performed in R Markdown. Additional nutrients data for Ocean Observatories Initiative (OOI) cruises on R/V Neil Armstrong are available from the OOI Alfresco document server (Coastal Pioneer NES Array \> Cruise Data \> select a cruise \> Ship Data \> Water Sampling). Further documentation can be found on GitHub, at
https://github.com/WHOIGit/nes-lter-nutrient-transect.

# Quality Assurance

We assured that the geographic and temporal coverage of the clean data table are within expected ranges. No values changed as compared to the previous version of this data package. For each nutrient we checked differences between replicates, visually inspected plotted values, and performed a range check.

For published version 3, preliminary quality flags were assigned to the data. Automation was used to check each nutrient for differences between replicates. Quality is indicated in the data table with IODE Primary Level flags: 1 good; 2 not evaluated, not available or unknown; 3 questionable/suspect; 4 bad; 9 missing data. [See IODE Ocean Data Standards recommendation here: https://www.iode.org/index.php?option=com_oe&task=viewDocumentRecord&docID=10762] Thresholds for flag 3 and 4 were set for each nutrient type, and if poor replication was above a threshold, both replicates received the same flag of 3 or 4. It is possible one replicate is good, and future versions of the package will include manual checking to assess the automated flagging and apply appropriate flagging quality control. Due to the preliminary nature of the current flagging scheme, no data have been removed from the data set at this time. Future manually checked versions of flagging will possibly replace values with NA. 

# Differences from Previous Version

In version 3, in addition to the flagging changes described above, 2,650 rows have been added. These include data from 28 additional OOI and NES-LTER cruises as well as OOI samples from cruises that previously included only LTER samples. Depth in all rows has been rounded to one decimal place. The column order was updated. 

# Related Data Sets

Additional discrete nutrient data from NES-LTER cruises EN608, EN627, and EN644:
Jenkins, B. D., Bertin, M. (2021) Pseudo-nitzschia spp. cell counts, nutrients water temperature and salinity, and concentrations of the toxin domoic acid from weekly samples and offshore cruises with the Northeast U.S. Shelf (NES) Long-Term Ecological Research (LTER). Biological and Chemical Oceanography Data Management Office (BCO-DMO). (Version 1) Version Date 2021-04-05. doi:10.26008/1912/bco-dmo.847448.1 [2024-07-24]

Additional discrete nutrient data from cross-shelf transects in April 2018, May 2019, and July 2019 from Shelfbreak Productivity Interdisciplinary Research Operation at the Pioneer Array (SPIROPA) project. 
https://www.bco-dmo.org/project/748894

Additional discrete nutrient data from the Martha's Vineyard Coastal Observatory:
Sosik, H.M., E. Crockford, and E. Peacock. 2022. Dissolved inorganic nutrients from the Martha's Vineyard Coastal Observatory (MVCO), including 4 macro-nutrients from water column bottle samples, ongoing since 2003 (NES-LTER since 2017) ver 3. Environmental Data Initiative. https://doi.org/10.6073/pasta/ca34be7554ddc67c9fa0f8dea01f375b (Accessed 2024-07-24).
