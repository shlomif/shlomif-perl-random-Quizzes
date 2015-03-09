use strict;
use warnings;

sub m2
{
    my $c = shift;

    my $d = sub {
        my $e = shift;
        return +(ref($e) eq "ARRAY") ? $e->[1] : $e;
    };

    my $f = sub {
        my $e = shift;
        return +(ref($e) eq "ARRAY") ? $e->[0] : 1;
    };
    
    my $g;

    $g = sub {
        my ($h, $i, $j) = @_;

        if (($h == @$c) && ($j == 0))
        {
            return ();
        }
        elsif ($j == 0)
        {
            return $g->($h+1, 
                $d->($c->[$h]),
                $f->($c->[$h])
            );
        }
        else
        {
            return ($i, $g->($h, $i, $j-1));
        }
    };

    return [ $g->(0, 0, 0) ];
}

1;

