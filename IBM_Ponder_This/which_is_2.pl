#!/usr/bin/perl -w

use strict;

my $num_vecs = 4;
my @tags = ([-1,-1],[1,1],[-1,1],[1,-1]);
# my @tags = ([-1,-1],[1,1],[1,-1],[-1,1]);

my @value_mods = map { [0,0] } (1 .. $num_vecs);
my $first_time = 1;

sub vec2str
{
    my $vec = shift;
    return join(",", map { sprintf("%2s", $_) } @$vec);
}

while (1)
{
    my ($i, $j);
    my $limit = $num_vecs * 2;
    my $set_value_mod = sub {
        my $val = shift;
        $value_mods[$i>>1][$i&0x1] = $val;
    };
    if (! $first_time)
    {
        for($i=0;$i<$limit;$i++)
        {
            if ($value_mods[$i>>1][$i & 0x1] == 0)
            {
                $set_value_mod->(1);
                last;
            }
            else
            {
                $set_value_mod->(0);
            }
        }
        if ($i == $limit)
        {
            last;
        }
    }
    $first_time = 0;
    # print join("-",@value_mods_proto), "\n";
    my @vecs = map { my $i = $_; [ map { $tags[$i][$_] * $value_mods[$i][$_] } (0 .. 1)] } (0 .. ($num_vecs-1));
    
    my @coeffs = (0,0,0,0);
    while(1)
    {
        for($i=0;$i<$num_vecs;$i++)
        {
            if ($coeffs[$i] == 0)
            {
                $coeffs[$i] = 1;
                last;
            }
            else
            {
                $coeffs[$i] = 0;
            }            
        }
        if ($i == $num_vecs)
        {
            print "This Configuration can only be solved with (x,y,2):\n";
            foreach my $j (0 .. 3)
            {
                print "T[$j] = " . vec2str($tags[$j]) . "   " .
                      "V[$j] = " . vec2str($vecs[$j]) . "\n";
            }
            # print join("\n", map { join("-",@$_) } @value_mods), "\n";
            last;
        }
        if ($coeffs[1] && $coeffs[3])
        {
            next;
        }
        my @sum = (0,0);
        for $i (0 .. ($num_vecs-1))
        {
            next if (!$coeffs[$i]);
            for $j (0 .. 1)
            {
                $sum[$j] += $vecs[$i]->[$j];
            }
        }
        # print "Sum = " . join(",", @sum), "\n";
        if (($sum[0] == 0) && ($sum[1] == 0))
        {
            # print "That Conf:\n";
            last;
        }
    }
}


