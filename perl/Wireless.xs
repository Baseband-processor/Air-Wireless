#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <iwlib.h>


TYPEMAP: <<WIRELESS

const char *        T_PV
const u_char *      T_PV
u_char **           T_PV
u_char *            T_PV
char *              T_PV
int *               T_PV
int **              T_PV
const void *        T_PV
void                T_PV
void *              T_PV
void **             T_PV
unsigned long int   T_U_LONG
uint8_t             T_U_SHORT
uint8_t *           T_U_SHORT
uint16_t            T_U_SHORT
uint16_t *          T_U_SHORT
uint64_t            T_U_SHORT
unsigned int        T_PV
unsigned int *      T_PV
const u8 *          T_PV
const char *        T_PV
const u_char *      T_PV
u_char *            T_PV
char *              T_PV
int *               T_PV
void *              T_PV
void **             T_PV
unsigned long int   T_U_LONG
uint8_t             T_U_SHORT
uint8_t *           T_U_SHORT
unsigned int        T_PV
unsigned int *      T_PV
bpf_u_int32         T_PV
u8                  T_U_SHORT
u16                 T_U_SHORT
u8 *                T_U_SHORT
u16 *               T_U_SHORT
int		    T_IV
unsigned	    T_UV
unsigned int	    T_UV
long		    T_IV
unsigned long	    T_UV
short		    T_IV
short *             T_IV
unsigned short	    T_UV
char		    T_CHAR
unsigned char	    T_U_CHAR
char *		    T_PV
unsigned char *     T_PV
const char *	    T_PV
caddr_t			    T_PV
wchar_t *		    T_PV
wchar_t			    T_IV
bool_t			    T_IV
size_t			    T_UV
ssize_t			    T_IV
time_t			    T_NV
unsigned long *		    T_OPAQUEPTR
char **			    T_PACKEDARRAY
void *			    T_PTR
Time_t *		    T_PV
SV              	    T_SV
SV *			    T_SV

SVREF			T_SVREF
CV *			T_CVREF
AV *			T_AVREF
HV *			T_HVREF

IV			T_IV
UV			T_UV
NV      		T_NV
I32			T_IV
I16			T_IV
I8			T_IV
STRLEN			T_UV
U32			T_U_LONG
U16			T_U_SHORT
U8			T_UV
u8   			T_UV
Result			T_U_CHAR
Boolean			T_BOOL
float    		T_FLOAT
double			T_DOUBLE
SysRet			T_SYSRET
SysRetLong		T_SYSRET
FILE *			T_STDIO
PerlIO *		T_INOUT
FileHandle		T_PTROBJ
InputStream		T_IN
InOutStream		T_INOUT
OutputStream		T_OUT
bool			T_BOOL

WIRELESS

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
	
