
package CGI::RSS;

use strict;
use base 'CGI';

1;

our @TAGS = qw( channel titlte item description date link rss );

sub header {
    my $this = shift;
    return $this->SUPER::header("application/xml") . "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n";
}

sub start_rss {
    my $this = shift;
    my $opts = $_[0];
       $opts = {@_} unless ref $opts;

    my $ver = $opts->{version} || "2.0";
    my $ret = qq(<rss version="$ver">);
       $ret .= $this->start_channel;
       $ret .= $this->link($opts->{link})   if exists $opts->{link};
       $ret .= $this->title($opts->{title}) if exists $opts->{title};

    return $ret;
}

sub end_rss { "</rss>" }

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
    print $rss->start_rss(title=>"My Feed!", link=>"http://localhost/directory");
    while( my $h = $sth->fetchrow_hashref ) {
        print $rss->item(title=>$h->{title}, link=>$h->{link}, desc=>$h->{desc}, date=>$h->{date})
    }
    print $rss->end_rss;

=head1 AUTHOR

Paul Miller <jettero@cpan.org>

I am using this software in my own projects...  If you find bugs, please
please please let me know. :) Actually, let me know if you find it handy at
all.  Half the fun of releasing this stuff is knowing that people use it.

=head1 COPYRIGHT

Copyright (c) 2007 Paul Miller -- LGPL [attached]

=head1 SEE ALSO

Term::Size, Term::ANSIColor, Term::ANSIScreen
