#!/usr/bin/perl

use strict;
use warnings;

# N(a,b) = (a+b,b)
# D(a,b) = (a,a+b)

sub decompose
{
    my ($a1, $b1) = @_;

    if (($a1 == 1) && ($b1 == 1))
    {
        return [];
    }
    elsif ($a1 > $b1)
    {
        return [@{decompose($a1-$b1,$b1)}, "N"];
    }
    else
    {
        return [@{decompose($a1,$b1-$a1)}, "D"];
    }
}

my ($x, $y) = @ARGV;
print join("->", @{decompose($x,$y)}), "\n";

