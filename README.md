# Toki Pona - Lessons in English
Unlike Esperanto, Toki Pona is a constructed language that favors simplicity over clarity, and touts itself as "the language of good. The simple way of life." 

These lessons are based on the offical Toki Pona book of Sonja Lang ( [tokipona.org](http://tokipona.org) ) 
and the lessons of jan Pije ( [tokipona.net/tp/janpije](http://tokipona.net/tp/janpije/) ). 

## Generated PDF, HTML and TXT Files

### Lessons

[toki-pona-lessons_en.pdf](https://github.com/jan-Lope/Toki_Pona_lessons_English/blob/gh-pages/toki-pona-lessons_en.pdf) Generated Book (A4)  
Use the button "Download". If you get an error 404, please press the "shift" key and the "reload" button in your browser.

[toki-pona-lessons_de-booklet.pdf](https://github.com/jan-Lope/Toki_Pona_lessons_English/blob/gh-pages/toki-pona-lessons_en-booklet.pdf) Generated Booklet (A5). 
Use the button "Download". If you get an error 404, please press the "shift" key and the "reload" button in your browser.
Print first the odd numbers. After this put the paper again in the printer and print the even pages.

[HTML](https://htmlpreview.github.io/?https://raw.githubusercontent.com/jan-Lope/Toki_Pona_lessons_English/gh-pages/toki-pona-lessons_en/index.html) Generated Online version
If you get an error 404, please press the shift key and the reload button in your browser.

### Dictionary

[Toki Pona - English Dictionary](https://htmlpreview.github.io/?https://raw.githubusercontent.com/jan-Lope/Toki_Pona_lessons_English/gh-pages/dictionary.html) Generated Online version

[toki-pona_english.txt](https://github.com/jan-Lope/Toki_Pona_lessons_English/blob/gh-pages/toki-pona_english.txt) Generated text file for the software [ding](http://www-user.tu-chemnitz.de/~fri/ding/).

![ding](ding01.png?raw=true "ding")

![ding](ding02.png?raw=true "ding")

![ding](ding03.png?raw=true "ding")


### Source Codes

The PDF, HTML and TXT Files are generated from the Latex files per [travis-ci.org](https://travis-ci.org/jan-Lope/Toki_Pona_lessons_English).

You can see the source code in [Github](https://github.com/jan-Lope/Toki_Pona_lessons_English).

### Build by Hand

You can build the PDF, HTML and TXT Files under Ubuntu. You need these software:


    sudo apt-get install texlive texlive-base texlive-latex-base texlive-extra-utils texlive-binaries texlive-extra-utils texlive-font-utils texlive-pictures texlive-pstricks texlive-latex-extra 
    sudo apt-get install latex2html latex-xcolor npm nodejs coffeescript


Download the source code in a directory and change to this directory. After this you start this script Script:


    ./make.sh




[jan Lope](https://jan-lope.github.io)
