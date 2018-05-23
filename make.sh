#!/bin/bash
###############################################################################
#
# Make pdf, booklet-pdf, epub and html files for the English Toki Pona lessons 
# Robert Warnke
#
###############################################################################
#
TEX_FILE="toki-pona-lessons_en"
CSV_FILE_DICT="toki-pona_english.csv"
TEX_FILE_WORD_LIST="nimi_pi_toki_pona"
TXT_FILE_WORD_LIST="nimi_pi_toki_pona.txt"
CSV_FILE_WORD_LIST="nimi_pi_toki_pona.csv"
DICT_FILE_WORD_LIST="nimi_pi_toki_pona-dict"
MAN_FILE_WORD_LIST="toki-pona.6"
TODAY=`date +"%Y-%m-%d"`
#
###############################################################################
#
echo " "
echo "########################################################################"
echo "start $0"
echo " "
rm -rf *.dvi
rm -rf *.ps
rm -rf *.pdf
echo "make dvi file"
latex $TEX_FILE.tex > /dev/null
latex $TEX_FILE.tex > /dev/null 
if [ ! -f $TEX_FILE.dvi ]; then
	echo "ERROR"
	exit 1
fi
echo "make bibliography"
bibtex $TEX_FILE > /dev/null
if [ ! -f $TEX_FILE.blg ]; then
	echo "ERROR"
	exit 1
fi
echo "make table of contents"
latex $TEX_FILE.tex > /dev/null
echo "make index"
makeindex $TEX_FILE.idx > /dev/null 2> /dev/null
if [ ! -f $TEX_FILE.idx ]; then
	echo "ERROR"
	exit 1
fi
echo "make table of contents"
latex $TEX_FILE.tex > /dev/null
echo "make pdf file"
pdflatex $TEX_FILE.tex > /dev/null
if [ ! -f $TEX_FILE.pdf ]; then
	echo "ERROR"
	exit 1
fi
echo "make ps file"
dvips $TEX_FILE.dvi > /dev/null 2> /dev/null
if [ ! -f $TEX_FILE.ps ]; then
	echo "ERROR"
	exit 1
fi
echo "make booklet ps file" 
pstops 4:-3L@.7\(21cm,0\)+0L@.7\(21cm,14.85cm\),1L@.7\(21cm,0\)+-2L@.7\(21cm,14.85cm\) $TEX_FILE.ps $TEX_FILE-booklet.ps > /dev/null 2> /dev/null
if [ ! -f $TEX_FILE-booklet.ps ]; then
	echo "ERROR"
	exit 1
fi
echo "make booklet pdf file" 
ps2pdf $TEX_FILE-booklet.ps
if [ ! -f $TEX_FILE-booklet.pdf ]; then
	echo "ERROR"
	exit 1
fi
echo "convert A4 pdf to letter pdf"
pdfjam --outfile $TEX_FILE-letter.pdf --paper letter $TEX_FILE.pdf > /dev/null 2> /dev/null
if [ ! -f $TEX_FILE-letter.pdf ]; then
	echo "ERROR"
	exit 1
fi
pdfjam --outfile $TEX_FILE-booklet-letter.pdf --paper letter $TEX_FILE-booklet.pdf > /dev/null 2> /dev/null
if [ ! -f $TEX_FILE-booklet-letter.pdf ]; then
	echo "ERROR"
	exit 1
fi
# pdfinfo $TEX_FILE-booklet-letter.pdf
#
###############################################################################
#
echo "make html files"
latex2html $TEX_FILE.tex > /dev/null 2> /dev/null
if [ ! -f $TEX_FILE/index.html ]; then
	echo "ERROR"
	exit 1
fi
cp toki-pona-lessons.css $TEX_FILE
if [ ! -f $TEX_FILE/toki-pona-lessons.css ]; then
	echo "ERROR"
	exit 1
fi
cp tokipona-logo.gif $TEX_FILE
if [ ! -f $TEX_FILE/tokipona-logo.gif ]; then
	echo "ERROR"
	exit 1
