package Optional::Exports;

use strict;

use base 'Exporter';
use vars '@EXPORT_OK';

@EXPORT_OK = qw( foo bar baz );

sub foo { 'foo' }
sub bar { 'bar' }
sub baz { 'baz' }

1;

