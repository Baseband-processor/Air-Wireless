#!/usr/bin/perl

package Air::Wireless;

our $VERSION = "0.07";

# implement libraries

use strict 'refs';
no strict 'subs';
use feature "refaliasing";
no warnings;
use File::fgets;
use Class::Struct;
use Config;
use base qw(Exporter DynaLoader);

my $ioctl_folder = $Config{archlib} . "/sys/ioctl.ph";

if( -e $ioctl_folder ){
	require "sys/ioctl.ph";	
}

# implement constants

use constant PROC_NET_WIRELESS => "/proc/net/wireless";

use constant {
       SIOCSIWCOMMIT => 0x8B00,
       SIOCGIWNAME => 0x8B01,
       SIOCSIWNWID => 0x8B02,
       SIOCGIWNWID => 0x8B03,
       SIOCSIWFREQ => 0x8B04,
       SIOCGIWFREQ => 0x8B05,
       SIOCSIWMODE => 0x8B06,
       SIOCGIWMODE => 0x8B07,
       SIOCSIWSENS => 0x8B08,
       SIOCGIWSENS => 0x8B09,
       SIOCSIWRANGE => 0x8B0A,
       SIOCGIWRANGE => 0x8B0B,
       SIOCSIWPRIV => 0x8B0C,
       SIOCGIWPRIV => 0x8B0D,
       SIOCSIWSTATS => 0x8B0E,
       SIOCGIWSTATS => 0x8B0F,
       SIOCSIWSPY => 0x8B10,
       SIOCGIWSPY => 0x8B11,
       SIOCSIWTHRSPY => 0x8B12,
       SIOCGIWTHRSPY => 0x8B13,
       SIOCSIWAP => 0x8B14,
       SIOCGIWAP => 0x8B15,
       SIOCGIWAPLIST => 0x8B17,
       SIOCSIWSCAN => 0x8B18,
       SIOCGIWSCAN => 0x8B19,
       SIOCSIWESSID => 0x8B1A,
       SIOCGIWESSID => 0x8B1B,
       SIOCSIWNICKN => 0x8B1C,
       SIOCGIWNICKN => 0x8B1D,
       SIOCSIWRATE => 0x8B20,
       SIOCGIWRATE => 0x8B21,
       SIOCSIWRTS => 0x8B22,
       SIOCGIWRTS => 0x8B23,
       SIOCSIWFRAG => 0x8B24,
       SIOCGIWFRAG => 0x8B25,
       SIOCSIWTXPOW => 0x8B26,
       SIOCGIWTXPOW => 0x8B27,
       SIOCSIWRETRY => 0x8B28,
       SIOCGIWRETRY => 0x8B29,
       SIOCSIWENCODE => 0x8B2A,
       SIOCGIWENCODE => 0x8B2B,
       SIOCSIWPOWER => 0x8B2C,
       SIOCGIWPOWER => 0x8B2D,
       SIOCSIWMODUL => 0x8B2E,
       SIOCGIWMODUL => 0x8B2F,
       SIOCSIWGENIE => 0x8B30,
       SIOCGIWGENIE => 0x8B31,
       SIOCSIWMLME => 0x8B16,
       SIOCSIWAUTH => 0x8B32,
       SIOCGIWAUTH => 0x8B33,
       SIOCSIWENCODEEXT => 0x8B34,
       SIOCGIWENCODEEXT => 0x8B35,
       SIOCSIWPMKSA => 0x8B36,
       SIOCIWFIRSTPRIV => 0x8BE0,
       SIOCIWLASTPRIV => 0x8BFF,
       SIOCIWFIRST => 0x8B00,
       SIOCIWLAST => SIOCIWLASTPRIV,
};

# implement classes

struct( ifr_ifrn => [
	ifrn_name => '$', # interface name
]);
        
struct( ether_addr => [
	ether_addr_octet => '$', # octet
]);

struct( iw_param => [
	value => '$',
	fixed => '$',
	disabled => '$',
	flags => '$',
]);

struct( iw_point => [
	pointer => '$',
	length => '$',
	flags => '$',
]);

struct( iw_freq => [
	m => '$', 
	e => '$',
	i => '$',
]);

struct( iw_quality => [
	qual => '$',  # link quality
	level => '$', # signal level (dBm)
	noise => '$', # noise level (dBm)
	updated => '$', # flags for update
]);


struct( iwreq_data => [
	name => '$',
	essid => 'iw_point',
	nwid => 'iw_param',
	freq => 'iw_freq',
	sens => 'iw_param',
	bitrate => 'iw_param',
	txpower => 'iw_param',
	rts => 'iw_param',
	frag => 'iw_param',
	mode => '$',
	retry => 'iw_param',
	encoding => 'iw_point',
	power => 'iw_param',
	qual => 'iw_quality',
	ap_addr	=> 'sockaddr',
	addr => 'sockaddr',
	param => 'iw_param',
	data => 'iw_point',
]);


struct( iwreq => [
	ifrn_name => '$',
        u => 'iwreq_data',
]);


struct( wireless_scan => [
	next => '*wireless_scan',
	has_maxbitrate => '$',

]);

struct( stream_descr => [
	end => '*$',
	current => '*$',
	value => '*$',
]);

struct( wireless_config => [
	name => '$',
	has_mode => '$',
	mode => '$',
]);

struct( iw_range => [
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
	min_rts => '$',
	max_rts => '$',
	min_frag => '$',
	max_frag => '$',
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
]);

struct( wireless_scan_head => [
	result => '*wireless_scan',
	retry =>  '$',
]);

# implement subroutines

# Basic memcmp perl function
sub memcmp {
  no locale;
  $_[0] cmp $_[1];
}

