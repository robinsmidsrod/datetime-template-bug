#!/usr/bin/perl

use strict;
use warnings;

use POSIX ();
use DateTime ();
use Template ();

print_version_info();

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
print "The bug is present if you don't see any output after this line.\n";

$tt->process(\$datetime_template, $vars);
print "If you got here, you're in the clear.\n";

exit;

sub print_version_info {
    print "Version information:\n";
    system("lsb_release -d");
    system("uname -a");
    system("perl -v | grep This");
    print "POSIX version: " . $POSIX::VERSION . "\n";
    print "DateTime version: " . $DateTime::VERSION . "\n";
    print "Template version: " . $Template::VERSION . "\n";
    print "-" x 30, "\n";
}

__END__
COnfirmed working on:

Description:    Ubuntu 8.10
Linux server 2.6.27-14-server #1 SMP Wed Apr 15 19:44:38 UTC 2009 i686 GNU/Linux
This is perl, v5.10.0 built for i486-linux-gnu-thread-multi
POSIX version: 1.13
DateTime version: 0.50
Template version: 2.20
