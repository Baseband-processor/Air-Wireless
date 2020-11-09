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


use constant  {
       SIOCSIWCOMMIT => "0x8B00",
       SIOCGIWNAME => "0x8B01",
       SIOCSIWNWID => "0x8B02",
       SIOCGIWNWID => "0x8B03",
       SIOCSIWFREQ => "0x8B04",
       SIOCGIWFREQ => "0x8B05",
       SIOCSIWMODE => "0x8B06",
       SIOCGIWMODE => "0x8B07",
       SIOCSIWSENS => "0x8B08",
       SIOCGIWSENS => "0x8B09",
       SIOCSIWRANGE => "0x8B0A",
       SIOCGIWRANGE => "0x8B0B",
       SIOCSIWPRIV => "0x8B0C",
       SIOCGIWPRIV => "0x8B0D",
       SIOCSIWSTATS => "0x8B0E",
       SIOCGIWSTATS => "0x8B0F",
       SIOCSIWSPY => "0x8B10",
       SIOCGIWSPY => "0x8B11",
       SIOCSIWTHRSPY => "0x8B12",
       SIOCGIWTHRSPY => "0x8B13",
       SIOCSIWAP => "0x8B14",
       SIOCGIWAP => "0x8B15",
       SIOCGIWAPLIST => "0x8B17",
       SIOCSIWSCAN => "0x8B18",
       SIOCGIWSCAN => "0x8B19",
       SIOCSIWESSID => "0x8B1A",
       SIOCGIWESSID => "0x8B1B",
       SIOCSIWNICKN => "0x8B1C",
       SIOCGIWNICKN => "0x8B1D",
       SIOCSIWRATE => "0x8B20",
       SIOCGIWRATE => "0x8B21",
       SIOCSIWRTS => "0x8B22",
       SIOCGIWRTS => "0x8B23",
       SIOCSIWFRAG => "0x8B24",
       SIOCGIWFRAG => "0x8B25",
       SIOCSIWTXPOW => "0x8B26",
       SIOCGIWTXPOW => "0x8B27",
       SIOCSIWRETRY => "0x8B28",
       SIOCGIWRETRY => "0x8B29",
       SIOCSIWENCODE => "0x8B2A",
       SIOCGIWENCODE => "0x8B2B",
       SIOCSIWPOWER => "0x8B2C",
       SIOCGIWPOWER => "0x8B2D",
       SIOCSIWMODUL => "0x8B2E",
       SIOCSIWGENIE => "0x8B30",
       SIOCGIWGENIE => "0x8B31",
       SIOCSIWMLME => "0x8B16",
       SIOCSIWAUTH => "0x8B32",
       SIOCGIWAUTH => "0x8B33",
       SIOCSIWENCODEEXT => "0x8B34",
       SIOCGIWENCODEEXT => "0x8B35",
       SIOCSIWPMKSA => "0x8B36",
       SIOCIWFIRSTPRIV => "0x8BE0",
       SIOCIWLASTPRIV => "0x8BFF",
       SIOCIWFIRST => "0x8B00",
       SIOCIWLAST => "0x8BFF",
};
# implement classes
# an huge part of these class are from <wireless.h> header
 
