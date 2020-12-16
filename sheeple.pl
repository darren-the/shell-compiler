#!/usr/bin/perl -w

sub trim {
    $str = $_[0];
    $str =~ s/^\s+//;
    $str =~ s/\s+$//;
    return $str;
}

while ($line = <>) {

    if ($line =~ /#!/) {
        # Interpreter
        $perl_line = "#!/usr/bin/perl -w\n";

    } elsif ($line =~ /^ *ls/ | $line =~ /^ *pwd/ | $line =~ /^ *id/ | $line =~ /^ *date/) {
        # Some built in functions
        chomp $line;
        $perl_line = "system \"$line\";\n";

    } elsif ($line =~ /^( *((|el)if|while) test.*)$/) {
        # If/elif statements as well as while loops
        @fields = split(/ test /, $line);
        $if = $fields[0] =~ s/elif/} elsif/r;
        $condition = $fields[1];
        chomp $condition;

        if ($condition =~ /(\".*?\"|\$.*?|.*?) (.*?) (\".*?\"|\$.*|.*?)$/) {
            # Parsing conditional statement
            $var1 = $1;
            $equality = $2;
            $var2 = $3;
            if ($var1 !~ /(\".*\"|^\$)/) {
                $var1 = "\"$var1\"";
            }
            if ($var2 !~ /(\".*\"|^\$)/ & $var2 !~ /^\d+$/) {
                $var2 = "\"$var2\"";
            }

            # Equality signs
            if ($equality eq "=") {
                $equality = "eq";
            } elsif ($equality eq "!=") {
                $equality = "ne";
            } elsif ($equality eq "-eq") {
                $equality = "==";
            } elsif ($equality eq "-ne") {
                $equality = "!=";
            } elsif ($equality eq "-lt") {
                $equality = "<";
            } elsif ($equality eq "-gt") {
                $equality = ">";
            } elsif ($equality eq "-le") {
                $equality = "<=";
            } elsif ($equality eq "-ge") {
                $equality = ">=";
            }
            
            $perl_line = "$if ($var1 $equality $var2) {\n";
        } else {
            $perl_line = "$if ($condition) {\n";
        }
    } elsif ($line =~ /^ *?else/) {
        # Else 
        chomp $line;
        $line = $line =~ s/else/} else {/r;
        $perl_line = "$line\n";

    } elsif ($line =~ /^ *echo/) {
        # Echo
        @fields = split(/echo /, $line);
        chomp $fields[1];
        $perl_value = $fields[1] =~ s/^("|')//r =~ s/("|')$//r;
        $perl_value = $perl_value =~ s/"/\\\"/rg =~ s/'/\\\'/rg;
        $perl_line = "$fields[0]print \"$perl_value\\n\";\n";

    } elsif ($line =~ /^ *for/) {
        # For loops
        @fields = split(/ in /, $line);
        $for_var = $fields[0] =~ s/for /foreach \$/r;
        chomp $fields[1];
        if ($fields[1] !~ /^\$/ & $fields[1] !~ /^".*"$/) {
            $fields[1] = "glob(\"$fields[1]\")";
        }
        $perl_line = "$for_var ($fields[1]) {\n"
    } elsif ($line =~ /^ *exit/) {
        # Exit
        chomp $line;
        $perl_line = "$line;\n";
    } elsif ($line =~ /^ *read/) {
        # Read
        @fields = split(/read /, $line);
        chomp $fields[1];
        $perl_line = "$fields[0]\$$fields[1] = <STDIN>;\nchomp \$$fields[1];\n";

    } elsif ($line =~ /^ *cd/) {
        # cd
        @fields = split(/cd /, $line);
        chomp $fields[1];
        $perl_line = "chdir \'$fields[1]\';\n";

    } elsif ($line =~ /=/) {
        # Assignments
        @fields = split(/=/, $line, 2);
        chomp $fields[1];
        if ($fields[1] =~ /^\$/) {
            # Assignment to variable
            
        }
        elsif ($fields[1] =~ /`expr.*`/) {
            # Assignment to expr
            $fields[1] = $fields[1] =~ s/`expr //r =~ s/`//r;
        } elsif ($fields[1] !~ /^[0-9]$/ & $fields[1] !~ /(^".*"$|^'.*'$)/) {
            # Assignment to string
            $fields[1] = "\'$fields[1]\'";
        } 
        
        $fields[0] =~ /(\S)/;
        $var = $1;
        $fields[0] = $fields[0] =~ s/$var/\$$var/r;
        $perl_line = "$fields[0] = $fields[1];\n";

    } elsif ($line =~ /^ *do$/ | $line =~ /^ *then$/) {
        next;
    } elsif ($line =~ /^ *(done)$/ | $line =~ /^ *(fi)$/) {
        $perl_line = $line=~ s/$1/}\n/r;
    } else {
        $perl_line = $line;
    }

    # Handling args
    while ($perl_line =~ /\$(\d)/) {
        $i = $1 - 1;
        $perl_line = $perl_line =~ s/\$[0-9]/\$ARGV[$i]/r;
    }
    if ($perl_line =~ /\$@/) {
        $perl_line = $perl_line =~ s/\$@/\@ARGV/rg
    }
    print $perl_line;
}
