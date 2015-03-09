#!/usr/bin/perl -w

use strict;

my (@values, @sources);

$values[1] = 2;
$sources[2] = 1;

sub assign
{
    my $s = shift;
    my $v = shift;
    $values[$s] = $v;
    $sources[$v] = $s;

    return 0;
}

for(my $n=1;$n<=955;$n++)
{
    if (defined($values[$n]))
    {
        print "f($n) = $values[$n]\n";
        &assign($values[$n], 3*$n);
    }
    else
    {
        my $defined_n = $n;
        while(!defined($values[$defined_n]))
        {
            $defined_n++;
        }
        if ($values[$defined_n]-$values[$n-1] == $defined_n-($n-1))
        {
            print "Interpolating from $n to $defined_n\n";
            my $v = $values[$n-1];
            for my $i ($n .. ($defined_n-1))
            {
                &assign($i, ++$v);
            }
            redo;
        }
        else
        {
            die "Cannot fill value for $n\n";
        }
    }
}
