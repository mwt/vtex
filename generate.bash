#!/bin/bash
TINYTEX_VERSION="2023.03"
TEXDIR="vtex"

# Store working directory for later
ORIGINAL_WD="$(pwd)"

TINYTEX_URL="https://github.com/rstudio/tinytex-releases/releases/download/v$TINYTEX_VERSION/TinyTeX-0-v$TINYTEX_VERSION"

# download and extract TinyTeX
rm -rf "$TEXDIR"
wget --progress=dot:giga -O- "${TINYTEX_URL}.tar.gz" | tar -xzC "./"
mv ".TinyTeX" "$TEXDIR"

# install requred
cd $TEXDIR/bin/*/
./tlmgr install latex-bin tools kvoptions etoolbox pdftexcmds infwarerr everysel parskip hyperref geometry sectsty ragged2e enumitem fontawesome markdown fontspec paralist amsmath amsfonts csvsimple fancyvrb pgf gobble epstopdf-pkg

# generate font names database for lualatex (speedup generation later)
./luaotfload-tool --update && echo "LuaLaTeX font database generated (exit: $?)" || echo "LuaLaTeX font database generation failed (exit: $?)"

# package into final archive
cd "${ORIGINAL_WD}"
tar -czf "vtex.tar.gz" "${TEXDIR}" && echo "vtex.tar.gz generated (exit: $?)" || echo "vtex.tar.gz generation failed (exit: $?)"
