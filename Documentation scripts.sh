# These scripts run on Linux, Mac is also a unix operating system and should support these functions, Windows users can use Cygwin (or run Linux using VirtualBox)
# Notably sort -t $'\t' (setting tab-delimited sorting) requires a bash shell, see http://stackoverflow.com/questions/17430470/sort-a-tab-delimited-file-based-on-column-sort-command-bash
#   - 'sed' is used to delete lines from input (either by line number or matching a word etc.) and to replace '&' with 'and' to make some labels match etc.
#   - 'expand' is used to set column widths for screen display, or for neat text output
#   - tab-separated value (tsv) files are the best way of storing data for this sort of use. Excel can read these files (open as csv, delimiter=tab)
#   - 'tr' is used here to delete percent signs and commas, to permit sorting numerical values
#   - 'tac' reverses the order of lines passed to it (used to sort the list descending rather than ascending)
#   - 'cut' extracts columns in the tab-separated output (necessary to read a table in R for plotting, as simply reading the spreadsheet gives rows with varying no's of blank columns)

# See "Data rescaling and visualisation documentation.R" for data vis details (using R's graphics library ggplot2)

# To make "Type of use sorted by total uses" .tsv and .txt (using lines 4 to 60 of source tsv, removing percent signs in order to sort on column 10)
outputfile=$(echo -e "Force\tNot stated\tDrawn\tAimed\tArced\tRed Dotted\tDrive Stun\tAngle Drive Stun\tFired\tTotal uses"; sed '4,60!d' Police\ use\ of\ tasers\ Jan-Jun\ 2014\ \(type\ and\ force\ breakdown\ percentages\).tsv | sed -e 's/&/and/g' -e 's/Cornwall /Cornwall/g' | tr -d '%' | sed '/^Wales\|Region\|Total/d' | tail --lines=+3 | sort -t $'\t' -k 10,10n | tac | cut -d $'\t' -f 1-10)
echo "$outputfile" > Type\ of\ use\ sorted\ by\ total\ uses.tsv
echo "$outputfile" | expand -t 40,55,65,75,85,100,115,135,145 > Type\ of\ use\ sorted\ by\ total\ uses.txt

# To make "Type of use sorted by taser firings" .tsv and .txt (using lines 4 to 60 of source tsv, reverse sorting on column 9)
outputfile=$(echo -e "Force\tNot stated\tDrawn\tAimed\tArced\tRed Dotted\tDrive Stun\tAngle Drive Stun\tFired\tTotal uses"; sed '4,60!d' Police\ use\ of\ tasers\ Jan-Jun\ 2014\ \(type\ and\ force\ breakdown\ percentages\).tsv | sed -e 's/&/and/g' -e 's/Cornwall /Cornwall/g' | tr -d '%' | sed '/^Wales\|Region\|Total/d' | sed '/s/&/and/g' | tail --lines=+3 | sort -t $'\t' -k 9,9n | tac | cut -d $'\t' -f 1-10)
echo "$outputfile" > Type\ of\ use\ sorted\ by\ taser\ firings.tsv
echo "$outputfile" | expand -t 40,55,65,75,85,100,115,135,145 > Type\ of\ use\ sorted\ by\ taser\ firings.txt

# To make "Regions sorted by year first issued to firearms officers" .tsv and .txt
outputfile=$(echo -e "Force\tFirst issued to Authorised Firearms Officers\tFirst Issued to Specially Trained Units"; sed '7,47!d' Police\ use\ of\ tasers\ Jan-Jun\ 2014\ \(appendix\ 1\ -\ years\ issued\ to\ firearms\ officers\ and\ trained\ units\).tsv | sed 's/Cornwall /Cornwall/g' | sed '/^Wales\|Region\|Total/d' | sort -t $'\t' -k 2,2n -k 3,3n -k 1,1 | cut -d $'\t' -f 1-3)
echo "$outputfile" > Regions\ sorted\ by\ year\ first\ issued\ to\ firearms\ officers.tsv
echo "$outputfile" | expand -t 25,80 > Regions\ sorted\ by\ year\ first\ issued\ to\ firearms\ officers.txt

# To make "Regions sorted by year first issued to trained units" .tsv and .txt
outputfile=$(echo -e "Force\tFirst issued to Authorised Firearms Officers\tFirst Issued to Specially Trained Units"; sed '7,47!d' Police\ use\ of\ tasers\ Jan-Jun\ 2014\ \(appendix\ 1\ -\ years\ issued\ to\ firearms\ officers\ and\ trained\ units\).tsv | sed 's/Cornwall /Cornwall/g' | sed '/^Wales\|Region\|Total/d' | sort -t $'\t' -k 3,3n -k 2,2n -k 1,1 | cut -d $'\t' -f 1-3)
echo "$outputfile" > Regions\ sorted\ by\ year\ first\ issued\ to\ trained\ units.tsv
echo "$outputfile" | expand -t 25,80 > Regions\ sorted\ by\ year\ first\ issued\ to\ trained\ units.txt

# To make "Police workforce regional stats\ March\ 2013\ -\ March\ 2014" .tsv and .txt
outputfile=$(echo -e "Force\tTotal police ranks\tTotal officers per 100,000 population\tEstimated population size"; cut -d $'\t' -f 1,18,19,22 Police\ workforces\ by\ region\ Mar13-Mar14.tsv | sed -e 's/London, City of/City of London/g' -e 's/Metropolitan Police/Metropolitan/g' | sed '6,48!d' | tr -d ',' | cut -d $'\t' -f 1-4)
echo "$outputfile" > Police\ workforce\ regional\ stats\ March\ 2013\ -\ March\ 2014.tsv
echo "$outputfile" | expand -t 25,50,95 > Police\ workforce\ regional\ stats\ March\ 2013\ -\ March\ 2014.txt

# To make "Police half-yearly taser use regional stats" .tsv and .txt
outputfile=$(echo -e "Force\tJun09\tDec09\tJun10\tDec10\tJun11\tDec11\tJun12\tDec12\tJun13\tDec13\tJun14"; sed '9,60!d' Police\ half-yearly\ use\ of\ tasers\ Jan09-Jun14.tsv | sed '/^Wales\|Region/d' | sed -e 's/&/and/g' -e 's/Cornwall /Cornwall/g' | sort -t $'\t' -k 12,12n | tac | cut -d $'\t' -f 1-12)
echo "$outputfile" > Police\ half-yearly\ taser\ use\ regional\ stats\ JanJun09\ -\ JanJun14.tsv
echo "$outputfile" | expand -t 25,35,45,55,65,75,85,95,105,115,125 > Police\ half-yearly\ taser\ use\ regional\ stats\ JanJun09\ -\ JanJun14.txt

# mismatches between police size and police taser use labels corrected by hand, checked for with:
# cutf 1 Police\ half-yearly\ taser\ use\ regional\ stats\ JanJun09\ -\ JanJun14.tsv Police\ workforce\ regional\ stats\ March\ 2013\ -\ March\ 2014.tsv | sort | uniq -c | grep '   1 '
# sed expressions removed these mismatches (on "City of London", "Metropolitan Police", "Cornwall")


# To map regional data to broader regions, see R documentation instead using aggregate() function. Shell scripting gets too messy
