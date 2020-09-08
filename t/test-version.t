# Made by Edoardo Mantovani, 2020

use Test;
use strict;
use warnings;

BEGIN { plan tests => 1 };

use Air::Wireless qw(:utils); 

print Air::Wireless::iw_get_kernel_we_version(); # Return a value

ok(1);
