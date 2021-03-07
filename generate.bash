#!/bin/bash
TINYTEX_VERSION="2021.03"
PANDOC_VERSION="2.11.4"
TEXDIR="vtex"

# Store working directory for later
ORIGINAL_WD=$(pwd)

# download and extract TinyTeX
TINYTEX_URL="https://github.com/yihui/tinytex-releases/releases/download/v$TINYTEX_VERSION/TinyTeX-0-v$TINYTEX_VERSION"
wget --progress=dot:giga -O TinyTeX.tar.gz ${TINYTEX_URL}.tar.gz

rm -rf $TEXDIR
tar xzf TinyTeX.tar.gz
mv .TinyTeX $TEXDIR
rm TinyTeX.tar.gz

# download and extract pandoc
PANDOC_URL="https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION/pandoc-$PANDOC_VERSION-linux-amd64"
wget --progress=dot:giga -O pandoc.tar.gz ${PANDOC_URL}.tar.gz

tar xzf pandoc.tar.gz pandoc-${PANDOC_VERSION}/bin/pandoc
mv pandoc-${PANDOC_VERSION}/bin/pandoc $TEXDIR/bin/*/
rm -rf ./pandoc-${PANDOC_VERSION}
rm pandoc.tar.gz

# install requred 
cd $TEXDIR/bin/*/
./tlmgr install latex-bin tools kvoptions etoolbox pdftexcmds infwarerr everysel parskip hyperref geometry sectsty ragged2e enumitem fontawesome

# create symlink for pdflatex
ln -s pdftex pdflatex

# package into final archive
cd ${ORIGINAL_WD}
tar -czvf vtex.tar.gz ${TEXDIR}