fi
for i in `ls $TEX_FILE/*.html` ; do
          sed -e '1,$s/ BORDER=\"1\"/ BORDER=\"0\"/g' $i > $i.neu && mv $i.neu $i
          sed -e '1,$s/ VALIGN=\"TOP\" WIDTH=5/ VALIGN=\"TOP\" WIDTH=\"300\"/g' $i > $i.neu && mv $i.neu $i
          sed -e '1,$s/<TH ALIGN=/<TD ALIGN=/g' $i > $i.neu && mv $i.neu $i
          sed -e '1,$s/<TD ALIGN=\"LEFT\">/<TD ALIGN=\"LEFT\" VALIGN=\"TOP\">/g' $i > $i.neu && mv $i.neu $i
done
#
###############################################################################
#
echo "make epub file" 
ebook-convert $TEX_FILE/$TEX_FILE.html $TEX_FILE.epub --no-default-epub-cover > /dev/null 2> /dev/null
if [ ! -f $TEX_FILE.epub ]; then
	echo "ERROR"
	exit 1
fi
ebook-convert $TEX_FILE/$TEX_FILE.html $TEX_FILE.mobi > /dev/null 2> /dev/null
if [ ! -f $TEX_FILE.mobi ]; then
	echo "ERROR"
	exit 1
fi
ebook-convert $TEX_FILE/$TEX_FILE.html $TEX_FILE.azw3 > /dev/null 2> /dev/null
if [ ! -f $TEX_FILE.azw3 ]; then
	echo "ERROR"
	exit 1
fi
#
###############################################################################
#
echo "Create Build directory and copy the pdf, epub and html files in this directory."
rm -rf _build/
mkdir -p _build/
mv *.pdf _build/
mv *.epub _build/
mv *.mobi _build/
mv *.azw3 _build/
#
if [ ! -f _build/$TEX_FILE.pdf ]; then
	echo "ERROR"
	exit 1
fi
if [ ! -f _build/$TEX_FILE-booklet.pdf ]; then
	echo "ERROR"
	exit 1
fi
mv $TEX_FILE _build/
if [ ! -f _build/$TEX_FILE/index.html ]; then
	echo "ERROR"
	exit 1
fi
if [ ! -f _build/$TEX_FILE.epub ]; then
	echo "ERROR"
	exit 1
fi
#
###############################################################################
#
echo "make clear"
rm -f *.synctex.gz
rm -f *.tmp
rm -f tmp.*
rm -f *.swp
rm -f *.aux
rm -f *.lof
rm -f *.log
rm -f *.lot
rm -f *.fls
rm -f *.out
rm -f *.toc
rm -f *.fmt
rm -f *.fot
rm -f *.cb
rm -f *.cb2
rm -f *.dvi
rm -f *.ps
rm -f *.eps
rm -f *.pdf
rm -f *.bbl
rm -f *.blg
rm -f *.bcf
rm -f *.blg
rm -f *-blx.aux
rm -f *-blx.bib
rm -f *.run.xml
rm -f *.idx
rm -f *.ilg
rm -f *.ind
rm -f *.ist
rm -f *.epub
#
###############################################################################
#
echo "make word list for ding dictionary ( http://www-user.tu-chemnitz.de/~fri/ding/ )"
fgrep "&&" *.tex | fgrep "\\" | fgrep -v "%" | fgrep -v "% no-dictionary" | fgrep -v "% & English - Toki Pona" | cut -d: -f2- | awk -F\& '{print $1 "::" $3 $4 $5 $6 $7 }'  > tmp.txt
fgrep "&&" *.tex | fgrep "\\" | fgrep "% & English - Toki Pona" | cut -d: -f2- | awk -F\& '{print $3 ":: " $1 }'  >> tmp.txt
if [ ! -f tmp.txt ]; then
	echo "ERROR"
	exit 1
