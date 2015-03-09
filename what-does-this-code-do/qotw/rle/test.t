use strict;
use warnings;

use Test::More tests => 8;

use MyModule;

sub r2_test
{
    local $Test::Builder::Level = $Test::Builder::Level + 1;    
    
    my ($name, $out, $in) = @_;

    return is_deeply(
        m2($in),
        $out,
        "Deeply for $name"
    );
}

sub r3
{
    my $a_ref = shift;

    return [map { 
        ref($_) eq "ARRAY"
            ? (($_->[1]) x $_->[0])
            : ($_)
        } @$a_ref
        ];
}

# TEST
r2_test ("null", [], []);
# TEST
r2_test ("single", ['a'], ['a']);
# TEST
r2_test ("two-diff", ['a','b'], ['a','b']);
# TEST
r2_test ("dup2", ['a', 'a'], [[2,'a']]);
# TEST
r2_test ("dup3", [qw(a a a)], [[qw(3 a)]]);
# TEST
r2_test ("aaab", [qw(a a a b)], [[qw(3 a)], 'b']);
# TEST
r2_test ("aaabba", [qw(a a a b b a)], [[qw(3 a)], [qw(2 b)], 'a']);
# TEST
r2_test ("grand-finale", 
    [qw(a a a a b c c a a d e e e e)],
    [[qw(4 a)], 'b', [qw(2 c)], [qw(2 a)], 'd', [qw(4 e)]],
);

