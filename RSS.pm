
package CGI::RSS;

use strict;
use base 'CGI';

our @TAGS = qw(
    rss channel titlte item description date link
    image url copyright generator
);

1;

sub make_tags {
    # NOTE: This tricks CGI.pm into thinking these are valid html tags...
    #       We do this at header() time so you can add your own.
    #       e.g.: push @CGI::RSS::TAGS, "mytag";

    # XXX: The construction of CGI.pm's _make_tag_func() rule's out namespaces
    # (like push @CGI::RSS::TAGS, "myns:mytag"), if you have any suggestions
    # for this, please let me know.  I had considered writing a cgi::rss
    # version that converts the ':' to a '_' in the function name...  That's
    # harder than it sounds so I let it go for now.

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

    return $this->end_rss;
}

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

    CGI::RSS - provides a CGI-like interface for making rss feeds

=head1 SYNOPSIS

    use CGI::RSS;

    my $rss = new CGI::RSS;
    # NOTE: This doesn't work either way like CGI.pm, it's only OO...

    # As you can see, this differs slightly from the spirit of CGI.pm.
    # Like most XML formats, RSS is even less convenient than HTML, so instead
    # of making you print each element individually, they work as arguments.

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

=head1 AUTHOR

Paul Miller <jettero@cpan.org>

I am using this software in my own projects...  If you find bugs, please
please please let me know. :) Actually, let me know if you find it handy at
all.  Half the fun of releasing this stuff is knowing that people use it.

=head1 COPYRIGHT

Copyright (c) 2007 Paul Miller -- LGPL [attached]

=head1 SEE ALSO

Term::Size, Term::ANSIColor, Term::ANSIScreen
