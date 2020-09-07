package Air::Wireless;

use strict;
use warnings;

our $VERSION = '0.7';
use base qw(Exporter DynaLoader);

our %EXPORT_TAGS = (
  utils => [qw(
    iw_sockets_open
    iw_get_kernel_we_version
    iw_get_range_info
    iw_get_priv_info
    iw_get_basic_config
    iw_set_basic_config
    iw_protocol_compare
    iw_print_bitrate
    iw_get_stats
    iw_print_stats
    iw_init_event_stream
    iw_extract_event_stream
    iw_process_scan
    iw_scan
  )],
);

__PACKAGE__->bootstrap($VERSION);

1;

__END__
