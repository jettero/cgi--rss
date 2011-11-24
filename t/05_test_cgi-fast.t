# vi:fdm=marker fdl=0 syntax=perl:

use strict;
use Test;
use CGI::RSS;
use Date::Manip;

plan tests => my $tests = 1;

# https://rt.cpan.org/Ticket/Display.html?id=72662
# perl -e 'use CGI::Fast ;use CGI::RSS; new CGI::Fast; my $r = new CGI::RSS; print $r->header, $r->begin_rss;' 

if( eval q {use CGI::Fast; 1} ) {

    CGI::Fast->new;

    my $cgi = CGI::RSS->new;
    my $string = eval {
        $cgi->header .
        $cgi->begin_rss;
    };

    if( $string =~ m/<rss/ ) {
        ok(1);

    } else {
        warn " problem running begin_rss: $@";
    }

} else {
    print "ok $_ # no CGI::Fast, no test\n" for 1 .. $tests;
}
