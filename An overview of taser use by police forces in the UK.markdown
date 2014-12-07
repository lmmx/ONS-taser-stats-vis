In 2014 ([Jan-June](https://www.gov.uk/government/publications/police-use-of-taser-statistics-england-and-wales-january-to-june-2014/police-use-of-taser-statistics-england-and-wales-january-to-june-2014)), "just" 20% of taser use by UK police officers involved tasers being fired - breakdown figure [here](https://assets.digital.cabinet-office.gov.uk/government/uploads/system/uploads/image_data/file/31544/police-taser-janjun1-2014.png). [`Figure 1`](https://gist.github.com/lmmx/5e75f32350cb23a56691#file-figure-1-pie-chart-on-how-taser-was-used-png)

> The figures in this report show the number of times taser was used as opposed to the number of taser ‘incidents’. This is designed to ensure full transparency on taser deployment, as more than one taser may be used at an incident.

![](https://assets.digital.cabinet-office.gov.uk/government/uploads/system/uploads/image_data/file/31544/police-taser-janjun1-2014.png)

Home Office statistics show a rise in police use of tasers, with the [figure online](https://assets.digital.cabinet-office.gov.uk/government/uploads/system/uploads/image_data/file/31545/police-taser-janjun2-2014.png) aggregating quarterly data to annual. [`Figure 2`](https://gist.github.com/lmmx/5e75f32350cb23a56691#file-figure-2-yearly-uk-figures-on-taser-use-png)

![](https://assets.digital.cabinet-office.gov.uk/government/uploads/system/uploads/image_data/file/31545/police-taser-janjun2-2014.png)

They note the increase **can partly be accounted for by the phased rollout** of tasers from Authorised Firearm Officers to Specially Trained Units across all police forces in England and Wales.

* Inter-region comparisons may not be valid (further details [here](https://www.gov.uk/government/publications/police-use-of-taser-statistics-england-and-wales-january-to-june-2014/police-use-of-taser-statistics-england-and-wales-january-to-june-2014#data-quality-and-use-of-data))
* There are 'ongoing complications' with the Home Office Taser Database, requests for raw data have been denied (links from What Do They Know site begin [here](https://www.whatdotheyknow.com/request/quarterly_statistics_on_taser_us))
* Force policies on taser use will differ
* The Home Office data were apparently analysed for "medical implications". This is excluded from the published reports, and arguably should be as their use increases.

The data on type of usage (red dot, stun, firing being the main categories, each defined [here](https://www.gov.uk/government/publications/police-use-of-taser-statistics-england-and-wales-january-to-june-2014/police-use-of-taser-statistics-england-and-wales-january-to-june-2014#background-and-definitions)) allow some general observations. Using code in the [`Documentation scripts`](https://gist.github.com/lmmx/5e75f32350cb23a56691#file-documentation-scripts-sh) file in [this GitHub gist report](https://gist.github.com/lmmx/5e75f32350cb23a56691), I sorted this data into lists [`by totals`](https://gist.github.com/lmmx/5e75f32350cb23a56691#file-type-of-use-sorted-by-total-uses-tsv) and [`by firings`](https://gist.github.com/lmmx/5e75f32350cb23a56691#file-type-of-use-sorted-by-taser-firings-tsv).

'Red dotted' remained the largest category (generally around half of 'usage'), however this can also be interpreted perhaps as officers using it as a source of intimidation or mode of avoiding confrontation, and given a) the safety concerns around these weapons, and b) their predominant use on those with mental health it's worth thinking critically about, and highlights the need for further usage breakdowns from FOI requests until such a time the Home Office releases their Taser Database statistics.

* The total usage clearly correlates with force size, i.e. "police strength", as is to be expected, see below

Regarding the phased rollout, figures on the year this occurred in for each region of England & Wales are available in the appendix of the [2014 data table](https://www.gov.uk/government/statistics/police-use-of-taser-statistics-england-and-wales-january-to-june-2014) (.ods spreadsheet [here](https://www.gov.uk/government/uploads/system/uploads/attachment_data/file/363771/police-use-of-taser-janjun-2014-tabs.ods)). These figures have been sorted by year provided to officers ([`firearms officers`](https://gist.github.com/lmmx/5e75f32350cb23a56691#file-regions-sorted-by-year-first-issued-to-firearms-officers-tsv) and [`specially trained units`](https://gist.github.com/lmmx/5e75f32350cb23a56691#file-regions-sorted-by-year-first-issued-to-trained-units-tsv)).

There's nothing that would suggest these are relevant to interpreting recent figures (Cambridgeshire and Essex issuing tasers to trained units just last year, these areas aren't particularly out of the ordinary in usage stats).

## Police strength

Police workforce statistics are available from the Home Office: table 9 of the March 2014 figures give police officers by area (again England and Wales) from March 2012 - March 2013; table 4 the same figures from March 2013 - March 2014. These tables have total police as well as per 100,000 population, though these may indeed be irrelevant, the pertinent figure being instead the numbers of officers authorised to use, or provided with, tasers. See [`Police workforce regional stats March 2013 - March 2014.tsv`](https://gist.github.com/lmmx/5e75f32350cb23a56691#file-police-workforce-regional-stats-march-2013-march-2014-tsv) (plain text version to view [`here`](https://gist.github.com/lmmx/5e75f32350cb23a56691#file-police-workforce-regional-stats-march-2013-march-2014-txt), as made for all these tables).

Bearing this limitation in mind, total officers per 100,000 population means population sizes can still be obtained for these regions, to scale taser incidents per 100,000 population. The City of London is the only region to have no population-scaled data (its police force is as large as Warwickshire's, unclear why there's no population size given).

* Figures are just scaled to population and police force sizes fixed at most recent year (there are further archived figures on the [Home Office Stats site](https://www.gov.uk/government/collections/police-workforce-england-and-wales#documents), **currently just the 2013-14 figures are used here**, discriminating general regional sizes).
* Further data trickery in R (statistical programming language) produced figures [`5`](https://gist.github.com/lmmx/5e75f32350cb23a56691#file-figure-5-national-taser-use-population-corrected-png) and [`6`](https://gist.github.com/lmmx/5e75f32350cb23a56691#file-figure-6-national-taser-use-police-force-size-corrected-png), the same figures for national regions.
* All graphs are very easy to customise now they're produced, it's just a matter of tweaking graphical parameters. [Play around with examples here](http://shinyapps.stat.ubc.ca/r-graph-catalog/) and find more galleries of ggplot graphs [here](http://stats.stackexchange.com/questions/78844/a-gallery-of-charts-diagrams-and-plot-types)
* Questions, contact: Louis, or naivelocus at gmail dot com
