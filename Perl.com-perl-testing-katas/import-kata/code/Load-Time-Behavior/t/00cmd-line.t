#!/usr/bin/perl -w

use strict;

use Test::More tests => 1;

require Export::Weird;

open(SAVEOUT, ">&STDOUT");
pipe(ALTOUT_READ, ALTOUT);
open(STDOUT, ">&ALTOUT");
#line 0
Export::Weird::import();
open(STDOUT, ">&SAVEOUT");
close(ALTOUT);
my $printed = join("", <ALTOUT_READ>);
# TEST
is($printed, "Invoked from command-line\n",
    "Testing for command-line behavior.");

# Just to settle -w
close(SAVEOUT);
close(ALTOUT_READ);

