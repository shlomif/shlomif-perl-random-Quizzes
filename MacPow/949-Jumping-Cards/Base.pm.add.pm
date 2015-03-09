


sub pack_state
{
    my $self = shift;

    my $state_vector = shift;
    return pack("c*", @$state_vector);
}

sub unpack_state
{
    my $self = shift;
    my $state = shift;
    return [ unpack("c*", $state) ];
}

sub display_state
{
    my $self = shift;
    my $state = shift;
    my $array = $self->unpack_state($state);
    my $plank_lens = $self->{'plank_lens'};
    my $string;
    for my $i (0 .. $#$plank_lens)
    {
        
    }
}
