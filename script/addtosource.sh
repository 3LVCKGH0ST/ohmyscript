#! /bin/bash

SCRDIR="$PWD"

cat ~/.zshrc | grep -q 'ohmyscript' && echo -n "" || echo "make -C $SCRDIR" >> ~/.zshrc 
cat ~/.zshrc | grep -q 'chiblassa' && echo -n "" || echo -e "\nalias chiblassa=\"$SCRDIR/chiblassa.sh\"\n" >> ~/.zshrc;
cat token | grep -q "XXXXX" && echo -n "Add your token please !" || cat token > mytoken