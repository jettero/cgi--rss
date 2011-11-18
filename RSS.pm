
package CGI::RSS;

use strict;
use base 'CGI';
use Date::Manip;
use B::Deparse;

our $VERSION = '0.9654';
our $pubDate_format = '%a, %d %b %Y %H:%M:%S %z';

sub pubDate_format {
    my $class_or_instance = shift;
    my $proposed = shift;

    $pubDate_format = $proposed;
    $pubDate_format
}

sub import {}
BEGIN {
    my @TAGS = qw(
        rss channel item

        title link description

        language copyright managingEditor webMaster pubDate lastBuildDate category generator docs
        cloud ttl image rating textInput skipHours skipDays

        link description author category comments enclosure guid pubDate source

        pubDate url
    );

    $CGI::EXPORT{$_} = 1 for @TAGS;
    *AUTOLOAD = \&CGI::AUTOLOAD;

    # Instruct CGI.pm to *not* ruin the case of (eg) pubDate
    # (NOTE: this is evil voodoow, don't judge me.)

    my $deparse = B::Deparse->new("-p", "-sC");
    my $deparsed = $deparse->coderef2text(\&CGI::_make_tag_func);

    $deparsed =~ s/\\[LE]//g;

    my $sub = eval "sub $deparsed" or die $@;
    do { no warnings 'redefine'; *CGI::_make_tag_func = $sub; };


    # Make sure we have a TZ
    unless( eval {Date_TimeZone(); 1} ) {
        $ENV{TZ} = "UTC" if $@ =~ m/unable to determine Time Zone/i;
    }
}

sub date {
    my $this = shift;

    if( my $pd = ParseDate($_[-1]) ) {
        my $date = UnixDate($pd, $pubDate_format);
        return $this->pubDate($date);
    }

    $this->pubDate(@_);
}

sub header {
    my $this = shift;

    return $this->SUPER::header("application/xml") . "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n";
}

sub begin_rss {
    my $this = shift;
    my $opts = $_[0];
       $opts = {@_} unless ref $opts;

    # NOTE: This isn't nearly as smart as CGI.pm's argument parsing... 
    # I assume I could call it, but but I'm only mortal.

    my $ver = $opts->{version} || "2.0";
    my $ret = $this->start_rss({version=>$ver});
       $ret .= $this->start_channel;
       $ret .= $this->link($opts->{link})        if exists $opts->{link};
       $ret .= $this->title($opts->{title})      if exists $opts->{title};
       $ret .= $this->description($opts->{desc}) if exists $opts->{desc};

    return $ret;
}

sub finish_rss {
    my $this = shift;

    return $this->end_channel . $this->end_rss;
}

"This file is true."
