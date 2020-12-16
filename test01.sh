#!/bin/sh
# Testing the handle of several scenarios with imbedded double quotes and backslashes

echo "#!/bin/sh

echo \"hello there\"
echo \"hello\" \"there\"
echo \"hello\\" \\"there\"
echo \"hello\\\" \\\"there\"
" > tmp.sh
./sheeple.pl tmp.sh > tmp.pl
chmod u+x tmp.sh
chmod u+x tmp.pl
./tmp.sh > sh_out.txt
./tmp.pl > pl_out.txt
diff sh_out.txt pl_out.txt
