#!/usr/bin/perl

use strict;
use warnings;

package Hello;

use Test::More tests => 4;
use Optional::Exports qw(baz);
# TEST
ok(!exists(${Hello::}{'foo'}),"Checking for in-existence of foo");
# TEST
ok(!exists(${Hello::}{'bar'}),"Checking for in-existence of bar");
# TEST
ok(exists(${Hello::}{'baz'}), "Checking for existence of baz");
# TEST
ok((${Hello::}{'baz'}->() eq "baz"), "Checking for baz return code");
