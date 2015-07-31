#!/usr/bin/perl

use strict;
use warnings;

use IO::All;

my $text = io("MyModule.pm-unobfus")->slurp();

my $next_obfu = "c";

my %map;

sub get_obfu
{
    my $sym = shift;

    if (! exists($map{$sym}))
    {
        $map{$sym} = $next_obfu++;
    }
    return $map{$sym};
}

$text =~ s{\$(\w+)\b}{"\$" . get_obfu($1)}eg;

io("MyModule.pm")->print($text);

