package Basic::Exports;

use strict;

use base 'Exporter';
use vars '@EXPORT';

@EXPORT = qw( foo bar );

sub foo { 'foo' }
sub bar { 'bar' }

1;