struct sockaddr => {
	sa_family => '$', # address family
	sa_data => '$', # socket address (variable-length data)
};
struct ether_addr => {
	ether_addr_octet => '$', # ethernet address octet
};
struct iw_param => {
	value => '$', # value of the parameter itself
	fixed => '$', 
	disabled => '$', # disable feature
	flags => '$', # specific flags
};
struct iw_point => {
	pointer => '$', # user's data pointer
	length => '$', # number of fields or size in bytes
	flags => '$', # optional params
};
struct iw_freq => {
	m => '$', 
	e => '$',
	i => '$', # list index
	flags => '$', # specific flags
};
struct iw_quality => {
	qual => '$',  # link quality
	level => '$', # signal level (dBm)
	noise => '$', # noise level (dBm)
	updated => '$', # flags for update
};
struct iwreq_data => {
	name => '$', # network name
	essid => 'iw_point', # network essid
	nwid => 'iw_param', # network ID
	freq => 'iw_freq', # network's frequency
	sens => 'iw_param', # networkthreshold
	bitrate => 'iw_param', # network bitrate
	txpower => 'iw_param',
	rts => 'iw_param',
	frag => 'iw_param',
	mode => '$', # operations mode
	retry => 'iw_param', # limits and lifetime
	encoding => 'iw_point', # tokens used for encoding
	power => 'iw_param',
	qual => 'iw_quality',
	ap_addr	=> 'sockaddr', 
	addr => 'sockaddr', # destination address
	param => 'iw_param', # small parameters
	data => 'iw_point', # large parameters
};
struct iwreq => {
	ifrn_name => '$', # interface name
        u => 'iwreq_data', # data part
};
struct wireless_scan => {
	next => '*wireless_scan',
	has_maxbitrate => '$',
};
struct stream_descr => {
	end => '*$',
	current => '*$',
	value => '*$',
};
struct wireless_config => {
	name => '$',
	has_mode => '$',
	mode => '$',
};
# name of these parameters is quite intuitive, so less explanations :P
struct iw_range => {
	throughput => '$',
	min_nwid => '$',
	max_nwid => '$',
	num_channels => '$',
	num_frequency => '$',
	freq => 'iw_freq',
	sensitivity => '$',
	max_qual => 'iw_quality',
	num_bitrates => '$',
	bitrate => '$',
	min_rts => '$', # minimal RTS threshold
	max_rts => '$', # maximal RTS threshold
	min_frag => '$', # s/RTS/frag
	max_frag => '$', # s/RTS/frag
	min_pmp => '$',
	max_pmp => '$',
	min_pmt => '$',
	max_pmt => '$',
	pmp_flags => '$',
	pmt_flags => '$',
	pm_capa => '$',
	encoding_size => '$',
	num_encoding_sizes => '$',
	max_encodings_tokens => '$',
	txpower_capa => '$',
	num_txpower => '$',
	txpower => '$',
	we_version_compiled => '$', 
	we_version_source => '$',
	retry_capa => '$',
	retry_flags => '$',
	r_time_flags => '$',
	min_retry => '$',
	max_retry => '$',
	min_r_time => '$',
	max_r_time => '$',
	avg_qual => 'iw_quality',
};
struct wireless_scan_head => {
	result => '*wireless_scan',
	retry =>  '$',
};
# implement subroutines
# NOTE: the most used parameters are:
# skfd --> Socket to the kernel
# if_name --> Device name
# request --> WE ID
# pwrq --> Fixed part of the request
# Basic memcmp perl function not usefull for the user
sub memcmp {
  no locale;
  $_[0] cmp $_[1];
}
# Create an Ethernet broadcast address
sub iw_broad_ether(){
	my $Sock = sockaddr->new();
	$Sock = @_;
	$Sock->sa_family = 1; # alias ARPHRD_ETHER const
	$Sock->sa_data = 0x00 x 6; # alias ETH_ALEN const
}
# Create an Ethernet NULL address
sub iw_null_ether(){
	my $Sock = sockaddr->new();
	$Sock = @_;
	$Sock->sa_family = 1; # alias ARPHRD_ETHER const
	$Sock->sa_data = 0xFF x 6; # alias ETH_ALEN const
}
# Compare two ethernet addresses
sub iw_ether_cmp{
	my $eth1 = ether_addr->new();
	my $eth2 = ether_addr->new();
	( $eth1, $eth2 ) = @_;
	return( &memcmp( $eth1, $eth2 ) );
}
# this naif subroutine will store the first 2 lines of the /proc/net/wireless file and extract only the numeric digits, aka the WE number
sub iw_get_kernel_we_version(){
	if(! -e PROC_NET_WIRELESS){
		return -1;
	} 	
	my $file = `cat /proc/net/wireless | head -n 2`;
	$file =~ s/[^0-9]//g;
	print $file;
	if( length( $file ) > 2 ){
		while( length( $file ) <= 2 ){
			chop( $file );
		}
	}
	return( $file );
}


# NOTE:
# iw_set_ext and iw_get_ext differs only by the IOCTL, one push parameters while the other require parameters
sub iw_set_ext{
	my( $skfd, $ifname, $request ) = @_; 
	my( $skfd, $ifname, $ioctl ) = @_; 
	my $pwrq = iwreq->new();
	substr( $pwrq->ifrn_name, 16, $ifname ); # where 16 is the value of the IFNAMSIZ constant
	return( ioctl($skfd, $request, $pwrq) );
	return( ioctl($skfd, $ioctl, $pwrq) );
}


