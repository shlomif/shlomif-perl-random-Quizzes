#!/usr/bin/perl

use strict;
use warnings;

package Hello;

use Test::More tests => 3;
use Optional::Exports;
# TEST
ok(!exists(${Hello::}{'foo'}),"Checking for in-existence of foo");
# TEST
ok(!exists(${Hello::}{'bar'}),"Checking for in-existence of bar");
# TEST
ok(!exists(${Hello::}{'baz'}),"Checking for in-existence of baz");
