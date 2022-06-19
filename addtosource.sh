#! /bin/bash

cat ~/.zshrc | grep -q 'ohmyscript' && echo -n "" || echo "make -C $HOME/Desktop/ohmyscript/" >> ~/.zshrc 
cat ~/.zshrc | grep -q 'chiblassa' && echo -n "" || echo -e "\nalias chiblassa=\"$HOME/Desktop/ohmyscript/chiblassa.sh\"\n" >> ~/.zshrc;
