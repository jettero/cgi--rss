# vi:set syntax=perl:

require 5.008;

use strict;
use ExtUtils::MakeMaker;

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

    clean        => { FILES => "test.xml" },
);
