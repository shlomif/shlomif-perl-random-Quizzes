#!/usr/bin/perl -w

use strict;

use Foo;

sub replace
{
    my $string = shift;
    if ($string =~ /:/)
    {
        $string =~ m#^([^:]*:/*)(.*)$#;
        my ($proto, $rest) = ($1,$2);
        $rest =~ s!/+!/!g;
        return $proto.$rest;
    }
    else
    {
        return $string;
    }
}

my $input = <<"EOF" ;
+  const char *paths[][2] = {
+    { "file:///var/svn/",               "file:///var/svn/" },
+    { "file:///var/svn//hello",         "file:///var/svn/hello" },
+    { "file:///var/svn/hello//",        "file:///var/svn/hello/" },
+    { "file:///var/svn///hello/",       "file:///var/svn/hello/" },
+    { "file:///var////svn/",            "file:///var/svn/" },
+    { "http://localhost/svn/",          "http://localhost/svn/" },
+    { "http://localhost/svn//",         "http://localhost/svn/" },
+    { "http://localhost/svn//hello/",   "http://localhost/svn/hello/" },
+    { "http://localhost/svn///hello/",  "http://localhost/svn/hello/" },
+    { "gg:hello//world",  "gg:hello/world" },
+    { NULL, NULL }
EOF

my @lines = split(/\n/, $input);
my $test_idx = 0;
foreach my $l (@lines)
{
    if ($l =~ /\{\s*"([^"]*)"\s*,\s*"([^"]*)"\s*\}\s*,/)
    {
        my $in = $1;
        my $expected_out = $2;
        # my $real_out = Foo::foo($in);
        my $real_out = replace($in);
        if ($real_out eq $expected_out)
        {
            print "Test $test_idx Passed!\n";
        }
        else
        {
            print "Test $test_idx Failed!\n";
            print "Got \"$real_out\" instead of \"$expected_out\" for " . "
                input \"$in\"!\n";
            die;
        }
        $test_idx++;
    }
}
