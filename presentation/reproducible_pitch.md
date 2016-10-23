<style>
.small-code pre code {
  font-size: 1em;
}
</style>

Developing Data Products Final Project - US Drone Strikes
========================================================
author: David Waterman
date: 10/23/2016
autosize: true

US Drone Strikes
========================================================
This webapp downloads data in real time from [The Bureau of Investigative Journalism](https://www.thebureauinvestigates.com/category/projects/drones/drones-graphs/) and displays the data on casualties as a time plot.
The following options are available:


- Country to display
    - Pakistan, Yemen, Somalia, Afghanistan, or All countries combined


- Casualty type to display
    - All People, Civilians, Children, or Combined graph with overlayed plots for all three types

Accessing the App
========================================================
The app is available on the shinyapps.io site, https://drwaterman.shinyapps.io/US_Drone_Strikes/

Example of App Running
========================================================

![screenshot](screenshot.png)


Source Code
========================================================
class:small-code
The source code for the project and all associated files is available at  http://github.com/drwaterman/USDroneStrikes

Sample data processing code:
<font size="8">

```r
library(googlesheets)
pak_url <- "https://docs.google.com/spreadsheets/d/1NAfjFonM-Tn7fziqiv33HlGt09wgLZDSCP-BQaux51w/edit?usp=sharing"
pak_sheet <- gs_url(pak_url)
pak_data <- gs_read(pak_sheet, ws="Drone strikes data")
sample_data <- pak_data[1:3,c(2,5:6)]
sample_data
```

```
# A tibble: 3 × 3
        Date `Minimum total people killed` `Maximum total people killed`
       <chr>                         <int>                         <int>
1 17/06/2004                             6                             8
2 08/05/2005                             2                             2
3 05/11/2005                             8                             8
```
</font>
