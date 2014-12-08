In 2014 ([Jan-June](https://www.gov.uk/government/publications/police-use-of-taser-statistics-england-and-wales-january-to-june-2014/police-use-of-taser-statistics-england-and-wales-january-to-june-2014)), "just" 20% of taser use by UK police officers involved tasers being fired - breakdown figure [here](https://assets.digital.cabinet-office.gov.uk/government/uploads/system/uploads/image_data/file/31544/police-taser-janjun1-2014.png). [`Figure 1`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Figure%201%20-%20Pie%20chart%20on%20how%20taser%20was%20used.png)

> The figures in this report show the number of times taser was used as opposed to the number of taser ‘incidents’. This is designed to ensure full transparency on taser deployment, as more than one taser may be used at an incident.

![](https://assets.digital.cabinet-office.gov.uk/government/uploads/system/uploads/image_data/file/31544/police-taser-janjun1-2014.png)

Home Office statistics show a rise in police use of tasers, with the [figure online](https://assets.digital.cabinet-office.gov.uk/government/uploads/system/uploads/image_data/file/31545/police-taser-janjun2-2014.png) aggregating quarterly data to annual. [`Figure 2`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Figure%202%20-%20Yearly%20UK%20figures%20on%20taser%20use.png)

![](https://assets.digital.cabinet-office.gov.uk/government/uploads/system/uploads/image_data/file/31545/police-taser-janjun2-2014.png)

They note the increase **can partly be accounted for by the phased rollout** of tasers from Authorised Firearm Officers to Specially Trained Units across all police forces in England and Wales.

* Inter-region comparisons may not be valid (further details [here](https://www.gov.uk/government/publications/police-use-of-taser-statistics-england-and-wales-january-to-june-2014/police-use-of-taser-statistics-england-and-wales-january-to-june-2014#data-quality-and-use-of-data))
* There are 'ongoing complications' with the Home Office Taser Database, requests for raw data have been denied (links from What Do They Know site begin [here](https://www.whatdotheyknow.com/request/quarterly_statistics_on_taser_us))
* Force policies on taser use will differ
* The Home Office data were apparently analysed for "medical implications". This is excluded from the published reports, and arguably should be as their use increases.

The data on type of usage (red dot, stun, firing being the main categories, each defined [here](https://www.gov.uk/government/publications/police-use-of-taser-statistics-england-and-wales-january-to-june-2014/police-use-of-taser-statistics-england-and-wales-january-to-june-2014#background-and-definitions)) allow some general observations. Using code in the [`Documentation scripts`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Documentation%20scripts.sh) file in [this GitHub repo](https://github.com/lmmx/ONS-taser-stats-vis), I sorted this data into lists [`by totals`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Type%20of%20use%20sorted%20by%20total%20uses.tsv) and [`by firings`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Type%20of%20use%20sorted%20by%20taser%20firings.tsv).

'Red dotted' remained the largest category (generally around half of 'usage'), however this can also be interpreted perhaps as officers using it as a source of intimidation or mode of avoiding confrontation, and given a) the safety concerns around these weapons, and b) their predominant use on those with mental health it's worth thinking critically about, and highlights the need for further usage breakdowns from FOI requests until such a time the Home Office releases their Taser Database statistics.

* The total usage clearly correlates with force size, i.e. "police strength", as is to be expected, see below

Regarding the phased rollout, figures on the year this occurred in for each region of England & Wales are available in the appendix of the [2014 data table](https://www.gov.uk/government/statistics/police-use-of-taser-statistics-england-and-wales-january-to-june-2014) (.ods spreadsheet [here](https://www.gov.uk/government/uploads/system/uploads/attachment_data/file/363771/police-use-of-taser-janjun-2014-tabs.ods)). These figures have been sorted by year provided to officers ([`firearms officers`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Regions%20sorted%20by%20year%20first%20issued%20to%20firearms%20officers.tsv) and [`specially trained units`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Regions%20sorted%20by%20year%20first%20issued%20to%20trained%20units.tsv)).

There's nothing that would suggest these are relevant to interpreting recent figures (Cambridgeshire and Essex issuing tasers to trained units just last year, these areas aren't particularly out of the ordinary in usage stats).

## Police strength

Police workforce statistics are available from the Home Office: table 9 of the March 2014 figures give police officers by area (again England and Wales) from March 2012 - March 2013; table 4 the same figures from March 2013 - March 2014. These tables have total police as well as per 100,000 population, though these may indeed be irrelevant, the pertinent figure being instead the numbers of officers authorised to use, or provided with, tasers. See [`Police workforce regional stats March 2013 - March 2014.tsv`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Police%20workforce%20regional%20stats%20March%202013%20-%20March%202014.tsv) (plain text version to view [`here`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Police%20workforce%20regional%20stats%20March%202013%20-%20March%202014.txt), as made for all these tables, though GitHub allows searching of the tsv tables, and formats them nicely).

Bearing this limitation to the data in mind, total officers per 100,000 population means population sizes can still be obtained for these regions, to scale taser incidents per 100,000 population. The City of London is the only region to have no population-scaled data (its police force is as large as Warwickshire's, unclear why there's no population size given). The region is excluded from analysis (both at 43 territorial- and 10 national region- levels).

* [`Figure 3`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Figure%203%20-%20Taser%20use%20-%20population%20corrected.png) and [`Figure 4`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Figure%204%20-%20Taser%20use%20-%20police%20force%20size%20corrected.png) show population-corrected and police workforce size-corrected stats. Log-scale is used as London's figures dwarf other regions.

![Figure 3](https://raw.githubusercontent.com/lmmx/ONS-taser-stats-vis/master/Figure%203%20-%20Taser%20use%20-%20population%20corrected.png)

![Figure 4](https://raw.githubusercontent.com/lmmx/ONS-taser-stats-vis/master/Figure%204%20-%20Taser%20use%20-%20police%20force%20size%20corrected.png)

## National versions of the same plots and data (10 regions)

* Equivalent analyses for the above territorial regions: [`National taser scaled per 100 police officers`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/National%20tasings%20per%20100%20police%20officers.tsv) and [`National taser use per 100,000 population`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/National%20tasings%20per%20100%2C000%20population.tsv)
* Figures are just scaled to population and police force sizes fixed at most recent year (there are further archived figures on the [Home Office Stats site](https://www.gov.uk/government/collections/police-workforce-england-and-wales#documents), **currently just the 2013-14 figures are used here**, discriminating general regional sizes).
* Further data trickery in R (statistical programming language) produced figures [`5`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Figure%205%20-%20National%20taser%20use%20-%20population%20corrected.png) and [`6`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Figure%206%20-%20National%20taser%20use%20-%20police%20force%20size%20corrected.png), the same figures for national regions.

![Figure 5](https://raw.githubusercontent.com/lmmx/ONS-taser-stats-vis/master/Figure%205%20-%20National%20taser%20use%20-%20population%20corrected.png)

![Figure 6](https://raw.githubusercontent.com/lmmx/ONS-taser-stats-vis/master/Figure%206%20-%20National%20taser%20use%20-%20police%20force%20size%20corrected.png)

## Notes

* An error with plotting library [`ggplot2`](http://ggplot2.org/) prevented the lines in the local police force graph being smoothed, see the [`R rescaling and visualisation documentation file`](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Data%20rescaling%20and%20visualisation%20documentation.R) (specifically [these lines](https://github.com/lmmx/ONS-taser-stats-vis/blob/master/Data%20rescaling%20and%20visualisation%20documentation.R#L58-L59)). The national-regional data is visually more informative anyway - 43 data layers is too many for the viewer to understand.
* These graphs are very easy to customise now they're produced, it's just a matter of tweaking graphical parameters. [Play around with examples here](http://shinyapps.stat.ubc.ca/r-graph-catalog/) and find more galleries of ggplot graphs [here](http://stats.stackexchange.com/questions/78844/a-gallery-of-charts-diagrams-and-plot-types)
* The graph can be made interactive if uploaded to a [Shiny server](http://shinyapps.io), but I've never done this before. 
* Questions, contact: Louis, or naivelocus at gmail dot com
