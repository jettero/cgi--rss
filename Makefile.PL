# vi:set syntax=perl:

require 5.008;

use strict;
use ExtUtils::MakeMaker;

unlink "w3.ok"; # doesn't really matter if this fails
my $res = prompt("Submit sample rss to W3 for validation?", "no");
open my $x, ">w3.ok" or die $! if $res =~ m/(?i:yeah|yes|y|sure|ok|dude)/;

WriteMakefile(
    NAME         => 'CGI::RSS',
    VERSION_FROM => 'RSS.pm',
    'PREREQ_PM'     => {
        'Date::Manip' => 0,
        'B::Deparse'  => 0,
    },

    ($ExtUtils::MakeMaker::VERSION ge '6.48'? 
        (MIN_PERL_VERSION => 5.008,
            META_MERGE => {
                keywords => ['cgi', 'rss'],
                resources=> {
                    repository => 'http://github.com/jettero/cgi--rss/tree',
                },
            },

        LICENSE	=> 'lgpl2',
    ) : ()),

    clean => { FILES => "test.xml" },
);
