#!/usr/bin/perl -w

use strict;

my @funcs = (qw(foo bar baz));

for my $bit_mask (0 .. (2**@funcs-1))
{
    my @bits = map { (($bit_mask >> $_) & 0x1) } (0 .. $#funcs);
    my $filename = 
        sprintf("%.2i", $bit_mask) . 
            join("-", map { ($bits[$_] ? "" : "no") . $funcs[$_] } (0 .. $#funcs));
    my $num_tests = 0;
    foreach(@bits)
    {
        $num_tests += $_ ? 2 : 1;
    }
    open O, ">t/$filename.t";
    print O <<"EOF";
#!/usr/bin/perl

use strict;
use warnings;

package Hello;

use Test::More tests => $num_tests;
EOF

    if ($bit_mask)
    {
        print O "use Optional::Exports qw(" . 
            join(" ", map { $bits[$_] ? ($funcs[$_]) : () } (0 .. $#funcs)). 
                ");" . "\n";
    }
    else
    {
        print O "use Optional::Exports;\n";
    }
    
    for my $f_idx (0 .. $#funcs)
    {
        my $func_name = $funcs[$f_idx];
        if ($bits[$f_idx])
        {
            print O "# TEST\n";
            print O "ok(exists(\${Hello::}{'$func_name'}), \"Checking for existence of $func_name\");\n";
            print O "# TEST\n";
            print O "ok((\${Hello::}{'$func_name'}->() eq \"$func_name\"), \"Checking for $func_name return code\");\n";
        }
        else
        {
            print O "# TEST\n";
            print O "ok(!exists(\${Hello::}{'$func_name'}),\"Checking for in-existence of $func_name\");\n";
        }
    }
    close(O);
}

1;

