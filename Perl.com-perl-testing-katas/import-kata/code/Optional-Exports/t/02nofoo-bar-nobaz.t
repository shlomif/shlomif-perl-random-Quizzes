#!/usr/bin/perl

use strict;
use warnings;

package Hello;

use Test::More tests => 4;
use Optional::Exports qw(bar);
# TEST
ok(!exists(${Hello::}{'foo'}),"Checking for in-existence of foo");
# TEST
ok(exists(${Hello::}{'bar'}), "Checking for existence of bar");
# TEST
ok((${Hello::}{'bar'}->() eq "bar"), "Checking for bar return code");
# TEST
ok(!exists(${Hello::}{'baz'}),"Checking for in-existence of baz");
