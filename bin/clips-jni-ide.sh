#!/bin/sh

CLIPSJNI=/opt/CLIPSJNI
exec java -Djava.library.path=$CLIPSJNI -jar $CLIPSJNI/CLIPSIDE.jar

