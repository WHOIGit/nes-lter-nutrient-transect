## Creating a Data Package for NES-LTER Nutrient Transect Cruise Data

This repository displays the workflow used to process the NES-LTER nutrient transect cruise data in preparation for publication to the Environmental Data Initiative repository. This data collection is ongoing since 2017.

This workflow includes the following:
1) compiles cruise data from the [REST API](https://github.com/WHOIGit/nes-lter-ims/wiki/Using-REST-API) and supplies useful fields for the end user
2) cleans the provided data
3) performs quality assurance on the data
4) assembles and outputs the final XML file for submission to EDI

**Base Requirements:**
- Microsoft Excel
- R and R studio (*packages:* tidyverse, readxl, lubridate, devtools, EMLassemblyline, EML, maps, xml2)

### Collaborators:
Heidi Sosik (creator), Taylor Crockford (technician), Joe Futrelle (developer), Stace Beaulieu (associate; co-PI for the NES-LTER project), Jaxine Wolfe (associate; metadata provider)

### Package Status:
The first version of this data package is published to the EDI repository and can be found [here](https://doi.org/10.6073/pasta/ef03b9f0d7acf5a6ac532eff09f448fd).
