#!/usr/bin/perl

package Air::Wireless;

our $VERSION = "0.07";

# implement libraries

use strict;
no strict 'refs';
no strict 'subs';
use feature "refaliasing";
no warnings;
use File::fgets;
use Class::Struct;
use Config;
require Exporter;

use Socket qw( AF_INET SOCK_DGRAM);
use Socket::Netlink;

our ( @ISA, @EXPORT_OK, %EXPORT_TAGS );

my $ioctl_folder = $Config{archlib} . "/sys/ioctl.ph";

if( -e $ioctl_folder ){
	require "sys/ioctl.ph";	
}

# implement constants

use constant PROC_NET_WIRELESS => "/proc/net/wireless"; 

# implement avaiable ioctls
# for more info about varius IOCTL please refer to: elixir.bootlin.com and search for linux source code, are well documented


		
1;

