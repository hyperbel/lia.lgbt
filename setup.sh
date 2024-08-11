#!/bin/sh

OUT_DIR=out
FILENAME=test.html
NAV_FILENAME=nav.html.part
CONTENT_DIR=content


OUT_FILE=$OUT_DIR/$FILENAME

build_nav() {
    CONTENT=$(ls $CONTENT_DIR | awk -F"." '{ print $1 " " }')

	echo '<nav>\n<ul>' > $OUT_DIR/$NAV_FILENAME
	echo '</ul>\n</nav>' >> $OUT_DIR/$NAV_FILENAME
}


build_nav && cat head.html.part \
		$OUT_DIR/$NAV_FILE_NAME > $OUT_FILE

if [ ! -z $2 ]; then
	cat content/$1.html >> $OUT_FILE
fi

cat footer.html.part \
	script.html.part \
	end.html.part >> $OUT_FILE
