OUT_FILE=$1
FILENAME=$2
EXT=".js"
DIR="static/js/"

if [ ! -f $DIR$FILENAME$EXT ]; then
    echo "script $FILENAME$EXT not found"
    exit
fi

echo "<script src=\"$DIR$FILENAME$EXT\"></script>" >> $OUT_FILE
