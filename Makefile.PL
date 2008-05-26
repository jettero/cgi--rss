# vi:set syntax=perl:

require 5.008;

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'CGI::RSS',
    VERSION_FROM => 'RSS.pm',
    clean        => { FILES => "test.xml" },
    PREREQ_PM    => { version => 0 },
);
