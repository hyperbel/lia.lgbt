#!/bin/sh

OUT_DIR=out

cat head.html.part \
	nav.html.part \
	footer.html.part \
	script.html.part \
	end.html.part > $OUT_DIR/test.html
