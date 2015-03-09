package Foo;

use strict;

sub foo
{
    my $in1 = shift;
    my @s = split(//, $in1);
    my @ret;
    my $i = 0;
    while(($i < @s) && ($s[$i] ne ':'))
    {
        push @ret, $s[$i++];
    }
    if ($s[$i] eq ':')
    {
        push @ret, $s[$i++];
        while ($s[$i] eq '/')
        {
            push @ret, $s[$i++];
        }
        while ($i < @s)
        {
            push @ret, $s[$i];
            if (($s[$i] eq '/') && ($i+1 < @s) && ($s[$i+1] eq '/'))
            {
                $i++;
                while (($i < @s) && ($s[$i] eq '/'))
                {
                    $i++;
                }
            }
            else
            {
                $i++;
            }
        }
    }
    return join("", @ret);
}

1;

