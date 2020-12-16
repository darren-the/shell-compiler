#!/bin/dash
# Can it handle more than one arg in a single line

echo "#!/bin/sh

echo \"\$1 \$2 \$3\"

" > tmp.sh
./sheeple.pl tmp.sh > tmp.pl
chmod u+x tmp.sh
chmod u+x tmp.pl
./tmp.sh arg1 arg2 arg3 > sh_out.txt
./tmp.pl arg1 arg2 arg3 > pl_out.txt
diff sh_out.txt pl_out.txt
