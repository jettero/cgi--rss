#!/usr/bin/perl

use strict;

require "RSS.pm";

my $rss = new CGI::RSS;

print $rss->header;
print $rss->begin_rss(title=>"My Feed!", link=>"http://localhost/directory");

    print $rss->item(
        $rss->title       ( "test title"       ),
        $rss->link        ( "http://url/url/"  ),
        $rss->description ( "roflmao roflmao"  ),
        $rss->date        ( "2008-03-22"       ),
    );

print $rss->finish_rss;
print "\n\n";
