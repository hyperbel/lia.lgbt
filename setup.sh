#!/bin/sh

OUT_DIR=lia.lgbt-out
FILENAME=index.html
NAV_FILENAME=nav.html.part
CONTENT_DIR=content
STRUCTURE_DIR=structure
STATIC_DIR=static


OUT_FILE=$OUT_DIR/$FILENAME

if [ ! -d "$OUT_DIR" ]; then
    mkdir $OUT_DIR
fi

if [ ! -z $1 ]; then
    if [ ! -f $CONTENT_DIR/$1.html ]; then
        echo "file $1.html not found"
        exit 1
    fi
fi

if [ ! -z $1 ]; then
	echo "input file: $1"
	OUT_FILE=$OUT_DIR/$1.html
fi

echo "output file: $OUT_FILE"

CONTENT=$(ls $CONTENT_DIR | awk -F"." '{ print $1 " " }')

build_nav() {
	echo -e \\t\<nav\>\\n\\t\\t\<ul\> > $STRUCTURE_DIR/$NAV_FILENAME
	for value in ${CONTENT[@]}
	do
		echo -e "\t\t\t<li\><a href="/$value.html"\>$value</a\></li\>" | sed 's/\\>/>/g' >> $STRUCTURE_DIR/$NAV_FILENAME
	done
	echo -e \\t\\t\</ul\>\\n\\t\</nav\> >> $STRUCTURE_DIR/$NAV_FILENAME
}



build_nav && cat $STRUCTURE_DIR/head.html.part \
		$STRUCTURE_DIR/$NAV_FILENAME > $OUT_FILE

if [ ! -z $1 ]; then
	cat content/$1.html >> $OUT_FILE
fi

cat $STRUCTURE_DIR/footer.html.part >> $OUT_FILE
if [ ! -z $1 ]; then
    . ./scripts.sh $OUT_FILE $1
fi

cat $STRUCTURE_DIR/script.html.part >> $OUT_FILE
cat $STRUCTURE_DIR/end.html.part >> $OUT_FILE

cp -rf $STATIC_DIR $OUT_DIR/

if [ ! -z $1 ]; then
    firefox $OUT_FILE >> /dev/null &
    disown -a
fi
