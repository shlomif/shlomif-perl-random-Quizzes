package Shlomif::LMSolver::Jumping::Cards;

use strict;

use Shlomif::LMSolver::Base;

use vars qw(@ISA);

@ISA=qw(Shlomif::LMSolver::Base);

my %cell_dirs =
    (
        'N' => [0,-1],
        'S' => [0,1],
        'E' => [1,0],
        'W' => [-1,0],
    );

sub input_board
{
    my $self = shift;

    my $filename = shift;

    return [ 1 .. 8 ];
}

# A function that accepts the expanded state (as an array ref)
# and returns an atom that represents it.
sub pack_state
{
    my $self = shift;
    my $state_vector = shift;
    return join("", @$state_vector);
}

# A function that accepts an atom that represents a state
# and returns an array ref that represents it.
sub unpack_state
{
    my $self = shift;
    my $state = shift;
    return [ split(//, $state) ];
}

# Accept an atom that represents a state and output a
# user-readable string that describes it.
sub display_state
{
    my $self = shift;
    my $state = shift;
    return join(",", split(//, $state));
}

# This function checks if a state it receives as an argument is a
# dead-end one.
sub check_if_unsolveable
{
    # One can always proceed from here.
    return 0;
}

sub check_if_final_state
{
    my $self = shift;

    my $coords = shift;
    return join("", @$coords) eq "87654321";
}

# This function enumerates the moves accessible to the state.
# If it returns a move, it still does not mean that it is a valid
# one. I.e: it is possible that it is illegal to perform it.
sub enumerate_moves
{
    my $self = shift;

    my $state = shift;

    my (@moves, @new);
    @new = @$state;
    for my $i (0 .. 6)
    {
        for my $j (($i+1) .. 7)
        {
            @new[$i,$j]=@new[$j,$i];
            unless (grep { abs($new[$_]-$new[$_+1]) > 3 } (0 .. 6))
            {
                push @moves, $i.$j;
            }
            @new[$j,$i]=@new[$i,$j];
        }
    }
    return @moves;
}

# This function accepts a state and a move. It tries to perform the
# move on the state. If it is succesful, it returns the new state.
#
# Else, it returns undef to indicate that the move is not possible.
sub perform_move
{
    my $self = shift;

    my $state = shift;
    my $m = shift;

    my @new = @$state;

    my ($i,$j) = split(//, $m);
    @new[$i,$j]=@new[$j,$i];
    return \@new;
}

sub render_move
{
    my $self = shift;

    my $move = shift;

    return join(" <=> ", split(//,$move));
}
1;