# Create an Ethernet broadcast address
sub iw_broad_ether(){
	my $Sock;
	$Sock = new sockaddr = @_;
	$Sock->sa_family = 1; # alias ARPHRD_ETHER const
	$Sock->sa_data = 0x00 x 6; # alias ETH_ALEN const
}

# Create an Ethernet NULL address
sub iw_null_ether(){
	my $Sock;
	\$Sock = new sockaddr = @_;
	$Sock->sa_family = 1; # alias ARPHRD_ETHER const
	$Sock->sa_data = 0xFF x 6; # alias ETH_ALEN const

}

# Compare two ethernet addresses

sub iw_ether_cmp{
	my $eth1 = new ether_addr;
	my $eth2 = new ether_addr;
	( $eth1, $eth2 ) = @_;
	return( &memcmp( $eth1, $eth2 ) );
}

sub iw_get_kernel_we_version(){
	my $v;
	my $file = open( WIRELESS, '>', "/proc/net/wireless" ); #PROC_NET_WIRELESS
	if(undef ( $file ) || (! WIRELESS) ){
		print "cannot read /proc/net/wireless/";
		return -1;
		}

	my $buff = fgets($file, 1024);
	if(index($buff, "| WE") == undef){
		if(index($buff, "| Missed") == undef){
			$v = 11;
		}else{
		$v = 15;
		close( $file );
		return( $v );
}	
	}
	$buff = fgets( 1024, $file );
	my @version = split( "|", $buff );
	$v = $version[-1];
	close( $file );
	return( $v );
}

sub iw_set_ext{
	my( $skfd, $ifname, $request ) = @_; 
	my $pwrq = new iwreq;
	substr( $pweq->ifr_name, 16, $ifname ); # where 16 is the value of the IFNAMSIZ constant
	return( ioctl($skfd, $request, $pwrq) );
}


sub iw_get_ext{
	my( $skfd, $ifname, $request ) = @_; 
	my $pwrq = new iwreq;
	substr( $pweq->ifr_name, 16, $ifname ); # where 16 is the value of the IFNAMSIZ constant
	return( ioctl($skfd, $request, $pwrq) );
}

# NOTE:
# iw_set_ext and iw_get_ext differs only by the IOCTL, one push parameters while the other require parameters

sub iw_process_scan{
	my( $skfd, $ifname, $we_version, $ioctl ) = @_; 
	# parse and control
	foreach(@ioctls){
		if($ioctl != $_){	
			continue unless ($_ == $ioctls[-1]);
			$ioctl = "0x8B18"; # assign as ioctl 'SIOCSIWSCAN'			
			}
		}
	my $buffer;
	\$buffer = undef;
	my $buflength = 4096;
	
	my $wrq = new iwreq;
	$context = new wireless_scan_head;
 	$context->retry++;
	if( $context->retry >= 150 ){
	  return -1;
	}
	if( $context->retry == 1 ){
		$wrq->u->data->pointer = undef;
		$wrq->u->data->flags = 0;
		$wrq->u->data->length = 0;
		if(&iw_set_ext(skfd, ifname, $ioctl, &wrq) < 0 ){
			return(-1);
		}
			}

}

sub iw_scan{
	my( $skfd, $ifname, $we_version, $context ) = @_;
	my $delay;
	# Security check
	# this is done against buffer overflows
	if(! undef(wireless_scan_head->result)){
		wireless_scan_head->result = undef;
	}
	wireless_scan_head->retry = 0;
	
	while(1){
	  my $delay = &iw_process_scan( $skfd, \$ifname, $we_version, $context);
	  if($delay <= 0){
	    last;
		}
	  sleep($delay * 1000);
	}
	  return( $delay );
}


our %EXPORT_TAGS = (
	ioctl => [qw(
       SIOCSIWCOMMIT
       SIOCGIWNAME
       SIOCSIWNWID
       SIOCGIWNWID
       SIOCSIWFREQ
       SIOCGIWFREQ
       SIOCSIWMODE
       SIOCGIWMODE
       SIOCSIWSENS
       SIOCGIWSENS
       SIOCSIWRANGE
       SIOCGIWRANGE
       SIOCSIWPRIV
       SIOCGIWPRIV
       SIOCSIWSTATS
       SIOCGIWSTATS
       SIOCSIWSPY
       SIOCGIWSPY
       SIOCSIWTHRSPY
       SIOCGIWTHRSPY
       SIOCSIWAP
       SIOCGIWAP
       SIOCGIWAPLIST
       SIOCSIWSCAN
       SIOCGIWSCAN
       SIOCSIWESSID
       SIOCGIWESSID
       SIOCSIWNICKN
       SIOCGIWNICKN
       SIOCSIWRATE
       SIOCGIWRATE
       SIOCSIWRTS
       SIOCGIWRTS
       SIOCSIWFRAG
       SIOCGIWFRAG
       SIOCSIWTXPOW
       SIOCGIWTXPOW
       SIOCSIWRETRY
       SIOCGIWRETRY
       SIOCSIWENCODE
       SIOCGIWENCODE
       SIOCSIWPOWER
       SIOCGIWPOWER
       SIOCSIWMODUL
       SIOCGIWMODUL
       SIOCSIWGENIE
       SIOCGIWGENIE
       SIOCSIWMLME
       SIOCSIWAUTH
       SIOCGIWAUTH
       SIOCSIWENCODEEXT
       SIOCGIWENCODEEXT
       SIOCSIWPMKSA
       SIOCIWFIRSTPRIV
       SIOCIWLASTPRIV
       SIOCIWFIRST
       SIOCIWLAST
)],
   utils => [qw(
	iw_get_kernel_we_version
	iw_set_ext
	iw_get_ext
	iw_process_scan
	iw_scan
)],
	);

__PACKAGE__->bootstrap($VERSION);

1;

__END__