fi
# quick 'n' dirty
sed -e 's#'%'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'*'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'}'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'\textbf{'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'\textit{'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'\textsc{'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'\dots'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'\glqq'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#'\grqq'#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#\\#''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
sed -e 's#^ #''#g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt
expand tmp.txt > tmp.neu && mv tmp.neu tmp.txt                          # replace tabs with spaces
sed -e 's/  */ /g' tmp.txt > tmp.neu && mv tmp.neu tmp.txt              # strip multiple spaces to one
sed -e 's/[ \t]*$//' "$1" tmp.txt > tmp.neu && mv tmp.neu tmp.txt       # strip trailing whitespace
echo "## $TODAY Automatically generated from the Toki Pona lessons. https://github.com/jan-Lope/" > toki-pona_english.txt
echo "## You can use this dictionary with the software ding ( http://www-user.tu-chemnitz.de/~fri/ding/ ). " >> toki-pona_english.txt
cat tmp.txt | sort | uniq | grep -v "^::" >> toki-pona_english.txt
rm -f tmp.txt
rm -f tmp.neu
DICT_LINES=`cat toki-pona_english.txt | wc -l`
if [ $? != 0  ]; then
	echo "ERROR"
	exit 1
fi
if [ $DICT_LINES -lt 1700 ]; then
	echo "ERROR"
	exit 1
fi
fgrep "mi moku" toki-pona_english.txt > /dev/null 2> /dev/null
if [ $? != 0  ]; then
	echo "ERROR"
	exit 1
fi
mv toki-pona_english.txt _build
fgrep "mi moku" _build/toki-pona_english.txt > /dev/null 2> /dev/null
if [ $? != 0  ]; then
	echo "ERROR"
	exit 1
fi
#
###############################################################################
#
echo "make dictionary.coffee"
cat dictionary-head.coffee > _build/dictionary.coffee
# expand _build/toki-pona_english.txt | fgrep -v "##" | sed -e 's#'\''#''#g' | sed -e 's/  */ /g'  >> _build/dictionary.coffee
expand _build/toki-pona_english.txt | fgrep -v "##" | sed -e 's/  */ /g' | iconv -f ISO-8859-15 -t UTF-8 >> _build/dictionary.coffee
cat dictionary-tail.coffee >>  _build/dictionary.coffee
#
echo "make dictionary.js"
# coffeelint _build/dictionary.coffee
coffee -c _build/dictionary.coffee
if [ $? != 0  ]; then
	echo "ERROR"
	exit 1
fi
# coffee -v
rm -f _build/dictionary.coffee
cp dictionary.html _build/
#
###############################################################################
#
echo "make a csv dictionary file "
rm -f $CSV_FILE_DICT
cat _build/toki-pona_english.txt | iconv -f ISO-8859-1 -t UTF-8  | sed -e 's#'::'#'@'#g' | fgrep -v "##"  | \
		sed -e 's#'@\ '#'@'#g' | sed -e 's#'@\ '#'@'#g' | sed -e 's#'@\ '#'@'#g' | \
		sed -e 's#'\ @'#'@'#g' | sed -e 's#'\ @'#'@'#g' | \
	    awk -F\@ '{print "\"" $1 "\",\"" $2 "\"" }' | sort | uniq >> $CSV_FILE_DICT
fgrep "mi moku" $CSV_FILE_DICT > /dev/null 2> /dev/null
if [ $? != 0  ]; then
	echo "ERROR"
	exit 1
fi
rm -f _build/$CSV_FILE_DICT
cp $CSV_FILE_DICT _build/
if [ ! -f _build/$CSV_FILE_DICT ]; then
	echo "ERROR"
	exit 1
fi
#
###############################################################################
#
echo "make csv file with official word list"
rm -f $CSV_FILE_WORD_LIST
fgrep "&&" dict.tex  | iconv -f ISO-8859-1 -t UTF-8 | fgrep "\\" | fgrep -v "%" | sed -e 's#'\dots'#''#g' | sed -e 's#\\#''#g' | \
        sed -e 's#'\glqq'#'\''#g' | sed -e 's#'\grqq'#'\''#g' | \
        sed -e 's#'\textbf{'#'@'#g' | sed -e 's#'\textit{'#'@'#g' | sed -e 's#'}:'#'@'#g' | sed -e 's#'}'#'@'#g' | \
        sed -e 's#'@\ '#'@'#g' | sed -e 's#'@\ '#'@'#g' | sed -e 's#'@\ '#'@'#g' | \
        sed -e 's#'\"'#'\'\''#g' | sed -e 's#'\&'#''#g' | \
        sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | \
        awk -F\@ '{print "\"" $2 "\",\"" $4 "\",\"" $5 "\"" }'  >> $CSV_FILE_WORD_LIST
if [ ! -f $CSV_FILE_WORD_LIST ]; then
	echo "ERROR"
	exit 1
fi
rm -f _build/$CSV_FILE_WORD_LIST
cp $CSV_FILE_WORD_LIST _build/
if [ ! -f _build/$CSV_FILE_WORD_LIST ]; then
	echo "ERROR"
	exit 1
fi
#
###############################################################################
#
echo "make txt file with official word list"
rm -f $TXT_FILE_WORD_LIST
echo "Toki Pona - official word list $TODAY"                                                               > $TXT_FILE_WORD_LIST
echo "https://jan-lope.github.io"                                                                         >> $TXT_FILE_WORD_LIST
echo ""                                                                                                   >> $TXT_FILE_WORD_LIST
fgrep "&&" dict.tex  | iconv -f ISO-8859-1 -t UTF-8 | fgrep "\\" | fgrep -v "%" | sed -e 's#'\dots'#''#g' | sed -e 's#\\#''#g' | \
        sed -e 's#'\glqq'#'\''#g' | sed -e 's#'\grqq'#'\''#g' | \
        sed -e 's#'\textbf{'#'@'#g' | sed -e 's#'\textit{'#'@'#g' | sed -e 's#'}:'#'@'#g' | sed -e 's#'}'#'@'#g' | \
        sed -e 's#'@\ '#'@'#g' | sed -e 's#'@\ '#'@'#g' | sed -e 's#'@\ '#'@'#g' | \
        sed -e 's#'\"'#'\'\''#g' | sed -e 's#'\&'#''#g' | \
        sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | \
        awk -F\@ '{print $2 "\n" $4 ": " $5 "\n"}'  >> $TXT_FILE_WORD_LIST
if [ ! -f $TXT_FILE_WORD_LIST ]; then
	echo "ERROR"
	exit 1
fi
rm -f _build/$TXT_FILE_WORD_LIST
cp $TXT_FILE_WORD_LIST _build/
if [ ! -f _build/$TXT_FILE_WORD_LIST ]; then
	echo "ERROR"
	exit 1
fi
#
###############################################################################
#
#
echo "make rtf file with official word list"
rm -f $TEX_FILE_WORD_LIST.tex
rm -f $TEX_FILE_WORD_LIST.rtf
echo "\documentclass[10pt,a4paper]{article}"          > $TEX_FILE_WORD_LIST.tex
echo "\usepackage[utf8]{inputenc}"                   >> $TEX_FILE_WORD_LIST.tex
echo "\usepackage{amssymb}"                          >> $TEX_FILE_WORD_LIST.tex
echo "\begin{document}"                              >> $TEX_FILE_WORD_LIST.tex
echo "\title{Toki Pona - Dictionary}"                >> $TEX_FILE_WORD_LIST.tex
echo "\author{jan Lope https://jan-lope.github.io/}" >> $TEX_FILE_WORD_LIST.tex
echo "\date"                                         >> $TEX_FILE_WORD_LIST.tex
echo "\today"                                        >> $TEX_FILE_WORD_LIST.tex
echo "\maketitle"                                    >> $TEX_FILE_WORD_LIST.tex
echo "\begin{tabular}{lll}"                          >> $TEX_FILE_WORD_LIST.tex
fgrep "&&" dict.tex                                  >> $TEX_FILE_WORD_LIST.tex
echo "\end{tabular}"                                 >> $TEX_FILE_WORD_LIST.tex
echo "\end{document}"                                >> $TEX_FILE_WORD_LIST.tex
# latex $TEX_FILE_WORD_LIST.tex
# latex2html  $TEX_FILE_WORD_LIST.tex 
if [ ! -f $TEX_FILE_WORD_LIST.tex ]; then
	echo "ERROR"
	exit 1
fi
latex2rtf $TEX_FILE_WORD_LIST.tex
if [ $? != 0  ]; then
	echo "ERROR"
	exit 1
fi
rm -f _build/$TEX_FILE_WORD_LIST.rtf
cp $TEX_FILE_WORD_LIST.rtf _build/
if [ ! -f _build/$TEX_FILE_WORD_LIST.rtf ]; then
	echo "ERROR"
	exit 1
fi
rm -rf $TEX_FILE_WORD_LIST*
#
###############################################################################
#
echo "make dictionary files: .dict and .index"
rm -rf $DICT_FILE_WORD_LIST.txt
rm -rf $DICT_FILE_WORD_LIST.dict 
rm -rf $DICT_FILE_WORD_LIST.index
fgrep "&&" dict.tex  | iconv -f ISO-8859-1 -t UTF-8 | fgrep "\\" | fgrep -v "%" | sed -e 's#'\dots'#''#g' | sed -e 's#\\#''#g' | \
        sed -e 's#'\glqq'#'\''#g' | sed -e 's#'\grqq'#'\''#g' | \
        sed -e 's#'\textbf{'#'@'#g' | sed -e 's#'\textit{'#'@'#g' | sed -e 's#'}:'#'@'#g' | sed -e 's#'}'#'@'#g' | \
        sed -e 's#'@\ '#'@'#g' | sed -e 's#'@\ '#'@'#g' | sed -e 's#'@\ '#'@'#g' | \
        sed -e 's#'\"'#'\'\''#g' | sed -e 's#'\&'#''#g' | \
        sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | \
        awk -F\@ '{print ":" $2 ":" $4 " = " $5 }'  >> $DICT_FILE_WORD_LIST.txt
dictfmt --utf8 --allchars -s "Toki Pona - English, $TODAY  https://jan-lope.github.io" -j $DICT_FILE_WORD_LIST < $DICT_FILE_WORD_LIST.txt
if [ $? != 0  ]; then
	echo "ERROR"
	exit 1
fi
cp $DICT_FILE_WORD_LIST.dict _build/
cp $DICT_FILE_WORD_LIST.index _build/
if [ ! -f _build/$DICT_FILE_WORD_LIST.dict ]; then
	echo "ERROR"
	exit 1
fi
if [ ! -f _build/$DICT_FILE_WORD_LIST.index ]; then
	echo "ERROR"
	exit 1
fi
rm -rf $DICT_FILE_WORD_LIST.txt
rm -rf $DICT_FILE_WORD_LIST.dict 
rm -rf $DICT_FILE_WORD_LIST.index
#
###############################################################################
#
echo "make dictionary files: .dict and .index"
rm -rf $DICT_FILE_WORD_LIST.txt
rm -rf $DICT_FILE_WORD_LIST.dict 
rm -rf $DICT_FILE_WORD_LIST.index
fgrep "&&" dict.tex  | iconv -f ISO-8859-1 -t UTF-8 | fgrep "\\" | fgrep -v "%" | sed -e 's#'\dots'#''#g' | sed -e 's#\\#''#g' | \
        sed -e 's#'\glqq'#'\''#g' | sed -e 's#'\grqq'#'\''#g' | \
        sed -e 's#'\textbf{'#'@'#g' | sed -e 's#'\textit{'#'@'#g' | sed -e 's#'}:'#'@'#g' | sed -e 's#'}'#'@'#g' | \
        sed -e 's#'@\ '#'@'#g' | sed -e 's#'@\ '#'@'#g' | sed -e 's#'@\ '#'@'#g' | \
        sed -e 's#'\"'#'\'\''#g' | sed -e 's#'\&'#''#g' | \
        sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | \
        awk -F\@ '{print ":" $2 ":" $4 " = " $5 }'  >> $DICT_FILE_WORD_LIST.txt
dictfmt --utf8 --allchars -s "Toki Pona - English, $TODAY  https://jan-lope.github.io" -j $DICT_FILE_WORD_LIST < $DICT_FILE_WORD_LIST.txt
if [ $? != 0  ]; then
	echo "ERROR"
	exit 1
fi
cp $DICT_FILE_WORD_LIST.dict _build/
cp $DICT_FILE_WORD_LIST.index _build/
if [ ! -f _build/$DICT_FILE_WORD_LIST.dict ]; then
	echo "ERROR"
	exit 1
fi
if [ ! -f _build/$DICT_FILE_WORD_LIST.index ]; then
	echo "ERROR"
	exit 1
fi
rm -rf $DICT_FILE_WORD_LIST.txt
rm -rf $DICT_FILE_WORD_LIST.dict 
rm -rf $DICT_FILE_WORD_LIST.index
#
###############################################################################
#
echo "make man page of official word list"
rm -f ./$MAN_FILE_WORD_LIST
rm -f ./$MAN_FILE_WORD_LIST.gz
echo ".TH man 6 $TODAY Toki Pona - Dictionary"   > $MAN_FILE_WORD_LIST
echo ".SH NAME"                                 >> $MAN_FILE_WORD_LIST
echo "Toki Pona - Dictionary"                   >> $MAN_FILE_WORD_LIST
echo ".SH DESCRIPTION"                          >> $MAN_FILE_WORD_LIST
echo "Toki Pona is a constructed language that favors simplicity over clarity, and touts itself as 'the language of good. The simple way of life.' Toki Pona has only about 120 words."  >> $MAN_FILE_WORD_LIST
echo ".SH DICTIONARY"                           >> $MAN_FILE_WORD_LIST
#
fgrep "&&" dict.tex  | fgrep "\\" | fgrep -v "%" | sed -e 's#'\dots'#''#g' | sed -e 's#\\#''#g' | \
	sed -e 's#'\textbf{'#'@'#g' | sed -e 's#'\textit{'#'@'#g' | sed -e 's#'}:'#'@'#g' | sed -e 's#'}'#'@'#g' | \
	sed -e 's#'@\ '#'@'#g' 	| sed -e 's#'\"'#'\'\''#g' | sed -e 's#'\&'#''#g' | \
	sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | sed -e 's#'\ \ '#'\ '#g' | \
	awk -F\@ '{print "\n.PP\n.B " $2 "\n.br\n.SM\n" $4 ": " $5 "\n"}'  >> $MAN_FILE_WORD_LIST
echo ".SH AUTHOR"                              >> $MAN_FILE_WORD_LIST
echo "jan Lope https://jan-lope.github.io"     >> $MAN_FILE_WORD_LIST
if [ ! -f $MAN_FILE_WORD_LIST ]; then
	echo "ERROR"
	exit 1
fi
gzip $MAN_FILE_WORD_LIST
if [ $? != 0  ]; then
	echo "ERROR"
	exit 1
fi
rm -f _build/$MAN_FILE_WORD_LIST.gz
cp $MAN_FILE_WORD_LIST.gz _build/
if [ ! -f _build/$MAN_FILE_WORD_LIST.gz ]; then
	echo "ERROR"
	exit 1
fi
echo "sudo cp $MAN_FILE_WORD_LIST.gz /usr/share/man/man6/"
echo "man toki-pona"
#
###############################################################################
#
echo " "
echo "The generated files are in the directory _build."
ls _build
echo " "
echo "Printing of the booklet: "
echo "Print the odd numbers first."
echo "Put the paper with the script on the top again in the printer."
# echo " "
# echo "end $0"
echo "########################################################################"
# echo " "
###############################################################################
# eof
