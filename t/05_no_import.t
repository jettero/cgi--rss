# vi:fdm=marker fdl=0 syntax=perl:

use strict;
use Test;
use CGI::RSS ();
use Date::Manip;

plan tests => 2;

my $rss = new CGI::RSS;

ok( eval { CGI::RSS::start_rss(); 17 }, 17 );
ok( $@, "" );
