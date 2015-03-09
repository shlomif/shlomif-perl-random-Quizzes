#!/usr/bin/perl -w

use strict;

my %lines_to_extract;

open DECLS, "bash analyze-globals.sh |";
while (<DECLS>)
{
    chomp($_);
    my ($file,$line_num,$text) = /^(\w+\.c):(\d+):(.*)$/;
    push @{$lines_to_extract{$file}}, +{ 'l' => $line_num, 't' => $text, };
}
close(DECLS);

my @lines_to_put = ();
foreach my $file (keys(%lines_to_extract))
{
    my $lines = $lines_to_extract{$file};
    my $line_num = 1;
    my $extracted_line_idx = 0;
    open I, "<$file";
    open O, ">$file.new";
    while (<I>)
    {
        if (($extracted_line_idx < @$lines) && 
            ($line_num == $lines->[$extracted_line_idx]->{l})
           )
        {
            push @lines_to_put, $_;
            $extracted_line_idx++;
        }
        else
        {
            print O $_;
        }
    }
    continue
    {
        $line_num++;
    }
    close(I);
    close(O);
    rename("$file.new", "$file");
}
open GLOBALS, ">globals.c";
print GLOBALS @lines_to_put;
close(GLOBALS);


