#!/bin/sh

OUT_DIR=out
FILENAME=test.html
NAV_FILENAME=nav.html.part
CONTENT_DIR=content


OUT_FILE=$OUT_DIR/$FILENAME

build_nav() {
    CONTENT=$(ls $CONTENT_DIR | awk -F"." '{ print $1 " " }')

	echo -e \\t\<nav\>\\n\\t\\t\<ul\> > $OUT_DIR/$NAV_FILENAME
	for value in ${CONTENT[@]}
	do
		echo -e "\t\t\t<li\><a href="/$value.html"\>$value</a\></li\>" >> $OUT_DIR/$NAV_FILENAME
	done
	echo -e \\t\\t\</ul\>\\n\\t\</nav\> >> $OUT_DIR/$NAV_FILENAME
}


build_nav && cat head.html.part \
		$OUT_DIR/$NAV_FILENAME > $OUT_FILE

if [ ! -z $2 ]; then
	cat content/$1.html >> $OUT_FILE
fi

cat footer.html.part \
	script.html.part \
	end.html.part >> $OUT_FILE
