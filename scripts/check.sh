R CMD build . && R CMD check $(ls -t . | head -n1)
