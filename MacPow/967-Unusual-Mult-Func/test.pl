#!/usr/bin/perl -w

use strict;

sub get_factors
{
    my $n = shift;

    my (@factors);
    my $exp;
    for(my $p=2;$n > 1;$p++)
    {
        if ($n % $p == 0)
        {
            $exp = 0;
            while($n % $p == 0)
            {
                $exp++;
                $n /= $p;
            }
            push @factors, { 'p' => $p, 'e' => $exp };
        }
    }

    return \@factors;
}

use Data::Dumper;

my (@numbers);
my $max_n;

$numbers[2]->{'v'} = 2;

foreach $max_n (3 .. 1000)
{
    my $factors = get_factors($max_n);
    $numbers[$max_n] =
        {
            'factors' => $factors,
        };

    if (@$factors == 1)
    {
        next;
    }
    my $num_value = 1;
    my @coeffs;
    for(my $f_idx = 0;$f_idx < @$factors ; $f_idx++)
    {
        my $num;
        my $fact = $factors->[$f_idx];
        $num = $fact->{'p'} ** $fact->{'e'};
        if (exists($numbers[$num]->{'v'}))
        {
            $num_value *=  $numbers[$num]->{'v'};
        }
        else
        {
            push @coeffs, $num;
        }
    }
    if (scalar(@coeffs) == 0)
    {
        $numbers[$max_n]->{'v'} = $num_value;
        next;
    }
    if (@coeffs == 1)
    {
        my $c = 2;

    }
}



