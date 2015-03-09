#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;
use Test::MockObject;

BEGIN
{
    # TEST
    use_ok('Site::Member');
}

my @warnings;
$SIG{'__WARN__'} = sub { my $w = shift; push @warnings, $w; };

my $mock = Test::MockObject->new();
$mock->fake_module(
    "Geo::IP",
    'import' => sub { die "Not-exist!"; }
);

my $obj = Site::Member->new();
$obj->ip_address("100.0.0.1");
# TEST
is($obj->ip_address(), "100.0.0.1", "Checking for IP Address Assignment");

my @ret = ($obj->city());
# TEST
ok((@ret == 0), "Checking for no return");
# TEST
ok((@warnings == 1), "Checking for one warning issued");
# TEST
like($warnings[0], qr/^You must have Geo::IP installed for this feature/,
    "Check for correct warning");

