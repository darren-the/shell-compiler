#!/bin/sh
# Can it parse a conditional statement correctly?

echo "#!/bin/sh

if test \"=\" = \"=\"
then
    echo \"Its equal!\"
fi
" > tmp.sh
./sheeple.pl tmp.sh > tmp.pl
chmod u+x tmp.sh
chmod u+x tmp.pl
./tmp.sh > sh_out.txt
./tmp.pl > pl_out.txt
diff sh_out.txt pl_out.txt
