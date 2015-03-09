#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 8;
use Test::MockObject;

BEGIN
{
    # TEST
    use_ok('Site::Member');
}

my @warnings;
$SIG{'__WARN__'} = sub { my $w = shift; push @warnings, $w; };

my @calls;

my $mock = Test::MockObject->new();
$mock->fake_module(
    "Geo::IP",
    'open' => sub { push @calls, ["open", [@_]]; return undef; },
    'GEOIP_STANDARD' => sub { push @calls, ["GEOIP_STANDARD", [@_]]; return 1; },
);

my $obj = Site::Member->new();
$obj->ip_address("100.0.0.1");
# TEST
is($obj->ip_address(), "100.0.0.1", "Checking for IP Address Assignment");

eval {
my @ret = ($obj->city());
};
# TEST
like($@, qr/^Could not create a Geo::IP object with City data/,
    "Checking for exception");

# TEST
ok ((@warnings == 0), "Check for no warnings");

my ($name, $args) = @{shift(@calls)};
# TEST
is($name, "GEOIP_STANDARD", "Checking for GEOIP_STANDARD");
# TEST
ok((@$args == 1), "Checking for length of GI_S");
# TEST
is($args->[0], "Geo::IP", "is");

($name, $args) = @{shift(@calls)};
# TEST
is ($name, "open", "checking for open being called.");
