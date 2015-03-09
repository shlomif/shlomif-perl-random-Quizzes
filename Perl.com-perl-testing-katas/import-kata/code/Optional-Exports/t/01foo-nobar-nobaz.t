#!/usr/bin/perl

use strict;
use warnings;

package Hello;

use Test::More tests => 4;
use Optional::Exports qw(foo);
# TEST
ok(exists(${Hello::}{'foo'}), "Checking for existence of foo");
# TEST
ok((${Hello::}{'foo'}->() eq "foo"), "Checking for foo return code");
# TEST
ok(!exists(${Hello::}{'bar'}),"Checking for in-existence of bar");
# TEST
ok(!exists(${Hello::}{'baz'}),"Checking for in-existence of baz");
