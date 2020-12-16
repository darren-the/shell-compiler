#!/bin/sh
# Make sure assignments to other variables aren't treated as strings!

echo "#!/bin/sh

a=10
b=\$a
echo \"\$a \$b\"

" > tmp.sh
./sheeple.pl tmp.sh > tmp.pl
chmod u+x tmp.sh
chmod u+x tmp.pl
./tmp.sh > sh_out.txt
./tmp.pl > pl_out.txt
diff sh_out.txt pl_out.txt
