#### Source Code for Data Publishing ####

# Create Template .txt files for EMLassembly ----------

# read in metadata info and import additional templates
# write info data frames to text files for EML assembly

xlsx_to_template <- function(metadata.path, edi.filename, rights, bbox = FALSE, other.info = FALSE) {
  # define the file type for the metadata
  metadata_xlsx <- paste0(metadata.path, ".xlsx")
  
  if ("ColumnHeaders" %in% excel_sheets(path = metadata_xlsx)) {
    headers <- read_excel(path = metadata_xlsx, 
                          sheet = "ColumnHeaders", na = "NA")
    write.table(headers, paste0("attributes_", edi.filename, ".txt"), 
                quote = FALSE, na = "", sep = "\t", row.names = FALSE)
  }
  if ("Personnel" %in% excel_sheets(path = metadata_xlsx)) {
    personnel <- read_excel(path = metadata_xlsx, 
                            sheet = "Personnel", na = "NA")
    write.table(personnel,"personnel.txt", 
            quote = FALSE, na = "", sep = "\t", row.names = FALSE)
  }
  if ("Keywords" %in% excel_sheets(path = metadata_xlsx)) {
    keywords <- read_excel(path = metadata_xlsx, 
                          sheet = "Keywords", na = "NA")
    write.table(keywords,"keywords.txt", 
                quote = FALSE, na = "", sep = "\t", row.names = FALSE)
  }
  if ("CategoricalVariables" %in% excel_sheets(path = metadata_xlsx)) {
    catvars <- read_excel(path = metadata_xlsx, 
                          sheet = "CategoricalVariables", na = "NA")
    write.table(catvars, paste0("catvars_", edi.filename, ".txt"), 
                quote = FALSE, na = "", sep = "\t", row.names = FALSE)
  }
  if ("CustomUnits" %in% excel_sheets(path = metadata_xlsx)) {
    custom_units <- read_excel(path = metadata_xlsx,
                               sheet = "CustomUnits", na = "NA")
    write.table(custom_units,"custom_units.txt", 
                quote = FALSE, na = "", sep = "\t", row.names = FALSE)
  }
  # Import abstract and methods
  template_core_metadata(path = getwd(), license = rights)
  # this will not overwrite existing files

  # if theres is no additional information (default), eliminate the template
  if(isFALSE(other.info)) {
    unlink("additional_info.txt")
  }
}

## Example use:
# define path to excel file containing metadata
# growgraze_info <- "NES-LTER_Growth-Grazing_SMD_2019_11_01"
# define output filename (must be the same as the final csv)
# growgraze_file <- "nes-lter-growth-grazing-chl"
# run function
# xlsx_to_template(metadata.path = growgraze_info, edi.filename = growgraze_file, rights = "CCBY")

# Construct EML ----------

# date, lat, and lon columns must be identified as input for this function
# Compiles a list of geographic and temporal coverage
data_coverage <- function(dates, lat, lon) {
  # Temporal coverage 
  # Will need this in make_eml YYYY-MM-DD
  startdate <- min(dates, na.rm = TRUE)
  enddate <- max(dates, na.rm = TRUE)
  # temporal.coverage argument is expecting objects of 'character' class, not 'Date'
  startdate_as_character <- as.character(startdate)
  enddate_as_character <- as.character(enddate)

  # Geographic coverage
  # Will need this order in make_eml: North, East, South, West
  North <- round(max(lat, na.rm = TRUE), 5)
  East <- round(max(lon, na.rm = TRUE), 5)
  South <- round(min(lat, na.rm = TRUE), 5)
  West <- round(min(lon, na.rm = TRUE), 5)
  
  my_list <- list("startdate" = startdate_as_character, "enddate" = enddate_as_character,
                  "North" = North, "East" = East, "South" = South, "West" = West)
  return(my_list) 
}

# Example code: 
# define date and geospatial columns for input
# date_col <- as.Date(growgraze_EDI$date_time_UTC)
# lat_col <- growgraze_EDI$latitude
# lon_col <- growgraze_EDI$longitude
# run function
# coverage <- data_coverage(dates = date_col, lat = lat_col, lon = lon_col)

# Insert Custom Project Node ------------

# Function inserts project node after the methods node of an xml document
# requires the existance of a parent_project.txt
# input path to xml file

project_insert <- function(edi_pkg) {
  if (!file.exists("parent_project.txt")) {
    stop("parent_project.txt does not exist")
  }
  # read in parent project and xml file to be modified
  newnode <- read_xml("parent_project.txt", from = "xml")
  xml_file <- read_xml(paste0(getwd(), "/", edi_pkg, ".xml"), from = "xml")

  # replace existant project node
  if (is.na(xml_find_first(xml_file, ".//project")) == FALSE) {
      # find old project node
      oldnode <- xml_find_first(xml_file, ".//project") # find project node
      # replace with new project node
      xml_replace(oldnode, newnode)
    warning("<project> node already existed but was overwritten")
  }
  # insert new project node
  if (is.na(xml_find_first(xml_file, ".//project")) == TRUE) {
    # find methods node
    methodsnode <- xml_find_first(xml_file, ".//methods")
    # add project node after methods and before dataTable
    xml_add_sibling(methodsnode, newnode, where = "after")
  }
  # validate script
  if (eml_validate(xml_file) == FALSE) {
    warning("XML document not valid")
  }
  # return(xml_file)
  write_xml(xml_file, paste0(getwd(), "/", edi_pkg, ".xml"))
}

## Example use: 

# read in xml files exported by make_eml
# growgraze_pkg <- "knb-lter-nes.5.1"
# all objects should be of class c("xml_document" "xml_node")
# run function
# project_insert(edi_pkg = growgraze_pkg)

# Quality Assurance: Mapping Sample Locations ----------

map_locs <- function(x, longitude, latitude, region) {
  if (region == "transect") {
    nes_region <- map_data("state") %>% filter(long > -72 & lat < 42)
  }
  if (region == "shelf") {
    nes_region <- map_data("state") %>% filter(long > -77)
  }
  # Map given coordinates
  ggplot() +
    geom_polygon(data = nes_region, mapping = aes(x = long, y = lat, group = group),
                 fill = NA, color = "grey50") +
    geom_point(x, mapping = aes(x = longitude, y = latitude, color = cruise),
               size = 1) + 
    coord_fixed(1.3) +
    theme_classic()
}

# Example code
# map_locs(x = growgraze_EDI, longitude, latitude, region = "transect")



