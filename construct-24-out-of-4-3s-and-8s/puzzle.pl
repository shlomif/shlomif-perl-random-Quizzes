#!/usr/bin/perl

use strict;
use warnings;

use Math::BigRat;

my $found = 0;
my $wanted = 24;
PERM_LOOP: foreach my $perm (0 .. 15)
{
    my @bits = split(//, sprintf("%04b", $perm));
    {
        my @ones = (grep { $_ eq "1" } @bits);
        if (@ones != 2)
        {
            next PERM_LOOP;
        }
    }
    my @numbers = (map { $_ ? "Math::BigRat->new('3')" : "Math::BigRat->new('8')" } @bits);
    # print "@numbers\n";
    my @ops = qw(+ / - *);

    foreach my $op1 (@ops)
    {
        foreach my $op2 (@ops)
        {
            foreach my $op3 (@ops)
            {
                foreach my $expr (
                   "$numbers[0]$op1($numbers[1]$op2($numbers[2]$op3$numbers[3]))",
                    "(($numbers[0]$op1$numbers[1])$op2($numbers[2]$op3$numbers[3]))",
                )
                {
                    print "$expr\n";
                    my $value = eval($expr);
                    print $value, "\n";
                    if ($value == $wanted)
                    {
                        $found++;
                    }
                }
            }
        }
    }
}

print "Found=$found\n";
