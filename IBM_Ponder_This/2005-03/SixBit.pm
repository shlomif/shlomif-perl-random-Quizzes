
use strict;
use warnings;

sub get_nth_bit
{
    my $n = shift;
    my $p = shift;
    return (($n >> $p) & 0x1);
}

sub bits_to_num
{
    my $vec = shift;
    my $e = 1;
    my $sum = 0;
    for my $bit (@$vec)
    {
        $sum += $bit*$e;
        $e *= 2;
    }
    return $sum;
}

sub enum_vectors
{
    my @ret;
    for my $n (0 .. (2**6-1))
    {
        my @bits = (map { get_nth_bit($n, $_) } (0 .. 5));
        my @r_bits = reverse(@bits);
        my $r_n = bits_to_num([@r_bits]);
        if ($r_n == $n)
        {
            push @ret, [0, [@bits]];
        }
        elsif ($r_n > $n)
        {
            push @ret, [1, [@bits]];
        }
    }
    return \@ret;
}

# @six_bit_sigs contain [0,[@palindrome]] or [1,[@non_palin]]
our @six_bit_sigs = @{enum_vectors()};

our @square_perms = ();

sub enum_squares
{
    # my @ret;
    my $recurser;

    $recurser = sub {
        my $prevs = shift;
        my $which_allocated = shift;

        if (@$prevs == 6)
        {
            # Check to see if this is a valid solution.
            my @table = (map { my @v = @{$six_bit_sigs[$_->[1]][1]}; [ $_->[0] ? reverse(@v) : @v ] } @$prevs);
            my @columns =
                (map 
                    { 
                        my $n = $_; 
                        [map { $table[$_][$n] } (0 .. 5) ];
                    }
                    (0 .. 5)
                );
            my %exists;
            my $ok = 1;
            LOOP: foreach my $c (@columns)
            {
                my $n1 = bits_to_num($c);
                my $n2 = bits_to_num([ reverse(@$c) ]);
                if ((!exists($exists{$n1})) && (!exists($exists{$n2})))
                {
                    $exists{$n1} = 1;
                    $exists{$n2} = 1;
                }
                else
                {
                    $ok = 0;
                    last LOOP;
                }
            }
            if ($ok)
            {
                push @square_perms, [@$prevs];
                print "New Perm: (" . join(",", map{$_->[1]}@$prevs). ")\n";
                for my $vec (@$prevs)
                {
                    my @v = @{$six_bit_sigs[$vec->[1]][1]}; 
                    if ($vec->[0])
                    {
                        @v = reverse(@v);
                    }
                    print join(",",@v) . "\n";
                }
                print "\n";
            }
        }
        else
        {
            for my $n (0 .. $#six_bit_sigs)
            {
                if (!$which_allocated->[$n])
                {
                    my @new_alloc = @$which_allocated;
                    $new_alloc[$n] = 1;
                    for my $dir (0 .. $six_bit_sigs[$n]->[0])
                    {
                        $recurser->(
                            [@$prevs, [$dir,$n]], \@new_alloc
                        );
                    }
                }
            }
        }
    };
    
    $recurser->([], [(0) x 36]);

    
}

1;
