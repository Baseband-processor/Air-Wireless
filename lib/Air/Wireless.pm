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

use constant {
	NLM_F_REQUEST => "0x01",
	NLM_F_MULTI => "0x02",
	NLM_F_ACK => "0x04",
	NLM_F_ECHO => "0x08",
	NLM_F_DUMP_INTR => "0x10",
	NLM_F_DUMP_FILTERED => "0x20",
	NLM_F_ROOT => "0x100",
	NLM_F_MATCH => "0x200",
	NLM_F_ATOMIC => "0x400",
	NLM_F_DUMP => "0x100"|"0x200",
	NLM_F_REPLACE => "0x100",
	NLM_F_EXCL => "0x200",
	NLM_F_CREATE => "0x400",
	NLM_F_APPEND => "0x800",
	NLM_F_NONREC => "0x100",
	NLM_F_CAPPED => "0x100",
	NLM_F_ACK_TLVS => "0x200",

}

# implement avaiable ioctls
# for more info about varius IOCTL please refer to: elixir.bootlin.com and search for linux source code, are well documented


		
1;

