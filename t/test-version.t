# Made by Edoardo Mantovani, 2020

use Test;
use strict;
use warnings;

BEGIN { plan tests => 1 };

use Air::Wireless qw(:utils); 

if(undef(  Air::Wireless::iw_get_kernel_we_version() ) ) {
  ok(0);# Return a value
}else{
ok(1);
}
