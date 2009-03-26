# vi:set syntax=perl:

require 5.008;

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'CGI::RSS',
    VERSION_FROM => 'RSS.pm',

    ($ExtUtils::MakeMaker::VERSION ge '6.48'? 
        (MIN_PERL_VERSION => 5.008,
            META_MERGE => {
                keywords => ['pcap', 'sniffer'],
                resources=> {
                    repository => 'http://github.com/jettero/cgi--rss/tree',
                },
            },

        LICENSE	=> 'lgpl2',
    ) : ()),

    clean        => { FILES => "test.xml" },
);
