#!/usr/bin/perl

use strict;
use warnings;

use POSIX ();
use DateTime ();
use Template ();

my $tt = Template->new();
my $vars = {};
$vars->{'now_dt'} = sub { DateTime->now( time_zone => 'local' ); };
$vars->{'now_posix'} = sub { POSIX::strftime('%F %T %z',localtime(time)); };

$tt->process(\*DATA, $vars);

exit;

__END__
Starting...
POSIX current timestamp: [% now_posix %]
DateTime current timestamp: [% now_dt %]
Finished.
