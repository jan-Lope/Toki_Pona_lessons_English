#!/bin/bash
###############################################################################
#
# Make booklet for the toki pona lessons.
# Robert Warnke
# Sep 2015
#
###############################################################################
#
clear
TODAY=`date +"%Y-%m-%d"`
#
###############################################################################
#
echo "Make dvi files"
echo "------------------------------------------------------------------"
latex toki-pona-lessons_en.tex > /dev/null
echo " "
#
###############################################################################
#
echo "Make Bibliography"
echo "------------------------------------------------------------------"
bibtex toki-pona-lessons_en > /dev/null
echo " "
#
###############################################################################
#
echo "Make dvi files again"
echo "------------------------------------------------------------------"
latex toki-pona-lessons_en.tex > /dev/null
echo " "
#
###############################################################################
#
echo "Make index"
echo "------------------------------------------------------------------"
makeindex toki-pona-lessons_en.idx > /dev/null
ls -l toki-pona-lessons_en.idx
echo " "
#
###############################################################################
#
echo "Make content index"
echo "------------------------------------------------------------------"
latex toki-pona-lessons_en.tex > /dev/null
ls -l toki-pona-lessons_en.dvi
echo " "
#
###############################################################################
#
echo "Make html files"
echo "------------------------------------------------------------------"
echo "Configuration file: .latex2html-init"
latex2html toki-pona-lessons_en.tex > /dev/null
cp toki-pona-lessons.css toki-pona-lessons_en
cp tokipona-logo.gif toki-pona-lessons_en
ls toki-pona-lessons_en
echo " "
#
# Make a better view for tables:
for i in `ls toki-pona-lessons_en/*.html` ; do
          sed -e '1,$s/ BORDER=\"1\"/ BORDER=\"0\"/g' $i > $i.neu && mv $i.neu $i
          sed -e '1,$s/ VALIGN=\"TOP\" WIDTH=5/ VALIGN=\"TOP\" WIDTH=\"300\"/g' $i > $i.neu && mv $i.neu $i
done
###############################################################################
#
echo "Make word list for ding dictionary"
echo "------------------------------------------------------------------"
echo "http://www-user.tu-chemnitz.de/~fri/ding/"
fgrep "&&" *.tex | fgrep "\\" | fgrep -v "%" | fgrep -v "% no-dictionary" | fgrep -v "% & English - Toki Pona" | cut -d: -f2- | awk -F\& '{
print $1 "::" $3 $4 $5 $6 $7 }'  > tmp.txt
fgrep "&&" *.tex | fgrep "\\" | fgrep "% & English - Toki Pona" | cut -d: -f2- | awk -F\& '{print $3 ":: " $1 }'  >> tmp.txt
#
# quick 'n' dirty
#
sed -e 's#'%'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'*'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'}'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'\textbf{'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'\textit{'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'\textsc{'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'\dots'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt

echo "## $TODAY http://rowa.giso.de/languages/toki-pona/" > toki-pona-lessons_en/toki-pona_english.txt
cat tmp.txt | sort | uniq >> toki-pona-lessons_en/toki-pona_english.txt

rm -f tmp.txt
wc -l toki-pona-lessons_en/toki-pona_english.txt
echo " "
#
###############################################################################
#
echo "Make pdf file"
echo "------------------------------------------------------------------"
pdflatex toki-pona-lessons_en.tex > /dev/null
ls -l latex toki-pona-lessons_en.pdf
evince toki-pona-lessons_en.pdf
#
###############################################################################
#
echo "Make ps file"
echo "------------------------------------------------------------------"
rm -f *.ps
dvips toki-pona-lessons_en.dvi > /dev/null
ls -l toki-pona-lessons_en.ps
echo " "
#
###############################################################################
#
echo "Make booklet ps-file"
echo "------------------------------------------------------------------"
pstops 4:-3L@.7\(21cm,0\)+0L@.7\(21cm,14.85cm\),1L@.7\(21cm,0\)+-2L@.7\(21cm,14.85cm\) toki-pona-lessons_en.ps toki-pona-lessons-booklet_en.ps
echo " "
#
###############################################################################
#
echo "Make booklet pdf-file"
echo "------------------------------------------------------------------"
ps2pdf toki-pona-lessons-booklet_en.ps
ls -l toki-pona-lessons-booklet_en.*
echo " "
#
###############################################################################
#
rm -rf toki-pona-tex-files_en
rm -f toki-pona-tex-files_en.tar.gz
mkdir -p toki-pona-tex-files_en
cp *.tex toki-pona-tex-files_en
cp *.sh toki-pona-tex-files_en
cp *.bib toki-pona-tex-files_en
cp .latex2html-init toki-pona-tex-files_en
cp *.css toki-pona-tex-files_en
tar czf toki-pona-tex-files_en.tar.gz toki-pona-tex-files_en
rm -r toki-pona-tex-files_en
#
###############################################################################
#
echo "------------------------------------------------------------------"
echo "pona!"
echo "------------------------------------------------------------------"
echo "Print the odd numbers first."
echo "Put the paper with the script on the top again in the printer."
echo "------------------------------------------------------------------"
#
###############################################################################
###############################################################################
# eof
