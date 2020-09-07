C_WIRELESS_DIR=wireless_tools
PERL_WIRELESS_DIR=perl
TMP_INSTALL_DIR=${PWD}/usr
default: all
clean:
	(cd $(C_LORCON_DIR); make clean) && \
	(cd $(PERL_AIR_LORCON_DIR); make clean)
all: CT perlT

CT:

	"INSTALLING WIRELESS C LIBRARY\n"
	(cd ./$(C_WIRELESS_DIR) && chmod 755 ./configure && ./configure  && sudo make && make install)
perlT:
	(cd ./$(PERL_WIRELESS_DIR) && sudo perl Makefile.PL  && make && make test && make install )
