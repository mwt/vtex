# vTeX

## Tiny pandoc and TeX for CI

This is a minimal (about 63MB) version of LaTeX I created so that I can regenerate my resume automatically from markdown using continuous integration. The repository consists of a single bash file. This file downloads the `0` (minimal) version of [`TinyTeX`](https://yihui.org/tinytex/) and [`pandoc`](https://pandoc.org/). It then installs the particular packages that I personally need for my markdown documents.

These packages can be changed on line 29 of `generate.bash`.

The basic usage is to download and extract the release on your continuous integration system
```
wget -O vtex.tar.gz -nv "https://github.com/mwt/vtex/releases/download/v1.0/vtex.tar.gz"
tar xzf vtex.tar.gz
```
and then run `pandoc`. For example:
```{bash}
./vtex/bin/x86_64-linux/pandoc resume.md -t latex --pdf-engine="./vtex/bin/x86_64-linux/pdflatex" --template="./_latex/resume-template.latex" -o "./assets/resume.pdf"
```

This package has been tested on [vercel](https://vercel.com) and [GitHub Actions](https://github.com/features/actions). You may need to install `wget` or `curl` on your CI system to download it.

This is currently being used on the [repository for my website](https://github.com/mwt/mattwthomas.com).  You can see how it is used in [my install script](https://github.com/mwt/mattwthomas.com/blob/master/_bash/install.sh) and [my build script](https://github.com/mwt/mattwthomas.com/blob/master/_bash/build.sh).