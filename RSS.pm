
package CGI::RSS;

use strict;
use base 'CGI';

use version; our $VERSION = qv('0.7.3');

# TODO: this collection of tag names is hardly "correct" or complete
our @TAGS = qw(
    rss channel item

    title link description

    language copyright managingEditor webMaster pubDate lastBuildDate category generator docs
    cloud ttl image rating textInput skipHours skipDays

    link description author category comments enclosure guid pubDate source

    date url
);

1;

sub make_tags {
    $CGI::EXPORT{$_} = 1 for @TAGS;
}

sub header {
    my $this = shift;

    &make_tags;

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
       $ret .= $this->link($opts->{link})   if exists $opts->{link};
       $ret .= $this->title($opts->{title}) if exists $opts->{title};

    return $ret;
}

sub finish_rss {
    my $this = shift;

    return $this->end_channel, $this->end_rss;
}

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

    CGI::RSS - provides a CGI-like interface for making rss feeds

=head1 SYNOPSIS

    use strict;
    use CGI::RSS;

    # NOTE: This doesn't work either way like CGI.pm, it's only OO...

    my $rss = new CGI::RSS;

    print $rss->header;
    print $rss->begin_rss(title=>"My Feed!", link=>"http://localhost/directory");
    while( my $h = $sth->fetchrow_hashref ) {
        print $rss->item(
            $rss->title       ( $h->{title} ),
            $rss->link        ( $h->{link}  ),
            $rss->description ( $h->{desc}  ),
            $rss->date        ( $h->{date}  ),
        );
    }
    print $rss->finish_rss;

=head1 TAGS

=head2 RSS TAGS

The following tags work anywhere.  There is no enforcement for
where they belong.  They're just tag functions.

    rss channel item title link description language copyright
    managingEditor webMaster pubDate lastBuildDate category
    generator docs cloud ttl image rating textInput skipHours
    skipDays link description author category comments enclosure
    guid pubDate source date url

=head2 MORE TAGS

RSS.pm tricks CGI.pm into thinking the above tags are are valid
html tags.  It does this at run time so you can add your own.

    push @CGI::RSS::TAGS, "mytagname";

The construction of CGI.pm's _make_tag_func() rule's out
namespaces (e.g., push @CGI::RSS::TAGS, "myns:mytag"), if you
have any suggestions on how to handle this, please let me know.

I had considered writing a CGI::RSS::_make_tag_func() that
converts the ':' to a '_' in the function name...  That's harder
than it sounds so I let it go for now.

=head1 TODO

I just wanted to get this thing working for now, but I'm not proud
of the module. In the future, I'd like to actually follow a standard.

 1. conform to standard(s) if possible
 2. deal with xmlns somehow

=head1 AUTHOR

Paul Miller <jettero@cpan.org>

I am using this software in my own projects...  If you find bugs, please
please please let me know. :) Actually, let me know if you find it handy at
all.  Half the fun of releasing this stuff is knowing that people use it.

=head1 COPYRIGHT

Copyright (c) 2007 Paul Miller -- LGPL [attached]

=head1 SEE ALSO

CGI
