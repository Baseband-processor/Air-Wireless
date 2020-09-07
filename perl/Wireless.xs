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
iw_get_range_info(int skfd,  const char *	ifname, iwrange *	range)

int
iw_get_priv_info(int skfd, const char *ifname, iwprivargs **	ppriv)

int
iw_get_basic_config(int skfd, const char *	ifname, wireless_config *	info)
	
int
iw_set_basic_config(int skfd, const char * ifname, wireless_config *	info)

int
iw_protocol_compare(const char * protocol1, const char * protocol2)

void
iw_print_bitrate(char *	buffer, int	buflen, int	bitrate);

int
iw_get_stats(int skfd, const char * ifname, iwstats * stats, const iwrange * range, int has_range)
	
void
iw_print_stats(char * buffer,
		       int		buflen,
		       const iwqual *	qual,
		       const iwrange *	range,
		       int		has_range)

void
iw_init_event_stream(struct stream_descr *	stream, char *data,int len)
	
int
iw_extract_event_stream(struct stream_descr *	stream, struct iw_event * iwe, int we_version)

int
iw_process_scan(int skfd, char * ifname, int  we_version, wireless_scan_head *	context)

int
iw_scan(int skfd, char * ifname, int we_version, wireless_scan_head *	context)
