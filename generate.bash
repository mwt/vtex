#!/bin/bash
TINYTEX_VERSION="2023.03"
TEXDIR="vtex"

# Store working directory for later
ORIGINAL_WD=$(pwd)

# download and extract TinyTeX

TINYTEX_URL="https://github.com/rstudio/tinytex-releases/releases/download/v$TINYTEX_VERSION/TinyTeX-0-v$TINYTEX_VERSION"
wget --progress=dot:giga -O TinyTeX.tar.gz ${TINYTEX_URL}.tar.gz

rm -rf $TEXDIR
tar xzf TinyTeX.tar.gz
mv .TinyTeX $TEXDIR
rm TinyTeX.tar.gz

# install requred 
cd $TEXDIR/bin/*/
./tlmgr install latex-bin tools kvoptions etoolbox pdftexcmds infwarerr everysel parskip hyperref geometry sectsty ragged2e enumitem fontawesome markdown fontspec paralist amsmath amsfonts csvsimple fancyvrb pgf

# create symlink for pdflatex
ln -s pdftex pdflatex

# package into final archive
cd ${ORIGINAL_WD}
tar -czvf vtex.tar.gz ${TEXDIR}