sub iw_get_ext{
	my( $skfd, $ifname, $request ) = @_; 
	my( $skfd, $ifname, $ioctl ) = @_; 
	my $pwrq = iwreq->new();
	substr( $pwrq->ifrn_name, 16, $ifname ); # where 16 is the value of the IFNAMSIZ constant
	return( ioctl($skfd, $request, $pwrq) );
	return( ioctl($skfd, $ioctl, $pwrq) );
}

# return AF_INET socket
sub iw_sockets_open(){
        my $Socket = socket(my $socket, AF_INET, SOCK_DGRAM, 0);
	if($Socket >= 0){
		return $Socket;
	}else{
		return -1; # means "unable to create the socket"
	}
}
# close the socket opened with iw_sockets_open function
sub iw_sockets_close{
  my $skfd = @_;
  if ( close( $skfd ) ){
	return 1;
	}
 }
sub iw_process_scan{
	my( $skfd, $ifname, $we_version, $ioctl ) = @_; 
	my $buffer = undef;
	my $buflength = 4096;
	
	my $context = wireless_scan_head->new();
 	my $retry = $context->retry +1;
	if( $retry >= 150 ){
	  return -1;
	}
	if( $retry == 1 ){
		my $wrq = new iwreq;
		my $u = $wrq->u;
		my $data = $u->data;
		$data->pointer = undef;
		$data->data->flags = 0;
		$data->data->length = 0;
		if(&iw_set_ext( $skfd, $ifname, $ioctl, $wrq ) < 0 ){
			return(-1);
		}
			}
}
# wireless scan
sub iw_scan{
	my( $skfd, $ifname, $we_version, $context ) = @_;
	my $delay;
	# Security check
	# this is done against buffer overflows
	my $Scan_head = new wireless_scan_head;
	if(not undef($Scan_head->result)){
		$Scan_head->result = undef;
	}
	$Scan_head->result = 0;
	
	while(1){
	  my $delay = &iw_process_scan( $skfd, \$ifname, $we_version, $context);
	  if($delay <= 0){
	    last;
		}
	  sleep($delay * 1000);
	}
	  return( $delay );
}
sub iw_print_value_name{
	my( $value, @names, $num_names ) = @_;
	if( $value >= $num_names ){
		print " $value is unknown!\n";
		return -1;
	}else{
		print $names[$value];	
}
	}
	
sub iw_print_ie_unknown {
	my ( @iebuf, $buflength ) = @_;
	my $ielength = $iebuf[1] + 2;
	  if( $ielength > $buflength ) {
    		$ielength = $buflength ;
	}
	for( my $i = 0; $i < $ielength; $i++ ){
		    printf("%02X", $iebuf[$i]);
		    print "\n";
}
	}
# list all information elements and use them for determine the protocols used by wireless networks
sub iw_print_ie_wpa{
	my ( @iebuf, $buflength ) = @_;
	my $ielength = $iebuf[1] + 2;
	my $offset = 2;
	my ( @wpa_oui, @wpa1_oui, @wpa2_oui );
	$wpa1_oui[3] = {0x00, 0x50, 0xf2};
	$wpa2_oui[3] = {0x00, 0x0f, 0xac};
	if( $ielength > $buflength ){
    		$ielength = $buflength;
	}
	switch( $iebuf[0] ) {
		case 0x30 { 
			if( $ielength < 4) { 
				&iw_print_ie_unknown( @iebuf, $buflength ); 
				@wpa_oui = @wpa2_oui; 
				break;
			}
		 }
		case 0xdd { 
			@wpa_oui = @wpa1_oui; 
			if( ( $ielength < 8)  or ( $iebuf[ $offset + 3] != 0x01)){ 
				&iw_print_ie_unknown( @iebuf, $buflength ); 
				} 
			$offset += 4; 
			break; }
	}
	my $ver = $iebuf[ $offset ] | ( $iebuf[ $offset + 1] << 8);
	my $offset += 2;
	if( $iebuf[0] eq 0xdd){
    		printf("WPA Version %d\n", $ver);
		}
 	 if( $iebuf[0] == 0x30){
    		printf("IEEE 802.11i/WPA2 Version %d\n", $ver);
    }
	}
		
1;

