use strict;
use warnings;

use List::MoreUtils (qw(uniq));

our %_t = ();

sub t
{
    my $c = shift;

    if (exists($_t{$c}))
    {
        return $_t{$c};
    }

    no strict 'refs';

    my @h = $c;
    my @d = @{$c. '::ISA'};

    while (my $p = shift(@d))
    {
        push @h, $p;
        push @d, @{$p. '::ISA'};
    }

    my @u = uniq(@h);

    return $_t{$c} =
        [
            sort
            {
                  $a->isa($b) ? -1
                : $b->isa($a) ? +1
                :               0
            }
            @u
        ];
}

sub z
{
    my ($self, $args) = @_;

    my $mn = $args->{mn};

    my $c = ((ref($self) eq "") ? $self : ref($self));

    my $h= t($c);

    my @r;
    foreach my $i (@$h)
    {
        no strict 'refs';
        my $m = ${$i . "::"}{$mn};
        if (defined($m))
        {
            push @r, @{$m->($self)};
        }
    }
    return \@r;
}

