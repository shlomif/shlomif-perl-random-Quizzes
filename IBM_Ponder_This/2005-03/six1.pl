use SixBit;

for my $vec (@six_bit_sigs)
{
    print $vec->[0] . ":" . join(",",@{$vec->[1]}) . "\n";
}
1;
