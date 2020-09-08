no strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => 'Air::Wireless',
   LICENSE => 'perl',
   AUTHOR => 'Edoardo Mantovani aka Baseband',
   DEFINE => '',
   VERSION_FROM => 'lib/Air/Wireless.pm',
   MIN_PERL_VERSION => '5.22.1',
   PREREQ_PM => {
  },
);
