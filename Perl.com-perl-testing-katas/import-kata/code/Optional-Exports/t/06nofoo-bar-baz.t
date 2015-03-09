#!/usr/bin/perl

use strict;
use warnings;

package Hello;

use Test::More tests => 5;
use Optional::Exports qw(bar baz);
# TEST
ok(!exists(${Hello::}{'foo'}),"Checking for in-existence of foo");
# TEST
ok(exists(${Hello::}{'bar'}), "Checking for existence of bar");
# TEST
ok((${Hello::}{'bar'}->() eq "bar"), "Checking for bar return code");
# TEST
ok(exists(${Hello::}{'baz'}), "Checking for existence of baz");
# TEST
ok((${Hello::}{'baz'}->() eq "baz"), "Checking for baz return code");
