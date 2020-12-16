#!/bin/sh
# Can it distinguish functions from variable names?

echo "#!/bin/sh

echo_variable=\"This isn't echo!\"
exit_variable=\"This isn't exit!\"
read_variable=\"This isn't read!\"
echo \$echo_variable
echo \$exit_variable
echo \$read_variable
" > tmp.sh
./sheeple.pl tmp.sh > tmp.pl
chmod u+x tmp.sh
chmod u+x tmp.pl
./tmp.sh > sh_out.txt
./tmp.pl > pl_out.txt
diff sh_out.txt pl_out.txt
