#!/usr/bin/perl
#tcpserver.pl

use IO::Socket::INET;
use threads;
my $sock = new IO::Socket::INET 
{
    LocalHost => $host, 
    LocalPort => $port, 
    Proto => 'tcp',
    Listen => SOMAXCONN,
    Reuse => 1,
};
die "Could not create socket $!\n" unless $sock;

while ( my ($new_sock,$c_addr) = $sock->accept() ) {
    my ($client_port, $c_ip) = sockaddr_in($c_addr);
    my $client_ipnum = inet_ntoa($c_ip);
    my $client_host = "";

    my @threads;

    print "$client_host", "[$client_ipnum]\n";
    my $command;
    my $data;

    while ($data = <$new_sock>) {
        push @threads, async \&Execute, $data;
    }
}

sub Execute {
    my ($command) = @_;


    print "Executing command: $command\n";
    system($command);
}
