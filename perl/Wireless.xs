#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <iwlib.h>

MODULE:Air::Wireless        PACKAGE:Air::Wireless
PROTOTYPES: DISABLE

int
iw_sockets_open()
  
int
iw_get_kernel_we_version()
  
int
iw_get_range_info(skfd,  ifname, range)
	int skfd
	const char * ifname
	iwrange *range
	
int
iw_get_priv_info(skfd, ifname, ppriv)
	int skfd 
	char *ifname
	iwprivargs **ppriv
	
int
iw_get_basic_config(skfd, ifname, info)
	int skfd
	char *	ifname
	wireless_config *info
	
int
iw_set_basic_config(skfd,  ifname, info)
	int skfd
	char * ifname
	wireless_config *info
	
int
iw_protocol_compare(protocol1, protocol2)
	char * protocol1
	char * protocol2
	
void
iw_print_bitrate(buffer, buflen, bitrate)
	char *	buffer
	int buflen
	int bitrate
	
int
iw_get_stats(skfd, ifname, stats, range,  has_range)
	int skfd
	char * ifname
	iwstats * stats
	iwrange * range
	int has_range
	
void
iw_print_stats(buffer, buflen, qual, range, has_range)
	char * buffer
	int buflen,
	iwqual *qual
	iwrange *range
	int has_range
	

void
iw_init_event_stream(stream, data, length)
	struct stream_descr *	stream
	char *data
	int length
	
int
iw_extract_event_stream(stream, iwe,  we_version)
	struct stream_descr *	stream
	struct iw_event * iwe
	int we_version
	
int
iw_process_scan(skfd, ifname,  we_version, context)
	int skfd
	char * ifname
	int  we_version
	wireless_scan_head *context
	
int
iw_scan(skfd, ifname,  we_version, context)
	int skfd
	char * ifname
	int we_version
	wireless_scan_head *context
	
