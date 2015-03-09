#!/usr/bin/perl -w

use strict;

package Hello;

use Test::More tests => 5;

use_ok('Basic::Exports'); # TEST

# TEST
ok(exists(${Hello::}{'foo'}),"Checking for existence of foo");
# TEST
ok((${Hello::}{'foo'}->() eq "foo"), "Checking for foo return code");

# TEST
ok(exists(${Hello::}{'bar'}),"Checking for existence of bar");
# TEST
ok((${Hello::}{'bar'}->() eq "bar"), "Checking for bar return code");

