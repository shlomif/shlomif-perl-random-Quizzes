package Export::Weird;

use strict;

sub import
{
    my ($package, undef, $line) = caller();

    if ( $line == 0 )
    {
        print "Invoked from command-line\n";
    }
    else
    {
        no strict 'refs';
        *{ $package . '::foo' } = sub { 'foo' };
    }
}

1;

