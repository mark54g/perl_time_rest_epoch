#!/usr/bin/perl
# rest.pl - make a REST call to outside source
# 20140707 - Initial version - Mark Vovchuk

use LWP::Simple;
use LWP::UserAgent;

my $useragent = LWP::UserAgent->new;
my $external = 'http://time.jsontest.com';
my $epochdate = `/bin/date +%s`;
my $fetch = $useragent->get($external);
my $results = $fetch->content;
#print $results;
my @time = split(/\n/, $results);
foreach $time(@time)
{
    if ($time =~ m#mil#)
    {
        ($text, $epoch) = split(": ",$time);
        chop($epoch);
        #print "$epoch\n";
    }
}
$epoch = $epoch / 1000;
$difference = abs($epochdate - $epoch);
print "Time difference between local and $external is: $difference seconds\n";
