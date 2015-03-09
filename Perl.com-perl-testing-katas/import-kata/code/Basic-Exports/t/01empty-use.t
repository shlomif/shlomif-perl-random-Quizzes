#!/usr/bin/perl -w

use strict;

package Hello;

use Test::More tests => 2;

use Basic::Exports ();

# TEST
ok(!exists(${Hello::}{'foo'}),"Checking for in-existence of foo");

# TEST
ok(!exists(${Hello::}{'bar'}),"Checking for in-existence of bar");


