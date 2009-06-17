#!/usr/bin/perl

use strict;
use warnings;

use POSIX ();
use DateTime ();
use Template ();

my $tt = Template->new();
my $vars = {};
$vars->{'now_dt'} = sub { DateTime->now( time_zone => 'local' ); };
$vars->{'now_posix'} = sub { POSIX::strftime('%FT%T',localtime(time)); };

my $posix_template = <<'EOM';
Starting POSIX test...
Current timestamp: [% now_posix %]
Finished POSIX test.
EOM

my $datetime_template = <<'EOM';
Starting DateTime test...
Current timestamp: [% now_dt %]
Finished DateTime test.
EOM

$tt->process(\$posix_template, $vars);
$tt->process(\$datetime_template, $vars);

exit;
