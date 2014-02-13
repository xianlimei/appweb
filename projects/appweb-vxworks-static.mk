#
#   appweb-vxworks-static.mk -- Makefile to build Embedthis Appweb for vxworks
#

PRODUCT            := appweb
VERSION            := 4.5.0
PROFILE            := static
ARCH               := $(shell echo $(WIND_HOST_TYPE) | sed 's/-.*//')
CPU                := $(subst X86,PENTIUM,$(shell echo $(ARCH) | tr a-z A-Z))
OS                 := vxworks
CC                 := cc$(subst x86,pentium,$(ARCH))
LD                 := link
CONFIG             := $(OS)-$(ARCH)-$(PROFILE)
LBIN               := $(CONFIG)/bin

BIT_PACK_CGI       := 1
BIT_PACK_EJSCRIPT  := 0
BIT_PACK_ESP       := 1
BIT_PACK_EST       := 0
BIT_PACK_MATRIXSSL := 0
BIT_PACK_MDB       := 1
BIT_PACK_NANOSSL   := 0
BIT_PACK_OPENSSL   := 0
BIT_PACK_PCRE      := 1
BIT_PACK_PHP       := 0
BIT_PACK_SDB       := 0
BIT_PACK_SQLITE    := 0
BIT_PACK_SSL       := 0

ifeq ($(BIT_PACK_EST),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_LIB),1)
    BIT_PACK_COMPILER := 1
endif
ifeq ($(BIT_PACK_MATRIXSSL),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_MDB),1)
    BIT_PACK_ESP := 1
endif
ifeq ($(BIT_PACK_NANOSSL),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_SDB),1)
    BIT_PACK_ESP := 1
    BIT_PACK_SQLITE := 1
endif

BIT_PACK_CGI_PATH         := cgi
BIT_PACK_COMPILER_PATH    := cc$(subst x86,pentium,$(ARCH))
BIT_PACK_DIR_PATH         := dir
BIT_PACK_DOXYGEN_PATH     := doxygen
BIT_PACK_DSI_PATH         := dsi
BIT_PACK_EJSCRIPT_PATH    := ejscript
BIT_PACK_ESP_PATH         := esp
BIT_PACK_EST_PATH         := est
BIT_PACK_GZIP_PATH        := gzip
BIT_PACK_HTMLMIN_PATH     := htmlmin
BIT_PACK_LIB_PATH         := ar
BIT_PACK_LINK_PATH        := link
BIT_PACK_MAN_PATH         := man
BIT_PACK_MAN2HTML_PATH    := man2html
BIT_PACK_MATRIXSSL_PATH   := /usr/src/matrixssl
BIT_PACK_MDB_PATH         := mdb
BIT_PACK_NANOSSL_PATH     := /usr/src/nanossl
BIT_PACK_NGMIN_PATH       := ngmin
BIT_PACK_OPENSSL_PATH     := /usr/src/openssl
BIT_PACK_PAK_PATH         := pak
BIT_PACK_PCRE_PATH        := pcre
BIT_PACK_PHP_PATH         := /usr/src/php
BIT_PACK_PMAKER_PATH      := pmaker
BIT_PACK_RECESS_PATH      := recess
BIT_PACK_SDB_PATH         := sdb
BIT_PACK_SQLITE_PATH      := sqlite
BIT_PACK_SSL_PATH         := ssl
BIT_PACK_UGLIFYJS_PATH    := uglifyjs
BIT_PACK_UTEST_PATH       := utest
BIT_PACK_VXWORKS_PATH     := $(WIND_BASE)
BIT_PACK_ZIP_PATH         := zip

export WIND_HOME          := $(WIND_BASE)/..
export PATH               := $(WIND_GNU_PATH)/$(WIND_HOST_TYPE)/bin:$(PATH)

CFLAGS             += -fno-builtin -fno-defer-pop -fvolatile -w
DFLAGS             += -DVXWORKS -DRW_MULTI_THREAD -D_GNU_TOOL -DCPU=PENTIUM $(patsubst %,-D%,$(filter BIT_%,$(MAKEFLAGS))) -DBIT_PACK_CGI=$(BIT_PACK_CGI) -DBIT_PACK_EJSCRIPT=$(BIT_PACK_EJSCRIPT) -DBIT_PACK_ESP=$(BIT_PACK_ESP) -DBIT_PACK_EST=$(BIT_PACK_EST) -DBIT_PACK_MATRIXSSL=$(BIT_PACK_MATRIXSSL) -DBIT_PACK_MDB=$(BIT_PACK_MDB) -DBIT_PACK_NANOSSL=$(BIT_PACK_NANOSSL) -DBIT_PACK_OPENSSL=$(BIT_PACK_OPENSSL) -DBIT_PACK_PCRE=$(BIT_PACK_PCRE) -DBIT_PACK_PHP=$(BIT_PACK_PHP) -DBIT_PACK_SDB=$(BIT_PACK_SDB) -DBIT_PACK_SQLITE=$(BIT_PACK_SQLITE) -DBIT_PACK_SSL=$(BIT_PACK_SSL) 
IFLAGS             += "-I$(CONFIG)/inc -I$(WIND_BASE)/target/h -I$(WIND_BASE)/target/h/wrn/coreip"
LDFLAGS            += '-Wl,-r'
LIBPATHS           += -L$(CONFIG)/bin
LIBS               += -lgcc

DEBUG              := debug
CFLAGS-debug       := -g
DFLAGS-debug       := -DBIT_DEBUG
LDFLAGS-debug      := -g
DFLAGS-release     := 
CFLAGS-release     := -O2
LDFLAGS-release    := 
CFLAGS             += $(CFLAGS-$(DEBUG))
DFLAGS             += $(DFLAGS-$(DEBUG))
LDFLAGS            += $(LDFLAGS-$(DEBUG))

BIT_ROOT_PREFIX    := deploy
BIT_BASE_PREFIX    := $(BIT_ROOT_PREFIX)
BIT_DATA_PREFIX    := $(BIT_VAPP_PREFIX)
BIT_STATE_PREFIX   := $(BIT_VAPP_PREFIX)
BIT_BIN_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_INC_PREFIX     := $(BIT_VAPP_PREFIX)/inc
BIT_LIB_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_MAN_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_SBIN_PREFIX    := $(BIT_VAPP_PREFIX)
BIT_ETC_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_WEB_PREFIX     := $(BIT_VAPP_PREFIX)/web
BIT_LOG_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_SPOOL_PREFIX   := $(BIT_VAPP_PREFIX)
BIT_CACHE_PREFIX   := $(BIT_VAPP_PREFIX)
BIT_APP_PREFIX     := $(BIT_BASE_PREFIX)
BIT_VAPP_PREFIX    := $(BIT_APP_PREFIX)
BIT_SRC_PREFIX     := $(BIT_ROOT_PREFIX)/usr/src/$(PRODUCT)-$(VERSION)


TARGETS            += $(CONFIG)/bin/libmpr.a
TARGETS            += $(CONFIG)/bin/libmprssl.a
TARGETS            += $(CONFIG)/bin/appman.out
TARGETS            += $(CONFIG)/bin/makerom.out
TARGETS            += $(CONFIG)/bin/ca.crt
ifeq ($(BIT_PACK_PCRE),1)
TARGETS            += $(CONFIG)/bin/libpcre.a
endif
TARGETS            += $(CONFIG)/bin/libhttp.a
TARGETS            += $(CONFIG)/bin/http.out
ifeq ($(BIT_PACK_SQLITE),1)
TARGETS            += $(CONFIG)/bin/libsql.a
endif
ifeq ($(BIT_PACK_SQLITE),1)
TARGETS            += $(CONFIG)/bin/sqlite.out
endif
TARGETS            += $(CONFIG)/bin/libappweb.a
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/bin/libmod_esp.a
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/bin/esp.out
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/bin/esp.conf
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += src/server/esp.conf
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/paks
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/libejs.a
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/ejs.out
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/ejsc.out
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/ejs.mod
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += $(CONFIG)/bin/libmod_cgi.a
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/libmod_ejs.a
endif
ifeq ($(BIT_PACK_PHP),1)
TARGETS            += $(CONFIG)/bin/libmod_php.a
endif
ifeq ($(BIT_PACK_SSL),1)
TARGETS            += $(CONFIG)/bin/libmod_ssl.a
endif
TARGETS            += $(CONFIG)/bin/authpass.out
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += $(CONFIG)/bin/cgiProgram.out
endif
TARGETS            += src/server/slink.c
TARGETS            += $(CONFIG)/bin/libslink.a
TARGETS            += $(CONFIG)/bin/appweb.out
TARGETS            += src/server/cache
TARGETS            += $(CONFIG)/bin/testAppweb.out
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/cgi-bin/testScript
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/web/caching/cache.cgi
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/web/auth/basic/basic.cgi
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/cgi-bin/cgiProgram.out
endif

unexport CDPATH

ifndef SHOW
.SILENT:
endif

all build compile: prep $(TARGETS)

.PHONY: prep

prep:
	@echo "      [Info] Use "make SHOW=1" to trace executed commands."
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(BIT_APP_PREFIX)" = "" ] ; then echo WARNING: BIT_APP_PREFIX not set ; exit 255 ; fi
	@if [ "$(WIND_BASE)" = "" ] ; then echo WARNING: WIND_BASE not set. Run wrenv.sh. ; exit 255 ; fi
	@if [ "$(WIND_HOST_TYPE)" = "" ] ; then echo WARNING: WIND_HOST_TYPE not set. Run wrenv.sh. ; exit 255 ; fi
	@if [ "$(WIND_GNU_PATH)" = "" ] ; then echo WARNING: WIND_GNU_PATH not set. Run wrenv.sh. ; exit 255 ; fi
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/bitos.h ] && cp src/bitos.h $(CONFIG)/inc/bitos.h ; true
	@if ! diff $(CONFIG)/inc/bitos.h src/bitos.h >/dev/null ; then\
		cp src/bitos.h $(CONFIG)/inc/bitos.h  ; \
	fi; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/appweb-vxworks-static-bit.h $(CONFIG)/inc/bit.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/appweb-vxworks-static-bit.h >/dev/null ; then\
		cp projects/appweb-vxworks-static-bit.h $(CONFIG)/inc/bit.h  ; \
	fi; true
	@if [ -f "$(CONFIG)/.makeflags" ] ; then \
		if [ "$(MAKEFLAGS)" != " ` cat $(CONFIG)/.makeflags`" ] ; then \
			echo "   [Warning] Make flags have changed since the last build: "`cat $(CONFIG)/.makeflags`"" ; \
		fi ; \
	fi
	@echo $(MAKEFLAGS) >$(CONFIG)/.makeflags

clean:
	rm -f "$(CONFIG)/bin/libmpr.a"
	rm -f "$(CONFIG)/bin/libmprssl.a"
	rm -f "$(CONFIG)/bin/appman.out"
	rm -f "$(CONFIG)/bin/makerom.out"
	rm -f "$(CONFIG)/bin/libest.a"
	rm -f "$(CONFIG)/bin/ca.crt"
	rm -f "$(CONFIG)/bin/libpcre.a"
	rm -f "$(CONFIG)/bin/libhttp.a"
	rm -f "$(CONFIG)/bin/http.out"
	rm -f "$(CONFIG)/bin/libsql.a"
	rm -f "$(CONFIG)/bin/sqlite.out"
	rm -f "$(CONFIG)/bin/libappweb.a"
	rm -f "$(CONFIG)/bin/libmod_esp.a"
	rm -f "$(CONFIG)/bin/esp.out"
	rm -f "$(CONFIG)/bin/esp.conf"
	rm -f "src/server/esp.conf"
	rm -f "$(CONFIG)/bin/libejs.a"
	rm -f "$(CONFIG)/bin/ejs.out"
	rm -f "$(CONFIG)/bin/ejsc.out"
	rm -f "$(CONFIG)/bin/libmod_cgi.a"
	rm -f "$(CONFIG)/bin/libmod_ejs.a"
	rm -f "$(CONFIG)/bin/libmod_php.a"
	rm -f "$(CONFIG)/bin/libmod_ssl.a"
	rm -f "$(CONFIG)/bin/authpass.out"
	rm -f "$(CONFIG)/bin/cgiProgram.out"
	rm -f "$(CONFIG)/bin/libslink.a"
	rm -f "$(CONFIG)/bin/appweb.out"
	rm -f "$(CONFIG)/bin/testAppweb.out"
	rm -f "$(CONFIG)/obj/mprLib.o"
	rm -f "$(CONFIG)/obj/mprSsl.o"
	rm -f "$(CONFIG)/obj/manager.o"
	rm -f "$(CONFIG)/obj/makerom.o"
	rm -f "$(CONFIG)/obj/estLib.o"
	rm -f "$(CONFIG)/obj/pcre.o"
	rm -f "$(CONFIG)/obj/httpLib.o"
	rm -f "$(CONFIG)/obj/http.o"
	rm -f "$(CONFIG)/obj/sqlite3.o"
	rm -f "$(CONFIG)/obj/sqlite.o"
	rm -f "$(CONFIG)/obj/config.o"
	rm -f "$(CONFIG)/obj/convenience.o"
	rm -f "$(CONFIG)/obj/dirHandler.o"
	rm -f "$(CONFIG)/obj/fileHandler.o"
	rm -f "$(CONFIG)/obj/log.o"
	rm -f "$(CONFIG)/obj/server.o"
	rm -f "$(CONFIG)/obj/edi.o"
	rm -f "$(CONFIG)/obj/espAbbrev.o"
	rm -f "$(CONFIG)/obj/espDeprecated.o"
	rm -f "$(CONFIG)/obj/espFramework.o"
	rm -f "$(CONFIG)/obj/espHandler.o"
	rm -f "$(CONFIG)/obj/espHtml.o"
	rm -f "$(CONFIG)/obj/espTemplate.o"
	rm -f "$(CONFIG)/obj/mdb.o"
	rm -f "$(CONFIG)/obj/sdb.o"
	rm -f "$(CONFIG)/obj/esp.o"
	rm -f "$(CONFIG)/obj/ejsLib.o"
	rm -f "$(CONFIG)/obj/ejs.o"
	rm -f "$(CONFIG)/obj/ejsc.o"
	rm -f "$(CONFIG)/obj/cgiHandler.o"
	rm -f "$(CONFIG)/obj/ejsHandler.o"
	rm -f "$(CONFIG)/obj/phpHandler.o"
	rm -f "$(CONFIG)/obj/sslModule.o"
	rm -f "$(CONFIG)/obj/authpass.o"
	rm -f "$(CONFIG)/obj/cgiProgram.o"
	rm -f "$(CONFIG)/obj/slink.o"
	rm -f "$(CONFIG)/obj/appweb.o"
	rm -f "$(CONFIG)/obj/testAppweb.o"
	rm -f "$(CONFIG)/obj/testHttp.o"

clobber: clean
	rm -fr ./$(CONFIG)



#
#   version
#
version: $(DEPS_1)
	echo 4.5.0

#
#   mpr.h
#
$(CONFIG)/inc/mpr.h: $(DEPS_2)
	@echo '      [Copy] $(CONFIG)/inc/mpr.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/mpr/mpr.h $(CONFIG)/inc/mpr.h

#
#   bit.h
#
$(CONFIG)/inc/bit.h: $(DEPS_3)
	@echo '      [Copy] $(CONFIG)/inc/bit.h'

#
#   bitos.h
#
DEPS_4 += $(CONFIG)/inc/bit.h

$(CONFIG)/inc/bitos.h: $(DEPS_4)
	@echo '      [Copy] $(CONFIG)/inc/bitos.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/bitos.h $(CONFIG)/inc/bitos.h

#
#   mprLib.o
#
DEPS_5 += $(CONFIG)/inc/bit.h
DEPS_5 += $(CONFIG)/inc/mpr.h
DEPS_5 += $(CONFIG)/inc/bitos.h

$(CONFIG)/obj/mprLib.o: \
    src/paks/mpr/mprLib.c $(DEPS_5)
	@echo '   [Compile] $(CONFIG)/obj/mprLib.o'
	$(CC) -c -o $(CONFIG)/obj/mprLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/mprLib.c

#
#   libmpr
#
DEPS_6 += $(CONFIG)/inc/mpr.h
DEPS_6 += $(CONFIG)/inc/bit.h
DEPS_6 += $(CONFIG)/inc/bitos.h
DEPS_6 += $(CONFIG)/obj/mprLib.o

$(CONFIG)/bin/libmpr.a: $(DEPS_6)
	@echo '      [Link] $(CONFIG)/bin/libmpr.a'
	ar -cr $(CONFIG)/bin/libmpr.a "$(CONFIG)/obj/mprLib.o"

#
#   est.h
#
$(CONFIG)/inc/est.h: $(DEPS_7)
	@echo '      [Copy] $(CONFIG)/inc/est.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/est/est.h $(CONFIG)/inc/est.h

#
#   estLib.o
#
DEPS_8 += $(CONFIG)/inc/bit.h
DEPS_8 += $(CONFIG)/inc/est.h
DEPS_8 += $(CONFIG)/inc/bitos.h

$(CONFIG)/obj/estLib.o: \
    src/paks/est/estLib.c $(DEPS_8)
	@echo '   [Compile] $(CONFIG)/obj/estLib.o'
	$(CC) -c -o $(CONFIG)/obj/estLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/est/estLib.c

ifeq ($(BIT_PACK_EST),1)
#
#   libest
#
DEPS_9 += $(CONFIG)/inc/est.h
DEPS_9 += $(CONFIG)/inc/bit.h
DEPS_9 += $(CONFIG)/inc/bitos.h
DEPS_9 += $(CONFIG)/obj/estLib.o

$(CONFIG)/bin/libest.a: $(DEPS_9)
	@echo '      [Link] $(CONFIG)/bin/libest.a'
	ar -cr $(CONFIG)/bin/libest.a "$(CONFIG)/obj/estLib.o"
endif

#
#   mprSsl.o
#
DEPS_10 += $(CONFIG)/inc/bit.h
DEPS_10 += $(CONFIG)/inc/mpr.h
DEPS_10 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/mprSsl.o: \
    src/paks/mpr/mprSsl.c $(DEPS_10)
	@echo '   [Compile] $(CONFIG)/obj/mprSsl.o'
	$(CC) -c -o $(CONFIG)/obj/mprSsl.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-I$(BIT_PACK_MATRIXSSL_PATH)" "-I$(BIT_PACK_MATRIXSSL_PATH)/matrixssl" "-I$(BIT_PACK_NANOSSL_PATH)/src" "-I$(BIT_PACK_OPENSSL_PATH)/include" src/paks/mpr/mprSsl.c

#
#   libmprssl
#
DEPS_11 += $(CONFIG)/inc/mpr.h
DEPS_11 += $(CONFIG)/inc/bit.h
DEPS_11 += $(CONFIG)/inc/bitos.h
DEPS_11 += $(CONFIG)/obj/mprLib.o
DEPS_11 += $(CONFIG)/bin/libmpr.a
DEPS_11 += $(CONFIG)/inc/est.h
DEPS_11 += $(CONFIG)/obj/estLib.o
ifeq ($(BIT_PACK_EST),1)
    DEPS_11 += $(CONFIG)/bin/libest.a
endif
DEPS_11 += $(CONFIG)/obj/mprSsl.o

$(CONFIG)/bin/libmprssl.a: $(DEPS_11)
	@echo '      [Link] $(CONFIG)/bin/libmprssl.a'
	ar -cr $(CONFIG)/bin/libmprssl.a "$(CONFIG)/obj/mprSsl.o"

#
#   manager.o
#
DEPS_12 += $(CONFIG)/inc/bit.h
DEPS_12 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/manager.o: \
    src/paks/mpr/manager.c $(DEPS_12)
	@echo '   [Compile] $(CONFIG)/obj/manager.o'
	$(CC) -c -o $(CONFIG)/obj/manager.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/manager.c

#
#   manager
#
DEPS_13 += $(CONFIG)/inc/mpr.h
DEPS_13 += $(CONFIG)/inc/bit.h
DEPS_13 += $(CONFIG)/inc/bitos.h
DEPS_13 += $(CONFIG)/obj/mprLib.o
DEPS_13 += $(CONFIG)/bin/libmpr.a
DEPS_13 += $(CONFIG)/obj/manager.o

LIBS_13 += -lmpr

$(CONFIG)/bin/appman.out: $(DEPS_13)
	@echo '      [Link] $(CONFIG)/bin/appman.out'
	$(CC) -o $(CONFIG)/bin/appman.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/manager.o" $(LIBPATHS_13) $(LIBS_13) $(LIBS_13) $(LIBS) -Wl,-r 

#
#   makerom.o
#
DEPS_14 += $(CONFIG)/inc/bit.h
DEPS_14 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/makerom.o: \
    src/paks/mpr/makerom.c $(DEPS_14)
	@echo '   [Compile] $(CONFIG)/obj/makerom.o'
	$(CC) -c -o $(CONFIG)/obj/makerom.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/makerom.c

#
#   makerom
#
DEPS_15 += $(CONFIG)/inc/mpr.h
DEPS_15 += $(CONFIG)/inc/bit.h
DEPS_15 += $(CONFIG)/inc/bitos.h
DEPS_15 += $(CONFIG)/obj/mprLib.o
DEPS_15 += $(CONFIG)/bin/libmpr.a
DEPS_15 += $(CONFIG)/obj/makerom.o

LIBS_15 += -lmpr

$(CONFIG)/bin/makerom.out: $(DEPS_15)
	@echo '      [Link] $(CONFIG)/bin/makerom.out'
	$(CC) -o $(CONFIG)/bin/makerom.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/makerom.o" $(LIBPATHS_15) $(LIBS_15) $(LIBS_15) $(LIBS) -Wl,-r 

#
#   ca-crt
#
DEPS_16 += src/paks/est/ca.crt

$(CONFIG)/bin/ca.crt: $(DEPS_16)
	@echo '      [Copy] $(CONFIG)/bin/ca.crt'
	mkdir -p "$(CONFIG)/bin"
	cp src/paks/est/ca.crt $(CONFIG)/bin/ca.crt

#
#   pcre.h
#
$(CONFIG)/inc/pcre.h: $(DEPS_17)
	@echo '      [Copy] $(CONFIG)/inc/pcre.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/pcre/pcre.h $(CONFIG)/inc/pcre.h

#
#   pcre.o
#
DEPS_18 += $(CONFIG)/inc/bit.h
DEPS_18 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/pcre.o: \
    src/paks/pcre/pcre.c $(DEPS_18)
	@echo '   [Compile] $(CONFIG)/obj/pcre.o'
	$(CC) -c -o $(CONFIG)/obj/pcre.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/pcre/pcre.c

ifeq ($(BIT_PACK_PCRE),1)
#
#   libpcre
#
DEPS_19 += $(CONFIG)/inc/pcre.h
DEPS_19 += $(CONFIG)/inc/bit.h
DEPS_19 += $(CONFIG)/obj/pcre.o

$(CONFIG)/bin/libpcre.a: $(DEPS_19)
	@echo '      [Link] $(CONFIG)/bin/libpcre.a'
	ar -cr $(CONFIG)/bin/libpcre.a "$(CONFIG)/obj/pcre.o"
endif

#
#   http.h
#
$(CONFIG)/inc/http.h: $(DEPS_20)
	@echo '      [Copy] $(CONFIG)/inc/http.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/http/http.h $(CONFIG)/inc/http.h

#
#   httpLib.o
#
DEPS_21 += $(CONFIG)/inc/bit.h
DEPS_21 += $(CONFIG)/inc/http.h
DEPS_21 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/httpLib.o: \
    src/paks/http/httpLib.c $(DEPS_21)
	@echo '   [Compile] $(CONFIG)/obj/httpLib.o'
	$(CC) -c -o $(CONFIG)/obj/httpLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/http/httpLib.c

#
#   libhttp
#
DEPS_22 += $(CONFIG)/inc/mpr.h
DEPS_22 += $(CONFIG)/inc/bit.h
DEPS_22 += $(CONFIG)/inc/bitos.h
DEPS_22 += $(CONFIG)/obj/mprLib.o
DEPS_22 += $(CONFIG)/bin/libmpr.a
DEPS_22 += $(CONFIG)/inc/pcre.h
DEPS_22 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_22 += $(CONFIG)/bin/libpcre.a
endif
DEPS_22 += $(CONFIG)/inc/http.h
DEPS_22 += $(CONFIG)/obj/httpLib.o

$(CONFIG)/bin/libhttp.a: $(DEPS_22)
	@echo '      [Link] $(CONFIG)/bin/libhttp.a'
	ar -cr $(CONFIG)/bin/libhttp.a "$(CONFIG)/obj/httpLib.o"

#
#   http.o
#
DEPS_23 += $(CONFIG)/inc/bit.h
DEPS_23 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/http.o: \
    src/paks/http/http.c $(DEPS_23)
	@echo '   [Compile] $(CONFIG)/obj/http.o'
	$(CC) -c -o $(CONFIG)/obj/http.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-I$(BIT_PACK_MATRIXSSL_PATH)" "-I$(BIT_PACK_MATRIXSSL_PATH)/matrixssl" "-I$(BIT_PACK_NANOSSL_PATH)/src" "-I$(BIT_PACK_OPENSSL_PATH)/include" src/paks/http/http.c

#
#   http
#
DEPS_24 += $(CONFIG)/inc/mpr.h
DEPS_24 += $(CONFIG)/inc/bit.h
DEPS_24 += $(CONFIG)/inc/bitos.h
DEPS_24 += $(CONFIG)/obj/mprLib.o
DEPS_24 += $(CONFIG)/bin/libmpr.a
DEPS_24 += $(CONFIG)/inc/pcre.h
DEPS_24 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_24 += $(CONFIG)/bin/libpcre.a
endif
DEPS_24 += $(CONFIG)/inc/http.h
DEPS_24 += $(CONFIG)/obj/httpLib.o
DEPS_24 += $(CONFIG)/bin/libhttp.a
DEPS_24 += $(CONFIG)/inc/est.h
DEPS_24 += $(CONFIG)/obj/estLib.o
ifeq ($(BIT_PACK_EST),1)
    DEPS_24 += $(CONFIG)/bin/libest.a
endif
DEPS_24 += $(CONFIG)/obj/mprSsl.o
DEPS_24 += $(CONFIG)/bin/libmprssl.a
DEPS_24 += $(CONFIG)/obj/http.o

LIBS_24 += -lhttp
LIBS_24 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_24 += -lpcre
endif
LIBS_24 += -lmprssl
ifeq ($(BIT_PACK_EST),1)
    LIBS_24 += -lest
endif
ifeq ($(BIT_PACK_MATRIXSSL),1)
    LIBS_24 += -lmatrixssl
    LIBPATHS_24 += -L$(BIT_PACK_MATRIXSSL_PATH)
endif
ifeq ($(BIT_PACK_NANOSSL),1)
    LIBS_24 += -lssls
    LIBPATHS_24 += -L$(BIT_PACK_NANOSSL_PATH)/bin
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_24 += -lssl
    LIBPATHS_24 += -L$(BIT_PACK_OPENSSL_PATH)
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_24 += -lcrypto
    LIBPATHS_24 += -L$(BIT_PACK_OPENSSL_PATH)
endif

$(CONFIG)/bin/http.out: $(DEPS_24)
	@echo '      [Link] $(CONFIG)/bin/http.out'
	$(CC) -o $(CONFIG)/bin/http.out $(LDFLAGS) $(LIBPATHS)    "$(CONFIG)/obj/http.o" $(LIBPATHS_24) $(LIBS_24) $(LIBS_24) $(LIBS) -Wl,-r 

#
#   sqlite3.h
#
$(CONFIG)/inc/sqlite3.h: $(DEPS_25)
	@echo '      [Copy] $(CONFIG)/inc/sqlite3.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/sqlite/sqlite3.h $(CONFIG)/inc/sqlite3.h

#
#   sqlite3.o
#
DEPS_26 += $(CONFIG)/inc/bit.h
DEPS_26 += $(CONFIG)/inc/sqlite3.h

$(CONFIG)/obj/sqlite3.o: \
    src/paks/sqlite/sqlite3.c $(DEPS_26)
	@echo '   [Compile] $(CONFIG)/obj/sqlite3.o'
	$(CC) -c -o $(CONFIG)/obj/sqlite3.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/sqlite/sqlite3.c

ifeq ($(BIT_PACK_SQLITE),1)
#
#   libsql
#
DEPS_27 += $(CONFIG)/inc/sqlite3.h
DEPS_27 += $(CONFIG)/inc/bit.h
DEPS_27 += $(CONFIG)/obj/sqlite3.o

$(CONFIG)/bin/libsql.a: $(DEPS_27)
	@echo '      [Link] $(CONFIG)/bin/libsql.a'
	ar -cr $(CONFIG)/bin/libsql.a "$(CONFIG)/obj/sqlite3.o"
endif

#
#   sqlite.o
#
DEPS_28 += $(CONFIG)/inc/bit.h
DEPS_28 += $(CONFIG)/inc/sqlite3.h

$(CONFIG)/obj/sqlite.o: \
    src/paks/sqlite/sqlite.c $(DEPS_28)
	@echo '   [Compile] $(CONFIG)/obj/sqlite.o'
	$(CC) -c -o $(CONFIG)/obj/sqlite.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/sqlite/sqlite.c

ifeq ($(BIT_PACK_SQLITE),1)
#
#   sqliteshell
#
DEPS_29 += $(CONFIG)/inc/sqlite3.h
DEPS_29 += $(CONFIG)/inc/bit.h
DEPS_29 += $(CONFIG)/obj/sqlite3.o
DEPS_29 += $(CONFIG)/bin/libsql.a
DEPS_29 += $(CONFIG)/obj/sqlite.o

LIBS_29 += -lsql

$(CONFIG)/bin/sqlite.out: $(DEPS_29)
	@echo '      [Link] $(CONFIG)/bin/sqlite.out'
	$(CC) -o $(CONFIG)/bin/sqlite.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/sqlite.o" $(LIBPATHS_29) $(LIBS_29) $(LIBS_29) $(LIBS) -Wl,-r 
endif

#
#   appweb.h
#
$(CONFIG)/inc/appweb.h: $(DEPS_30)
	@echo '      [Copy] $(CONFIG)/inc/appweb.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/appweb.h $(CONFIG)/inc/appweb.h

#
#   customize.h
#
$(CONFIG)/inc/customize.h: $(DEPS_31)
	@echo '      [Copy] $(CONFIG)/inc/customize.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/customize.h $(CONFIG)/inc/customize.h

#
#   config.o
#
DEPS_32 += $(CONFIG)/inc/bit.h
DEPS_32 += $(CONFIG)/inc/appweb.h
DEPS_32 += $(CONFIG)/inc/pcre.h
DEPS_32 += $(CONFIG)/inc/mpr.h
DEPS_32 += $(CONFIG)/inc/http.h
DEPS_32 += $(CONFIG)/inc/customize.h

$(CONFIG)/obj/config.o: \
    src/config.c $(DEPS_32)
	@echo '   [Compile] $(CONFIG)/obj/config.o'
	$(CC) -c -o $(CONFIG)/obj/config.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/config.c

#
#   convenience.o
#
DEPS_33 += $(CONFIG)/inc/bit.h
DEPS_33 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/convenience.o: \
    src/convenience.c $(DEPS_33)
	@echo '   [Compile] $(CONFIG)/obj/convenience.o'
	$(CC) -c -o $(CONFIG)/obj/convenience.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/convenience.c

#
#   dirHandler.o
#
DEPS_34 += $(CONFIG)/inc/bit.h
DEPS_34 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/dirHandler.o: \
    src/dirHandler.c $(DEPS_34)
	@echo '   [Compile] $(CONFIG)/obj/dirHandler.o'
	$(CC) -c -o $(CONFIG)/obj/dirHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/dirHandler.c

#
#   fileHandler.o
#
DEPS_35 += $(CONFIG)/inc/bit.h
DEPS_35 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/fileHandler.o: \
    src/fileHandler.c $(DEPS_35)
	@echo '   [Compile] $(CONFIG)/obj/fileHandler.o'
	$(CC) -c -o $(CONFIG)/obj/fileHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/fileHandler.c

#
#   log.o
#
DEPS_36 += $(CONFIG)/inc/bit.h
DEPS_36 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/log.o: \
    src/log.c $(DEPS_36)
	@echo '   [Compile] $(CONFIG)/obj/log.o'
	$(CC) -c -o $(CONFIG)/obj/log.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/log.c

#
#   server.o
#
DEPS_37 += $(CONFIG)/inc/bit.h
DEPS_37 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/server.o: \
    src/server.c $(DEPS_37)
	@echo '   [Compile] $(CONFIG)/obj/server.o'
	$(CC) -c -o $(CONFIG)/obj/server.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/server.c

#
#   libappweb
#
DEPS_38 += $(CONFIG)/inc/mpr.h
DEPS_38 += $(CONFIG)/inc/bit.h
DEPS_38 += $(CONFIG)/inc/bitos.h
DEPS_38 += $(CONFIG)/obj/mprLib.o
DEPS_38 += $(CONFIG)/bin/libmpr.a
DEPS_38 += $(CONFIG)/inc/pcre.h
DEPS_38 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_38 += $(CONFIG)/bin/libpcre.a
endif
DEPS_38 += $(CONFIG)/inc/http.h
DEPS_38 += $(CONFIG)/obj/httpLib.o
DEPS_38 += $(CONFIG)/bin/libhttp.a
DEPS_38 += $(CONFIG)/inc/appweb.h
DEPS_38 += $(CONFIG)/inc/customize.h
DEPS_38 += $(CONFIG)/obj/config.o
DEPS_38 += $(CONFIG)/obj/convenience.o
DEPS_38 += $(CONFIG)/obj/dirHandler.o
DEPS_38 += $(CONFIG)/obj/fileHandler.o
DEPS_38 += $(CONFIG)/obj/log.o
DEPS_38 += $(CONFIG)/obj/server.o

$(CONFIG)/bin/libappweb.a: $(DEPS_38)
	@echo '      [Link] $(CONFIG)/bin/libappweb.a'
	ar -cr $(CONFIG)/bin/libappweb.a "$(CONFIG)/obj/config.o" "$(CONFIG)/obj/convenience.o" "$(CONFIG)/obj/dirHandler.o" "$(CONFIG)/obj/fileHandler.o" "$(CONFIG)/obj/log.o" "$(CONFIG)/obj/server.o"

#
#   edi.h
#
$(CONFIG)/inc/edi.h: $(DEPS_39)
	@echo '      [Copy] $(CONFIG)/inc/edi.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/esp/edi.h $(CONFIG)/inc/edi.h

#
#   esp.h
#
$(CONFIG)/inc/esp.h: $(DEPS_40)
	@echo '      [Copy] $(CONFIG)/inc/esp.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/esp/esp.h $(CONFIG)/inc/esp.h

#
#   mdb.h
#
$(CONFIG)/inc/mdb.h: $(DEPS_41)
	@echo '      [Copy] $(CONFIG)/inc/mdb.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/esp/mdb.h $(CONFIG)/inc/mdb.h

#
#   edi.o
#
DEPS_42 += $(CONFIG)/inc/bit.h
DEPS_42 += $(CONFIG)/inc/edi.h
DEPS_42 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/edi.o: \
    src/esp/edi.c $(DEPS_42)
	@echo '   [Compile] $(CONFIG)/obj/edi.o'
	$(CC) -c -o $(CONFIG)/obj/edi.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/edi.c

#
#   espAbbrev.o
#
DEPS_43 += $(CONFIG)/inc/bit.h
DEPS_43 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/espAbbrev.o: \
    src/esp/espAbbrev.c $(DEPS_43)
	@echo '   [Compile] $(CONFIG)/obj/espAbbrev.o'
	$(CC) -c -o $(CONFIG)/obj/espAbbrev.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espAbbrev.c

#
#   espDeprecated.o
#
DEPS_44 += $(CONFIG)/inc/bit.h
DEPS_44 += $(CONFIG)/inc/esp.h
DEPS_44 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espDeprecated.o: \
    src/esp/espDeprecated.c $(DEPS_44)
	@echo '   [Compile] $(CONFIG)/obj/espDeprecated.o'
	$(CC) -c -o $(CONFIG)/obj/espDeprecated.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espDeprecated.c

#
#   espFramework.o
#
DEPS_45 += $(CONFIG)/inc/bit.h
DEPS_45 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/espFramework.o: \
    src/esp/espFramework.c $(DEPS_45)
	@echo '   [Compile] $(CONFIG)/obj/espFramework.o'
	$(CC) -c -o $(CONFIG)/obj/espFramework.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espFramework.c

#
#   espHandler.o
#
DEPS_46 += $(CONFIG)/inc/bit.h
DEPS_46 += $(CONFIG)/inc/appweb.h
DEPS_46 += $(CONFIG)/inc/esp.h
DEPS_46 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espHandler.o: \
    src/esp/espHandler.c $(DEPS_46)
	@echo '   [Compile] $(CONFIG)/obj/espHandler.o'
	$(CC) -c -o $(CONFIG)/obj/espHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espHandler.c

#
#   espHtml.o
#
DEPS_47 += $(CONFIG)/inc/bit.h
DEPS_47 += $(CONFIG)/inc/esp.h
DEPS_47 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espHtml.o: \
    src/esp/espHtml.c $(DEPS_47)
	@echo '   [Compile] $(CONFIG)/obj/espHtml.o'
	$(CC) -c -o $(CONFIG)/obj/espHtml.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espHtml.c

#
#   espTemplate.o
#
DEPS_48 += $(CONFIG)/inc/bit.h
DEPS_48 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/espTemplate.o: \
    src/esp/espTemplate.c $(DEPS_48)
	@echo '   [Compile] $(CONFIG)/obj/espTemplate.o'
	$(CC) -c -o $(CONFIG)/obj/espTemplate.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espTemplate.c

#
#   mdb.o
#
DEPS_49 += $(CONFIG)/inc/bit.h
DEPS_49 += $(CONFIG)/inc/appweb.h
DEPS_49 += $(CONFIG)/inc/edi.h
DEPS_49 += $(CONFIG)/inc/mdb.h
DEPS_49 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/mdb.o: \
    src/esp/mdb.c $(DEPS_49)
	@echo '   [Compile] $(CONFIG)/obj/mdb.o'
	$(CC) -c -o $(CONFIG)/obj/mdb.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/mdb.c

#
#   sdb.o
#
DEPS_50 += $(CONFIG)/inc/bit.h
DEPS_50 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/sdb.o: \
    src/esp/sdb.c $(DEPS_50)
	@echo '   [Compile] $(CONFIG)/obj/sdb.o'
	$(CC) -c -o $(CONFIG)/obj/sdb.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/sdb.c

ifeq ($(BIT_PACK_ESP),1)
#
#   libmod_esp
#
DEPS_51 += $(CONFIG)/inc/mpr.h
DEPS_51 += $(CONFIG)/inc/bit.h
DEPS_51 += $(CONFIG)/inc/bitos.h
DEPS_51 += $(CONFIG)/obj/mprLib.o
DEPS_51 += $(CONFIG)/bin/libmpr.a
DEPS_51 += $(CONFIG)/inc/pcre.h
DEPS_51 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_51 += $(CONFIG)/bin/libpcre.a
endif
DEPS_51 += $(CONFIG)/inc/http.h
DEPS_51 += $(CONFIG)/obj/httpLib.o
DEPS_51 += $(CONFIG)/bin/libhttp.a
DEPS_51 += $(CONFIG)/inc/appweb.h
DEPS_51 += $(CONFIG)/inc/customize.h
DEPS_51 += $(CONFIG)/obj/config.o
DEPS_51 += $(CONFIG)/obj/convenience.o
DEPS_51 += $(CONFIG)/obj/dirHandler.o
DEPS_51 += $(CONFIG)/obj/fileHandler.o
DEPS_51 += $(CONFIG)/obj/log.o
DEPS_51 += $(CONFIG)/obj/server.o
DEPS_51 += $(CONFIG)/bin/libappweb.a
DEPS_51 += $(CONFIG)/inc/edi.h
DEPS_51 += $(CONFIG)/inc/esp.h
DEPS_51 += $(CONFIG)/inc/mdb.h
DEPS_51 += $(CONFIG)/obj/edi.o
DEPS_51 += $(CONFIG)/obj/espAbbrev.o
DEPS_51 += $(CONFIG)/obj/espDeprecated.o
DEPS_51 += $(CONFIG)/obj/espFramework.o
DEPS_51 += $(CONFIG)/obj/espHandler.o
DEPS_51 += $(CONFIG)/obj/espHtml.o
DEPS_51 += $(CONFIG)/obj/espTemplate.o
DEPS_51 += $(CONFIG)/obj/mdb.o
DEPS_51 += $(CONFIG)/obj/sdb.o

$(CONFIG)/bin/libmod_esp.a: $(DEPS_51)
	@echo '      [Link] $(CONFIG)/bin/libmod_esp.a'
	ar -cr $(CONFIG)/bin/libmod_esp.a "$(CONFIG)/obj/edi.o" "$(CONFIG)/obj/espAbbrev.o" "$(CONFIG)/obj/espDeprecated.o" "$(CONFIG)/obj/espFramework.o" "$(CONFIG)/obj/espHandler.o" "$(CONFIG)/obj/espHtml.o" "$(CONFIG)/obj/espTemplate.o" "$(CONFIG)/obj/mdb.o" "$(CONFIG)/obj/sdb.o"
endif

#
#   esp.o
#
DEPS_52 += $(CONFIG)/inc/bit.h
DEPS_52 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/esp.o: \
    src/esp/esp.c $(DEPS_52)
	@echo '   [Compile] $(CONFIG)/obj/esp.o'
	$(CC) -c -o $(CONFIG)/obj/esp.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/esp.c

ifeq ($(BIT_PACK_ESP),1)
#
#   espcmd
#
DEPS_53 += $(CONFIG)/inc/mpr.h
DEPS_53 += $(CONFIG)/inc/bit.h
DEPS_53 += $(CONFIG)/inc/bitos.h
DEPS_53 += $(CONFIG)/obj/mprLib.o
DEPS_53 += $(CONFIG)/bin/libmpr.a
DEPS_53 += $(CONFIG)/inc/pcre.h
DEPS_53 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_53 += $(CONFIG)/bin/libpcre.a
endif
DEPS_53 += $(CONFIG)/inc/http.h
DEPS_53 += $(CONFIG)/obj/httpLib.o
DEPS_53 += $(CONFIG)/bin/libhttp.a
DEPS_53 += $(CONFIG)/inc/appweb.h
DEPS_53 += $(CONFIG)/inc/customize.h
DEPS_53 += $(CONFIG)/obj/config.o
DEPS_53 += $(CONFIG)/obj/convenience.o
DEPS_53 += $(CONFIG)/obj/dirHandler.o
DEPS_53 += $(CONFIG)/obj/fileHandler.o
DEPS_53 += $(CONFIG)/obj/log.o
DEPS_53 += $(CONFIG)/obj/server.o
DEPS_53 += $(CONFIG)/bin/libappweb.a
DEPS_53 += $(CONFIG)/inc/edi.h
DEPS_53 += $(CONFIG)/inc/esp.h
DEPS_53 += $(CONFIG)/inc/mdb.h
DEPS_53 += $(CONFIG)/obj/edi.o
DEPS_53 += $(CONFIG)/obj/espAbbrev.o
DEPS_53 += $(CONFIG)/obj/espDeprecated.o
DEPS_53 += $(CONFIG)/obj/espFramework.o
DEPS_53 += $(CONFIG)/obj/espHandler.o
DEPS_53 += $(CONFIG)/obj/espHtml.o
DEPS_53 += $(CONFIG)/obj/espTemplate.o
DEPS_53 += $(CONFIG)/obj/mdb.o
DEPS_53 += $(CONFIG)/obj/sdb.o
DEPS_53 += $(CONFIG)/bin/libmod_esp.a
DEPS_53 += $(CONFIG)/obj/esp.o

LIBS_53 += -lappweb
LIBS_53 += -lhttp
LIBS_53 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_53 += -lpcre
endif
ifeq ($(BIT_PACK_SQLITE),1)
    LIBS_53 += -lsqlite3
endif
LIBS_53 += -lmod_esp

$(CONFIG)/bin/esp.out: $(DEPS_53)
	@echo '      [Link] $(CONFIG)/bin/esp.out'
	$(CC) -o $(CONFIG)/bin/esp.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/edi.o" "$(CONFIG)/obj/esp.o" "$(CONFIG)/obj/espAbbrev.o" "$(CONFIG)/obj/espDeprecated.o" "$(CONFIG)/obj/espFramework.o" "$(CONFIG)/obj/espHandler.o" "$(CONFIG)/obj/espHtml.o" "$(CONFIG)/obj/espTemplate.o" "$(CONFIG)/obj/mdb.o" "$(CONFIG)/obj/sdb.o" $(LIBPATHS_53) $(LIBS_53) $(LIBS_53) $(LIBS) -Wl,-r 
endif

ifeq ($(BIT_PACK_ESP),1)
#
#   esp.conf
#
DEPS_54 += src/esp/esp.conf

$(CONFIG)/bin/esp.conf: $(DEPS_54)
	@echo '      [Copy] $(CONFIG)/bin/esp.conf'
	mkdir -p "$(CONFIG)/bin"
	cp src/esp/esp.conf $(CONFIG)/bin/esp.conf
endif

ifeq ($(BIT_PACK_ESP),1)
#
#   esp.conf.server
#
DEPS_55 += src/esp/esp.conf

src/server/esp.conf: $(DEPS_55)
	@echo '      [Copy] src/server/esp.conf'
	mkdir -p "src/server"
	cp src/esp/esp.conf src/server/esp.conf
endif

ifeq ($(BIT_PACK_ESP),1)
#
#   paks
#
DEPS_56 += src/esp/paks/angular
DEPS_56 += src/esp/paks/angular/angular-animate.js
DEPS_56 += src/esp/paks/angular/angular-csp.css
DEPS_56 += src/esp/paks/angular/angular-route.js
DEPS_56 += src/esp/paks/angular/angular.js
DEPS_56 += src/esp/paks/angular/package.json
DEPS_56 += src/esp/paks/esp-angular
DEPS_56 += src/esp/paks/esp-angular/esp-click.js
DEPS_56 += src/esp/paks/esp-angular/esp-edit.js
DEPS_56 += src/esp/paks/esp-angular/esp-field-errors.js
DEPS_56 += src/esp/paks/esp-angular/esp-format.js
DEPS_56 += src/esp/paks/esp-angular/esp-input-group.js
DEPS_56 += src/esp/paks/esp-angular/esp-input.js
DEPS_56 += src/esp/paks/esp-angular/esp-resource.js
DEPS_56 += src/esp/paks/esp-angular/esp-session.js
DEPS_56 += src/esp/paks/esp-angular/esp-titlecase.js
DEPS_56 += src/esp/paks/esp-angular/esp.js
DEPS_56 += src/esp/paks/esp-angular/package.json
DEPS_56 += src/esp/paks/esp-angular-mvc
DEPS_56 += src/esp/paks/esp-angular-mvc/package.json
DEPS_56 += src/esp/paks/esp-angular-mvc/templates
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/appweb.conf
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/app
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/app/main.js
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/assets
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/assets/favicon.ico
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/all.css
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/all.less
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/app.less
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/fix.css
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/theme.less
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/index.esp
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/pages
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/pages/splash.html
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/controller-singleton.c
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/controller.c
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/controller.js
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/edit.html
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/list.html
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/model.js
DEPS_56 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/start.bit
DEPS_56 += src/esp/paks/esp-html-mvc
DEPS_56 += src/esp/paks/esp-html-mvc/package.json
DEPS_56 += src/esp/paks/esp-html-mvc/templates
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/appweb.conf
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/assets
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/assets/favicon.ico
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/css
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/css/all.css
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/css/all.less
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/css/app.less
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/css/theme.less
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/index.esp
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/layouts
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/layouts/default.esp
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/controller-singleton.c
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/controller.c
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/edit.esp
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/list.esp
DEPS_56 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/start.bit
DEPS_56 += src/esp/paks/esp-legacy-mvc
DEPS_56 += src/esp/paks/esp-legacy-mvc/package.json
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/appweb.conf
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/controller.c
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/edit.esp
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/layouts
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/layouts/default.esp
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/list.esp
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/migration.c
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/src
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/src/app.c
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/css
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/css/all.css
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/banner.jpg
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/favicon.ico
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/splash.jpg
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/index.esp
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.esp.js
DEPS_56 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.js
DEPS_56 += src/esp/paks/esp-server
DEPS_56 += src/esp/paks/esp-server/package.json
DEPS_56 += src/esp/paks/esp-server/templates
DEPS_56 += src/esp/paks/esp-server/templates/esp-server
DEPS_56 += src/esp/paks/esp-server/templates/esp-server/appweb.conf
DEPS_56 += src/esp/paks/esp-server/templates/esp-server/controller.c
DEPS_56 += src/esp/paks/esp-server/templates/esp-server/migration.c
DEPS_56 += src/esp/paks/esp-server/templates/esp-server/src
DEPS_56 += src/esp/paks/esp-server/templates/esp-server/src/app.c

$(CONFIG)/paks: $(DEPS_56)
	( \
	cd src/esp/paks; \
	mkdir -p "../../../$(CONFIG)/paks/angular/1.2.6" ; \
	cp angular/angular-animate.js ../../../$(CONFIG)/paks/angular/1.2.6/angular-animate.js ; \
	cp angular/angular-csp.css ../../../$(CONFIG)/paks/angular/1.2.6/angular-csp.css ; \
	cp angular/angular-route.js ../../../$(CONFIG)/paks/angular/1.2.6/angular-route.js ; \
	cp angular/angular.js ../../../$(CONFIG)/paks/angular/1.2.6/angular.js ; \
	cp angular/package.json ../../../$(CONFIG)/paks/angular/1.2.6/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular/4.5.0" ; \
	cp esp-angular/esp-click.js ../../../$(CONFIG)/paks/esp-angular/4.5.0/esp-click.js ; \
	cp esp-angular/esp-edit.js ../../../$(CONFIG)/paks/esp-angular/4.5.0/esp-edit.js ; \
	cp esp-angular/esp-field-errors.js ../../../$(CONFIG)/paks/esp-angular/4.5.0/esp-field-errors.js ; \
	cp esp-angular/esp-format.js ../../../$(CONFIG)/paks/esp-angular/4.5.0/esp-format.js ; \
	cp esp-angular/esp-input-group.js ../../../$(CONFIG)/paks/esp-angular/4.5.0/esp-input-group.js ; \
	cp esp-angular/esp-input.js ../../../$(CONFIG)/paks/esp-angular/4.5.0/esp-input.js ; \
	cp esp-angular/esp-resource.js ../../../$(CONFIG)/paks/esp-angular/4.5.0/esp-resource.js ; \
	cp esp-angular/esp-session.js ../../../$(CONFIG)/paks/esp-angular/4.5.0/esp-session.js ; \
	cp esp-angular/esp-titlecase.js ../../../$(CONFIG)/paks/esp-angular/4.5.0/esp-titlecase.js ; \
	cp esp-angular/esp.js ../../../$(CONFIG)/paks/esp-angular/4.5.0/esp.js ; \
	cp esp-angular/package.json ../../../$(CONFIG)/paks/esp-angular/4.5.0/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0" ; \
	cp esp-angular-mvc/package.json ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/appweb.conf ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/appweb.conf ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/app" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/app/main.js ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/app/main.js ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/assets" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/assets/favicon.ico ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/assets/favicon.ico ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/css" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/all.css ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/css/all.css ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/all.less ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/css/all.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/app.less ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/css/app.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/fix.css ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/css/fix.css ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/theme.less ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/css/theme.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/index.esp ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/index.esp ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/pages" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/pages/splash.html ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/client/pages/splash.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller-singleton.c ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/controller-singleton.c ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller.c ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/controller.c ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller.js ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/controller.js ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/edit.html ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/edit.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/list.html ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/list.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/model.js ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/model.js ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/start.bit ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.0/templates/esp-angular-mvc/start.bit ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.0" ; \
	cp esp-html-mvc/package.json ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc" ; \
	cp esp-html-mvc/templates/esp-html-mvc/appweb.conf ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/appweb.conf ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/client" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/client/assets" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/assets/favicon.ico ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/client/assets/favicon.ico ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/client/css" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/all.css ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/client/css/all.css ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/all.less ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/client/css/all.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/app.less ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/client/css/app.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/theme.less ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/client/css/theme.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/index.esp ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/client/index.esp ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/client/layouts" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/layouts/default.esp ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/client/layouts/default.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/controller-singleton.c ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/controller-singleton.c ; \
	cp esp-html-mvc/templates/esp-html-mvc/controller.c ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/controller.c ; \
	cp esp-html-mvc/templates/esp-html-mvc/edit.esp ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/edit.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/list.esp ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/list.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/start.bit ../../../$(CONFIG)/paks/esp-html-mvc/4.5.0/templates/esp-html-mvc/start.bit ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0" ; \
	cp esp-legacy-mvc/package.json ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/appweb.conf ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/appweb.conf ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/controller.c ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/controller.c ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/edit.esp ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/edit.esp ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/layouts" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/layouts/default.esp ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/layouts/default.esp ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/list.esp ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/list.esp ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/migration.c ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/migration.c ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/src" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/src/app.c ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/src/app.c ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/static" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/static/css" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/css/all.css ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/static/css/all.css ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/static/images" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/banner.jpg ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/static/images/banner.jpg ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/favicon.ico ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/static/images/favicon.ico ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/splash.jpg ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/static/images/splash.jpg ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/index.esp ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/static/index.esp ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/static/js" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.esp.js ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/static/js/jquery.esp.js ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.js ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.0/templates/esp-legacy-mvc/static/js/jquery.js ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-server/4.5.0" ; \
	cp esp-server/package.json ../../../$(CONFIG)/paks/esp-server/4.5.0/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-server/4.5.0/templates" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-server/4.5.0/templates/esp-server" ; \
	cp esp-server/templates/esp-server/appweb.conf ../../../$(CONFIG)/paks/esp-server/4.5.0/templates/esp-server/appweb.conf ; \
	cp esp-server/templates/esp-server/controller.c ../../../$(CONFIG)/paks/esp-server/4.5.0/templates/esp-server/controller.c ; \
	cp esp-server/templates/esp-server/migration.c ../../../$(CONFIG)/paks/esp-server/4.5.0/templates/esp-server/migration.c ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-server/4.5.0/templates/esp-server/src" ; \
	cp esp-server/templates/esp-server/src/app.c ../../../$(CONFIG)/paks/esp-server/4.5.0/templates/esp-server/src/app.c ; \
	)
endif


#
#   ejs.h
#
$(CONFIG)/inc/ejs.h: $(DEPS_57)
	@echo '      [Copy] $(CONFIG)/inc/ejs.h'

#
#   ejs.slots.h
#
$(CONFIG)/inc/ejs.slots.h: $(DEPS_58)
	@echo '      [Copy] $(CONFIG)/inc/ejs.slots.h'

#
#   ejsByteGoto.h
#
$(CONFIG)/inc/ejsByteGoto.h: $(DEPS_59)
	@echo '      [Copy] $(CONFIG)/inc/ejsByteGoto.h'

#
#   ejsLib.o
#
DEPS_60 += $(CONFIG)/inc/bit.h
DEPS_60 += $(CONFIG)/inc/ejs.h
DEPS_60 += $(CONFIG)/inc/mpr.h
DEPS_60 += $(CONFIG)/inc/pcre.h
DEPS_60 += $(CONFIG)/inc/bitos.h
DEPS_60 += $(CONFIG)/inc/http.h
DEPS_60 += $(CONFIG)/inc/ejs.slots.h

$(CONFIG)/obj/ejsLib.o: \
    src/paks/ejs/ejsLib.c $(DEPS_60)
	@echo '   [Compile] $(CONFIG)/obj/ejsLib.o'
	$(CC) -c -o $(CONFIG)/obj/ejsLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/ejs/ejsLib.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   libejs
#
DEPS_61 += $(CONFIG)/inc/mpr.h
DEPS_61 += $(CONFIG)/inc/bit.h
DEPS_61 += $(CONFIG)/inc/bitos.h
DEPS_61 += $(CONFIG)/obj/mprLib.o
DEPS_61 += $(CONFIG)/bin/libmpr.a
DEPS_61 += $(CONFIG)/inc/pcre.h
DEPS_61 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_61 += $(CONFIG)/bin/libpcre.a
endif
DEPS_61 += $(CONFIG)/inc/http.h
DEPS_61 += $(CONFIG)/obj/httpLib.o
DEPS_61 += $(CONFIG)/bin/libhttp.a
DEPS_61 += $(CONFIG)/inc/ejs.h
DEPS_61 += $(CONFIG)/inc/ejs.slots.h
DEPS_61 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_61 += $(CONFIG)/obj/ejsLib.o

$(CONFIG)/bin/libejs.a: $(DEPS_61)
	@echo '      [Link] $(CONFIG)/bin/libejs.a'
	ar -cr $(CONFIG)/bin/libejs.a "$(CONFIG)/obj/ejsLib.o"
endif

#
#   ejs.o
#
DEPS_62 += $(CONFIG)/inc/bit.h
DEPS_62 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejs.o: \
    src/paks/ejs/ejs.c $(DEPS_62)
	@echo '   [Compile] $(CONFIG)/obj/ejs.o'
	$(CC) -c -o $(CONFIG)/obj/ejs.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/ejs/ejs.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   ejs
#
DEPS_63 += $(CONFIG)/inc/mpr.h
DEPS_63 += $(CONFIG)/inc/bit.h
DEPS_63 += $(CONFIG)/inc/bitos.h
DEPS_63 += $(CONFIG)/obj/mprLib.o
DEPS_63 += $(CONFIG)/bin/libmpr.a
DEPS_63 += $(CONFIG)/inc/pcre.h
DEPS_63 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_63 += $(CONFIG)/bin/libpcre.a
endif
DEPS_63 += $(CONFIG)/inc/http.h
DEPS_63 += $(CONFIG)/obj/httpLib.o
DEPS_63 += $(CONFIG)/bin/libhttp.a
DEPS_63 += $(CONFIG)/inc/ejs.h
DEPS_63 += $(CONFIG)/inc/ejs.slots.h
DEPS_63 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_63 += $(CONFIG)/obj/ejsLib.o
DEPS_63 += $(CONFIG)/bin/libejs.a
DEPS_63 += $(CONFIG)/obj/ejs.o

LIBS_63 += -lejs
LIBS_63 += -lhttp
LIBS_63 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_63 += -lpcre
endif
ifeq ($(BIT_PACK_SQLITE),1)
    LIBS_63 += -lsqlite3
endif

$(CONFIG)/bin/ejs.out: $(DEPS_63)
	@echo '      [Link] $(CONFIG)/bin/ejs.out'
	$(CC) -o $(CONFIG)/bin/ejs.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejs.o" $(LIBPATHS_63) $(LIBS_63) $(LIBS_63) $(LIBS) -Wl,-r 
endif

#
#   ejsc.o
#
DEPS_64 += $(CONFIG)/inc/bit.h
DEPS_64 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsc.o: \
    src/paks/ejs/ejsc.c $(DEPS_64)
	@echo '   [Compile] $(CONFIG)/obj/ejsc.o'
	$(CC) -c -o $(CONFIG)/obj/ejsc.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/ejs/ejsc.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   ejsc
#
DEPS_65 += $(CONFIG)/inc/mpr.h
DEPS_65 += $(CONFIG)/inc/bit.h
DEPS_65 += $(CONFIG)/inc/bitos.h
DEPS_65 += $(CONFIG)/obj/mprLib.o
DEPS_65 += $(CONFIG)/bin/libmpr.a
DEPS_65 += $(CONFIG)/inc/pcre.h
DEPS_65 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_65 += $(CONFIG)/bin/libpcre.a
endif
DEPS_65 += $(CONFIG)/inc/http.h
DEPS_65 += $(CONFIG)/obj/httpLib.o
DEPS_65 += $(CONFIG)/bin/libhttp.a
DEPS_65 += $(CONFIG)/inc/ejs.h
DEPS_65 += $(CONFIG)/inc/ejs.slots.h
DEPS_65 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_65 += $(CONFIG)/obj/ejsLib.o
DEPS_65 += $(CONFIG)/bin/libejs.a
DEPS_65 += $(CONFIG)/obj/ejsc.o

LIBS_65 += -lejs
LIBS_65 += -lhttp
LIBS_65 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_65 += -lpcre
endif
ifeq ($(BIT_PACK_SQLITE),1)
    LIBS_65 += -lsqlite3
endif

$(CONFIG)/bin/ejsc.out: $(DEPS_65)
	@echo '      [Link] $(CONFIG)/bin/ejsc.out'
	$(CC) -o $(CONFIG)/bin/ejsc.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsc.o" $(LIBPATHS_65) $(LIBS_65) $(LIBS_65) $(LIBS) -Wl,-r 
endif

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   ejs.mod
#
DEPS_66 += src/paks/ejs/ejs.es
DEPS_66 += $(CONFIG)/inc/mpr.h
DEPS_66 += $(CONFIG)/inc/bit.h
DEPS_66 += $(CONFIG)/inc/bitos.h
DEPS_66 += $(CONFIG)/obj/mprLib.o
DEPS_66 += $(CONFIG)/bin/libmpr.a
DEPS_66 += $(CONFIG)/inc/pcre.h
DEPS_66 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_66 += $(CONFIG)/bin/libpcre.a
endif
DEPS_66 += $(CONFIG)/inc/http.h
DEPS_66 += $(CONFIG)/obj/httpLib.o
DEPS_66 += $(CONFIG)/bin/libhttp.a
DEPS_66 += $(CONFIG)/inc/ejs.h
DEPS_66 += $(CONFIG)/inc/ejs.slots.h
DEPS_66 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_66 += $(CONFIG)/obj/ejsLib.o
DEPS_66 += $(CONFIG)/bin/libejs.a
DEPS_66 += $(CONFIG)/obj/ejsc.o
DEPS_66 += $(CONFIG)/bin/ejsc.out

$(CONFIG)/bin/ejs.mod: $(DEPS_66)
	( \
	cd src/paks/ejs; \
	../../../$(CONFIG)/bin/ejsc --out ../../../$(CONFIG)/bin/ejs.mod --optimize 9 --bind --require null ejs.es ; \
	)
endif

#
#   cgiHandler.o
#
DEPS_67 += $(CONFIG)/inc/bit.h
DEPS_67 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/cgiHandler.o: \
    src/modules/cgiHandler.c $(DEPS_67)
	@echo '   [Compile] $(CONFIG)/obj/cgiHandler.o'
	$(CC) -c -o $(CONFIG)/obj/cgiHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/modules/cgiHandler.c

ifeq ($(BIT_PACK_CGI),1)
#
#   libmod_cgi
#
DEPS_68 += $(CONFIG)/inc/mpr.h
DEPS_68 += $(CONFIG)/inc/bit.h
DEPS_68 += $(CONFIG)/inc/bitos.h
DEPS_68 += $(CONFIG)/obj/mprLib.o
DEPS_68 += $(CONFIG)/bin/libmpr.a
DEPS_68 += $(CONFIG)/inc/pcre.h
DEPS_68 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_68 += $(CONFIG)/bin/libpcre.a
endif
DEPS_68 += $(CONFIG)/inc/http.h
DEPS_68 += $(CONFIG)/obj/httpLib.o
DEPS_68 += $(CONFIG)/bin/libhttp.a
DEPS_68 += $(CONFIG)/inc/appweb.h
DEPS_68 += $(CONFIG)/inc/customize.h
DEPS_68 += $(CONFIG)/obj/config.o
DEPS_68 += $(CONFIG)/obj/convenience.o
DEPS_68 += $(CONFIG)/obj/dirHandler.o
DEPS_68 += $(CONFIG)/obj/fileHandler.o
DEPS_68 += $(CONFIG)/obj/log.o
DEPS_68 += $(CONFIG)/obj/server.o
DEPS_68 += $(CONFIG)/bin/libappweb.a
DEPS_68 += $(CONFIG)/obj/cgiHandler.o

$(CONFIG)/bin/libmod_cgi.a: $(DEPS_68)
	@echo '      [Link] $(CONFIG)/bin/libmod_cgi.a'
	ar -cr $(CONFIG)/bin/libmod_cgi.a "$(CONFIG)/obj/cgiHandler.o"
endif

#
#   ejsHandler.o
#
DEPS_69 += $(CONFIG)/inc/bit.h
DEPS_69 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/ejsHandler.o: \
    src/modules/ejsHandler.c $(DEPS_69)
	@echo '   [Compile] $(CONFIG)/obj/ejsHandler.o'
	$(CC) -c -o $(CONFIG)/obj/ejsHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/modules/ejsHandler.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   libmod_ejs
#
DEPS_70 += $(CONFIG)/inc/mpr.h
DEPS_70 += $(CONFIG)/inc/bit.h
DEPS_70 += $(CONFIG)/inc/bitos.h
DEPS_70 += $(CONFIG)/obj/mprLib.o
DEPS_70 += $(CONFIG)/bin/libmpr.a
DEPS_70 += $(CONFIG)/inc/pcre.h
DEPS_70 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_70 += $(CONFIG)/bin/libpcre.a
endif
DEPS_70 += $(CONFIG)/inc/http.h
DEPS_70 += $(CONFIG)/obj/httpLib.o
DEPS_70 += $(CONFIG)/bin/libhttp.a
DEPS_70 += $(CONFIG)/inc/appweb.h
DEPS_70 += $(CONFIG)/inc/customize.h
DEPS_70 += $(CONFIG)/obj/config.o
DEPS_70 += $(CONFIG)/obj/convenience.o
DEPS_70 += $(CONFIG)/obj/dirHandler.o
DEPS_70 += $(CONFIG)/obj/fileHandler.o
DEPS_70 += $(CONFIG)/obj/log.o
DEPS_70 += $(CONFIG)/obj/server.o
DEPS_70 += $(CONFIG)/bin/libappweb.a
DEPS_70 += $(CONFIG)/inc/ejs.h
DEPS_70 += $(CONFIG)/inc/ejs.slots.h
DEPS_70 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_70 += $(CONFIG)/obj/ejsLib.o
DEPS_70 += $(CONFIG)/bin/libejs.a
DEPS_70 += $(CONFIG)/obj/ejsHandler.o

$(CONFIG)/bin/libmod_ejs.a: $(DEPS_70)
	@echo '      [Link] $(CONFIG)/bin/libmod_ejs.a'
	ar -cr $(CONFIG)/bin/libmod_ejs.a "$(CONFIG)/obj/ejsHandler.o"
endif

#
#   phpHandler.o
#
DEPS_71 += $(CONFIG)/inc/bit.h
DEPS_71 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/phpHandler.o: \
    src/modules/phpHandler.c $(DEPS_71)
	@echo '   [Compile] $(CONFIG)/obj/phpHandler.o'
	$(CC) -c -o $(CONFIG)/obj/phpHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-I$(BIT_PACK_PHP_PATH)" "-I$(BIT_PACK_PHP_PATH)/main" "-I$(BIT_PACK_PHP_PATH)/Zend" "-I$(BIT_PACK_PHP_PATH)/TSRM" src/modules/phpHandler.c

ifeq ($(BIT_PACK_PHP),1)
#
#   libmod_php
#
DEPS_72 += $(CONFIG)/inc/mpr.h
DEPS_72 += $(CONFIG)/inc/bit.h
DEPS_72 += $(CONFIG)/inc/bitos.h
DEPS_72 += $(CONFIG)/obj/mprLib.o
DEPS_72 += $(CONFIG)/bin/libmpr.a
DEPS_72 += $(CONFIG)/inc/pcre.h
DEPS_72 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_72 += $(CONFIG)/bin/libpcre.a
endif
DEPS_72 += $(CONFIG)/inc/http.h
DEPS_72 += $(CONFIG)/obj/httpLib.o
DEPS_72 += $(CONFIG)/bin/libhttp.a
DEPS_72 += $(CONFIG)/inc/appweb.h
DEPS_72 += $(CONFIG)/inc/customize.h
DEPS_72 += $(CONFIG)/obj/config.o
DEPS_72 += $(CONFIG)/obj/convenience.o
DEPS_72 += $(CONFIG)/obj/dirHandler.o
DEPS_72 += $(CONFIG)/obj/fileHandler.o
DEPS_72 += $(CONFIG)/obj/log.o
DEPS_72 += $(CONFIG)/obj/server.o
DEPS_72 += $(CONFIG)/bin/libappweb.a
DEPS_72 += $(CONFIG)/obj/phpHandler.o

$(CONFIG)/bin/libmod_php.a: $(DEPS_72)
	@echo '      [Link] $(CONFIG)/bin/libmod_php.a'
	ar -cr $(CONFIG)/bin/libmod_php.a "$(CONFIG)/obj/phpHandler.o"
endif

#
#   sslModule.o
#
DEPS_73 += $(CONFIG)/inc/bit.h
DEPS_73 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/sslModule.o: \
    src/modules/sslModule.c $(DEPS_73)
	@echo '   [Compile] $(CONFIG)/obj/sslModule.o'
	$(CC) -c -o $(CONFIG)/obj/sslModule.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-I$(BIT_PACK_MATRIXSSL_PATH)" "-I$(BIT_PACK_MATRIXSSL_PATH)/matrixssl" "-I$(BIT_PACK_NANOSSL_PATH)/src" "-I$(BIT_PACK_OPENSSL_PATH)/include" src/modules/sslModule.c

ifeq ($(BIT_PACK_SSL),1)
#
#   libmod_ssl
#
DEPS_74 += $(CONFIG)/inc/mpr.h
DEPS_74 += $(CONFIG)/inc/bit.h
DEPS_74 += $(CONFIG)/inc/bitos.h
DEPS_74 += $(CONFIG)/obj/mprLib.o
DEPS_74 += $(CONFIG)/bin/libmpr.a
DEPS_74 += $(CONFIG)/inc/pcre.h
DEPS_74 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_74 += $(CONFIG)/bin/libpcre.a
endif
DEPS_74 += $(CONFIG)/inc/http.h
DEPS_74 += $(CONFIG)/obj/httpLib.o
DEPS_74 += $(CONFIG)/bin/libhttp.a
DEPS_74 += $(CONFIG)/inc/appweb.h
DEPS_74 += $(CONFIG)/inc/customize.h
DEPS_74 += $(CONFIG)/obj/config.o
DEPS_74 += $(CONFIG)/obj/convenience.o
DEPS_74 += $(CONFIG)/obj/dirHandler.o
DEPS_74 += $(CONFIG)/obj/fileHandler.o
DEPS_74 += $(CONFIG)/obj/log.o
DEPS_74 += $(CONFIG)/obj/server.o
DEPS_74 += $(CONFIG)/bin/libappweb.a
DEPS_74 += $(CONFIG)/inc/est.h
DEPS_74 += $(CONFIG)/obj/estLib.o
ifeq ($(BIT_PACK_EST),1)
    DEPS_74 += $(CONFIG)/bin/libest.a
endif
DEPS_74 += $(CONFIG)/obj/mprSsl.o
DEPS_74 += $(CONFIG)/bin/libmprssl.a
DEPS_74 += $(CONFIG)/obj/sslModule.o

$(CONFIG)/bin/libmod_ssl.a: $(DEPS_74)
	@echo '      [Link] $(CONFIG)/bin/libmod_ssl.a'
	ar -cr $(CONFIG)/bin/libmod_ssl.a "$(CONFIG)/obj/sslModule.o"
endif

#
#   authpass.o
#
DEPS_75 += $(CONFIG)/inc/bit.h
DEPS_75 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/authpass.o: \
    src/utils/authpass.c $(DEPS_75)
	@echo '   [Compile] $(CONFIG)/obj/authpass.o'
	$(CC) -c -o $(CONFIG)/obj/authpass.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/utils/authpass.c

#
#   authpass
#
DEPS_76 += $(CONFIG)/inc/mpr.h
DEPS_76 += $(CONFIG)/inc/bit.h
DEPS_76 += $(CONFIG)/inc/bitos.h
DEPS_76 += $(CONFIG)/obj/mprLib.o
DEPS_76 += $(CONFIG)/bin/libmpr.a
DEPS_76 += $(CONFIG)/inc/pcre.h
DEPS_76 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_76 += $(CONFIG)/bin/libpcre.a
endif
DEPS_76 += $(CONFIG)/inc/http.h
DEPS_76 += $(CONFIG)/obj/httpLib.o
DEPS_76 += $(CONFIG)/bin/libhttp.a
DEPS_76 += $(CONFIG)/inc/appweb.h
DEPS_76 += $(CONFIG)/inc/customize.h
DEPS_76 += $(CONFIG)/obj/config.o
DEPS_76 += $(CONFIG)/obj/convenience.o
DEPS_76 += $(CONFIG)/obj/dirHandler.o
DEPS_76 += $(CONFIG)/obj/fileHandler.o
DEPS_76 += $(CONFIG)/obj/log.o
DEPS_76 += $(CONFIG)/obj/server.o
DEPS_76 += $(CONFIG)/bin/libappweb.a
DEPS_76 += $(CONFIG)/obj/authpass.o

LIBS_76 += -lappweb
LIBS_76 += -lhttp
LIBS_76 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_76 += -lpcre
endif

$(CONFIG)/bin/authpass.out: $(DEPS_76)
	@echo '      [Link] $(CONFIG)/bin/authpass.out'
	$(CC) -o $(CONFIG)/bin/authpass.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/authpass.o" $(LIBPATHS_76) $(LIBS_76) $(LIBS_76) $(LIBS) -Wl,-r 

#
#   cgiProgram.o
#
DEPS_77 += $(CONFIG)/inc/bit.h

$(CONFIG)/obj/cgiProgram.o: \
    src/utils/cgiProgram.c $(DEPS_77)
	@echo '   [Compile] $(CONFIG)/obj/cgiProgram.o'
	$(CC) -c -o $(CONFIG)/obj/cgiProgram.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/utils/cgiProgram.c

ifeq ($(BIT_PACK_CGI),1)
#
#   cgiProgram
#
DEPS_78 += $(CONFIG)/inc/bit.h
DEPS_78 += $(CONFIG)/obj/cgiProgram.o

$(CONFIG)/bin/cgiProgram.out: $(DEPS_78)
	@echo '      [Link] $(CONFIG)/bin/cgiProgram.out'
	$(CC) -o $(CONFIG)/bin/cgiProgram.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/cgiProgram.o" $(LIBS) -Wl,-r 
endif

#
#   slink.c
#
src/server/slink.c: $(DEPS_79)
	( \
	cd src/server; \
	[ ! -f slink.c ] && cp slink.empty slink.c ; true ; \
	)

#
#   slink.o
#
DEPS_80 += $(CONFIG)/inc/bit.h
DEPS_80 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/slink.o: \
    src/server/slink.c $(DEPS_80)
	@echo '   [Compile] $(CONFIG)/obj/slink.o'
	$(CC) -c -o $(CONFIG)/obj/slink.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/server/slink.c

#
#   libslink
#
DEPS_81 += src/server/slink.c
DEPS_81 += $(CONFIG)/inc/mpr.h
DEPS_81 += $(CONFIG)/inc/bit.h
DEPS_81 += $(CONFIG)/inc/bitos.h
DEPS_81 += $(CONFIG)/obj/mprLib.o
DEPS_81 += $(CONFIG)/bin/libmpr.a
DEPS_81 += $(CONFIG)/inc/pcre.h
DEPS_81 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_81 += $(CONFIG)/bin/libpcre.a
endif
DEPS_81 += $(CONFIG)/inc/http.h
DEPS_81 += $(CONFIG)/obj/httpLib.o
DEPS_81 += $(CONFIG)/bin/libhttp.a
DEPS_81 += $(CONFIG)/inc/appweb.h
DEPS_81 += $(CONFIG)/inc/customize.h
DEPS_81 += $(CONFIG)/obj/config.o
DEPS_81 += $(CONFIG)/obj/convenience.o
DEPS_81 += $(CONFIG)/obj/dirHandler.o
DEPS_81 += $(CONFIG)/obj/fileHandler.o
DEPS_81 += $(CONFIG)/obj/log.o
DEPS_81 += $(CONFIG)/obj/server.o
DEPS_81 += $(CONFIG)/bin/libappweb.a
DEPS_81 += $(CONFIG)/inc/edi.h
DEPS_81 += $(CONFIG)/inc/esp.h
DEPS_81 += $(CONFIG)/inc/mdb.h
DEPS_81 += $(CONFIG)/obj/edi.o
DEPS_81 += $(CONFIG)/obj/espAbbrev.o
DEPS_81 += $(CONFIG)/obj/espDeprecated.o
DEPS_81 += $(CONFIG)/obj/espFramework.o
DEPS_81 += $(CONFIG)/obj/espHandler.o
DEPS_81 += $(CONFIG)/obj/espHtml.o
DEPS_81 += $(CONFIG)/obj/espTemplate.o
DEPS_81 += $(CONFIG)/obj/mdb.o
DEPS_81 += $(CONFIG)/obj/sdb.o
ifeq ($(BIT_PACK_ESP),1)
    DEPS_81 += $(CONFIG)/bin/libmod_esp.a
endif
DEPS_81 += $(CONFIG)/obj/slink.o

$(CONFIG)/bin/libslink.a: $(DEPS_81)
	@echo '      [Link] $(CONFIG)/bin/libslink.a'
	ar -cr $(CONFIG)/bin/libslink.a "$(CONFIG)/obj/slink.o"

#
#   appweb.o
#
DEPS_82 += $(CONFIG)/inc/bit.h
DEPS_82 += $(CONFIG)/inc/appweb.h
DEPS_82 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/appweb.o: \
    src/server/appweb.c $(DEPS_82)
	@echo '   [Compile] $(CONFIG)/obj/appweb.o'
	$(CC) -c -o $(CONFIG)/obj/appweb.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-I$(BIT_PACK_MATRIXSSL_PATH)" "-I$(BIT_PACK_MATRIXSSL_PATH)/matrixssl" "-I$(BIT_PACK_NANOSSL_PATH)/src" "-I$(BIT_PACK_OPENSSL_PATH)/include" "-I$(BIT_PACK_PHP_PATH)" "-I$(BIT_PACK_PHP_PATH)/main" "-I$(BIT_PACK_PHP_PATH)/Zend" "-I$(BIT_PACK_PHP_PATH)/TSRM" src/server/appweb.c

#
#   appweb
#
DEPS_83 += $(CONFIG)/inc/mpr.h
DEPS_83 += $(CONFIG)/inc/bit.h
DEPS_83 += $(CONFIG)/inc/bitos.h
DEPS_83 += $(CONFIG)/obj/mprLib.o
DEPS_83 += $(CONFIG)/bin/libmpr.a
DEPS_83 += $(CONFIG)/inc/pcre.h
DEPS_83 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_83 += $(CONFIG)/bin/libpcre.a
endif
DEPS_83 += $(CONFIG)/inc/http.h
DEPS_83 += $(CONFIG)/obj/httpLib.o
DEPS_83 += $(CONFIG)/bin/libhttp.a
DEPS_83 += $(CONFIG)/inc/appweb.h
DEPS_83 += $(CONFIG)/inc/customize.h
DEPS_83 += $(CONFIG)/obj/config.o
DEPS_83 += $(CONFIG)/obj/convenience.o
DEPS_83 += $(CONFIG)/obj/dirHandler.o
DEPS_83 += $(CONFIG)/obj/fileHandler.o
DEPS_83 += $(CONFIG)/obj/log.o
DEPS_83 += $(CONFIG)/obj/server.o
DEPS_83 += $(CONFIG)/bin/libappweb.a
DEPS_83 += src/server/slink.c
DEPS_83 += $(CONFIG)/inc/edi.h
DEPS_83 += $(CONFIG)/inc/esp.h
DEPS_83 += $(CONFIG)/inc/mdb.h
DEPS_83 += $(CONFIG)/obj/edi.o
DEPS_83 += $(CONFIG)/obj/espAbbrev.o
DEPS_83 += $(CONFIG)/obj/espDeprecated.o
DEPS_83 += $(CONFIG)/obj/espFramework.o
DEPS_83 += $(CONFIG)/obj/espHandler.o
DEPS_83 += $(CONFIG)/obj/espHtml.o
DEPS_83 += $(CONFIG)/obj/espTemplate.o
DEPS_83 += $(CONFIG)/obj/mdb.o
DEPS_83 += $(CONFIG)/obj/sdb.o
ifeq ($(BIT_PACK_ESP),1)
    DEPS_83 += $(CONFIG)/bin/libmod_esp.a
endif
DEPS_83 += $(CONFIG)/obj/slink.o
DEPS_83 += $(CONFIG)/bin/libslink.a
DEPS_83 += $(CONFIG)/inc/est.h
DEPS_83 += $(CONFIG)/obj/estLib.o
ifeq ($(BIT_PACK_EST),1)
    DEPS_83 += $(CONFIG)/bin/libest.a
endif
DEPS_83 += $(CONFIG)/obj/mprSsl.o
DEPS_83 += $(CONFIG)/bin/libmprssl.a
DEPS_83 += $(CONFIG)/obj/sslModule.o
ifeq ($(BIT_PACK_SSL),1)
    DEPS_83 += $(CONFIG)/bin/libmod_ssl.a
endif
DEPS_83 += $(CONFIG)/inc/ejs.h
DEPS_83 += $(CONFIG)/inc/ejs.slots.h
DEPS_83 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_83 += $(CONFIG)/obj/ejsLib.o
ifeq ($(BIT_PACK_EJSCRIPT),1)
    DEPS_83 += $(CONFIG)/bin/libejs.a
endif
DEPS_83 += $(CONFIG)/obj/ejsHandler.o
ifeq ($(BIT_PACK_EJSCRIPT),1)
    DEPS_83 += $(CONFIG)/bin/libmod_ejs.a
endif
DEPS_83 += $(CONFIG)/obj/phpHandler.o
ifeq ($(BIT_PACK_PHP),1)
    DEPS_83 += $(CONFIG)/bin/libmod_php.a
endif
DEPS_83 += $(CONFIG)/obj/cgiHandler.o
ifeq ($(BIT_PACK_CGI),1)
    DEPS_83 += $(CONFIG)/bin/libmod_cgi.a
endif
DEPS_83 += $(CONFIG)/obj/appweb.o

LIBS_83 += -lappweb
LIBS_83 += -lhttp
LIBS_83 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_83 += -lpcre
endif
LIBS_83 += -lslink
ifeq ($(BIT_PACK_ESP),1)
    LIBS_83 += -lmod_esp
endif
ifeq ($(BIT_PACK_SQLITE),1)
    LIBS_83 += -lsqlite3
endif
ifeq ($(BIT_PACK_SSL),1)
    LIBS_83 += -lmod_ssl
endif
LIBS_83 += -lmprssl
ifeq ($(BIT_PACK_EST),1)
    LIBS_83 += -lest
endif
ifeq ($(BIT_PACK_MATRIXSSL),1)
    LIBS_83 += -lmatrixssl
    LIBPATHS_83 += -L$(BIT_PACK_MATRIXSSL_PATH)
endif
ifeq ($(BIT_PACK_NANOSSL),1)
    LIBS_83 += -lssls
    LIBPATHS_83 += -L$(BIT_PACK_NANOSSL_PATH)/bin
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_83 += -lssl
    LIBPATHS_83 += -L$(BIT_PACK_OPENSSL_PATH)
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_83 += -lcrypto
    LIBPATHS_83 += -L$(BIT_PACK_OPENSSL_PATH)
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
    LIBS_83 += -lmod_ejs
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
    LIBS_83 += -lejs
endif
ifeq ($(BIT_PACK_PHP),1)
    LIBS_83 += -lmod_php
endif
ifeq ($(BIT_PACK_PHP),1)
    LIBS_83 += -lphp5
    LIBPATHS_83 += -L$(BIT_PACK_PHP_PATH)/libs
endif
ifeq ($(BIT_PACK_CGI),1)
    LIBS_83 += -lmod_cgi
endif

$(CONFIG)/bin/appweb.out: $(DEPS_83)
	@echo '      [Link] $(CONFIG)/bin/appweb.out'
	$(CC) -o $(CONFIG)/bin/appweb.out $(LDFLAGS) $(LIBPATHS)     "$(CONFIG)/obj/appweb.o" $(LIBPATHS_83) $(LIBS_83) $(LIBS_83) $(LIBS) -Wl,-r 

#
#   server-cache
#
src/server/cache: $(DEPS_84)
	( \
	cd src/server; \
	mkdir -p cache ; \
	)

#
#   testAppweb.h
#
$(CONFIG)/inc/testAppweb.h: $(DEPS_85)
	@echo '      [Copy] $(CONFIG)/inc/testAppweb.h'

#
#   testAppweb.o
#
DEPS_86 += $(CONFIG)/inc/bit.h
DEPS_86 += $(CONFIG)/inc/testAppweb.h
DEPS_86 += $(CONFIG)/inc/mpr.h
DEPS_86 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/testAppweb.o: \
    test/src/testAppweb.c $(DEPS_86)
	@echo '   [Compile] $(CONFIG)/obj/testAppweb.o'
	$(CC) -c -o $(CONFIG)/obj/testAppweb.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" test/src/testAppweb.c

#
#   testHttp.o
#
DEPS_87 += $(CONFIG)/inc/bit.h
DEPS_87 += $(CONFIG)/inc/testAppweb.h

$(CONFIG)/obj/testHttp.o: \
    test/src/testHttp.c $(DEPS_87)
	@echo '   [Compile] $(CONFIG)/obj/testHttp.o'
	$(CC) -c -o $(CONFIG)/obj/testHttp.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" test/src/testHttp.c

#
#   testAppweb
#
DEPS_88 += $(CONFIG)/inc/mpr.h
DEPS_88 += $(CONFIG)/inc/bit.h
DEPS_88 += $(CONFIG)/inc/bitos.h
DEPS_88 += $(CONFIG)/obj/mprLib.o
DEPS_88 += $(CONFIG)/bin/libmpr.a
DEPS_88 += $(CONFIG)/inc/pcre.h
DEPS_88 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_88 += $(CONFIG)/bin/libpcre.a
endif
DEPS_88 += $(CONFIG)/inc/http.h
DEPS_88 += $(CONFIG)/obj/httpLib.o
DEPS_88 += $(CONFIG)/bin/libhttp.a
DEPS_88 += $(CONFIG)/inc/appweb.h
DEPS_88 += $(CONFIG)/inc/customize.h
DEPS_88 += $(CONFIG)/obj/config.o
DEPS_88 += $(CONFIG)/obj/convenience.o
DEPS_88 += $(CONFIG)/obj/dirHandler.o
DEPS_88 += $(CONFIG)/obj/fileHandler.o
DEPS_88 += $(CONFIG)/obj/log.o
DEPS_88 += $(CONFIG)/obj/server.o
DEPS_88 += $(CONFIG)/bin/libappweb.a
DEPS_88 += $(CONFIG)/inc/testAppweb.h
DEPS_88 += $(CONFIG)/obj/testAppweb.o
DEPS_88 += $(CONFIG)/obj/testHttp.o

LIBS_88 += -lappweb
LIBS_88 += -lhttp
LIBS_88 += -lmpr
ifeq ($(BIT_PACK_PCRE),1)
    LIBS_88 += -lpcre
endif

$(CONFIG)/bin/testAppweb.out: $(DEPS_88)
	@echo '      [Link] $(CONFIG)/bin/testAppweb.out'
	$(CC) -o $(CONFIG)/bin/testAppweb.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/testAppweb.o" "$(CONFIG)/obj/testHttp.o" $(LIBPATHS_88) $(LIBS_88) $(LIBS_88) $(LIBS) -Wl,-r 

ifeq ($(BIT_PACK_CGI),1)
#
#   test-testScript
#
DEPS_89 += $(CONFIG)/inc/mpr.h
DEPS_89 += $(CONFIG)/inc/bit.h
DEPS_89 += $(CONFIG)/inc/bitos.h
DEPS_89 += $(CONFIG)/obj/mprLib.o
DEPS_89 += $(CONFIG)/bin/libmpr.a
DEPS_89 += $(CONFIG)/inc/pcre.h
DEPS_89 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_89 += $(CONFIG)/bin/libpcre.a
endif
DEPS_89 += $(CONFIG)/inc/http.h
DEPS_89 += $(CONFIG)/obj/httpLib.o
DEPS_89 += $(CONFIG)/bin/libhttp.a
DEPS_89 += $(CONFIG)/inc/appweb.h
DEPS_89 += $(CONFIG)/inc/customize.h
DEPS_89 += $(CONFIG)/obj/config.o
DEPS_89 += $(CONFIG)/obj/convenience.o
DEPS_89 += $(CONFIG)/obj/dirHandler.o
DEPS_89 += $(CONFIG)/obj/fileHandler.o
DEPS_89 += $(CONFIG)/obj/log.o
DEPS_89 += $(CONFIG)/obj/server.o
DEPS_89 += $(CONFIG)/bin/libappweb.a
DEPS_89 += $(CONFIG)/inc/testAppweb.h
DEPS_89 += $(CONFIG)/obj/testAppweb.o
DEPS_89 += $(CONFIG)/obj/testHttp.o
DEPS_89 += $(CONFIG)/bin/testAppweb.out

test/cgi-bin/testScript: $(DEPS_89)
	( \
	cd test; \
	echo '#!../$(CONFIG)/bin/cgiProgram.out' >cgi-bin/testScript ; chmod +x cgi-bin/testScript ; \
	)
endif

ifeq ($(BIT_PACK_CGI),1)
#
#   test-cache.cgi
#
DEPS_90 += $(CONFIG)/inc/mpr.h
DEPS_90 += $(CONFIG)/inc/bit.h
DEPS_90 += $(CONFIG)/inc/bitos.h
DEPS_90 += $(CONFIG)/obj/mprLib.o
DEPS_90 += $(CONFIG)/bin/libmpr.a
DEPS_90 += $(CONFIG)/inc/pcre.h
DEPS_90 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_90 += $(CONFIG)/bin/libpcre.a
endif
DEPS_90 += $(CONFIG)/inc/http.h
DEPS_90 += $(CONFIG)/obj/httpLib.o
DEPS_90 += $(CONFIG)/bin/libhttp.a
DEPS_90 += $(CONFIG)/inc/appweb.h
DEPS_90 += $(CONFIG)/inc/customize.h
DEPS_90 += $(CONFIG)/obj/config.o
DEPS_90 += $(CONFIG)/obj/convenience.o
DEPS_90 += $(CONFIG)/obj/dirHandler.o
DEPS_90 += $(CONFIG)/obj/fileHandler.o
DEPS_90 += $(CONFIG)/obj/log.o
DEPS_90 += $(CONFIG)/obj/server.o
DEPS_90 += $(CONFIG)/bin/libappweb.a
DEPS_90 += $(CONFIG)/inc/testAppweb.h
DEPS_90 += $(CONFIG)/obj/testAppweb.o
DEPS_90 += $(CONFIG)/obj/testHttp.o
DEPS_90 += $(CONFIG)/bin/testAppweb.out

test/web/caching/cache.cgi: $(DEPS_90)
	( \
	cd test; \
	echo "#!`type -p ejs`" >web/caching/cache.cgi ; \
	echo 'print("HTTP/1.0 200 OK\nContent-Type: text/plain\n\n{number:" + Date().now() + "}\n")' >>web/caching/cache.cgi ; \
	chmod +x web/caching/cache.cgi ; \
	)
endif

ifeq ($(BIT_PACK_CGI),1)
#
#   test-basic.cgi
#
DEPS_91 += $(CONFIG)/inc/mpr.h
DEPS_91 += $(CONFIG)/inc/bit.h
DEPS_91 += $(CONFIG)/inc/bitos.h
DEPS_91 += $(CONFIG)/obj/mprLib.o
DEPS_91 += $(CONFIG)/bin/libmpr.a
DEPS_91 += $(CONFIG)/inc/pcre.h
DEPS_91 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_91 += $(CONFIG)/bin/libpcre.a
endif
DEPS_91 += $(CONFIG)/inc/http.h
DEPS_91 += $(CONFIG)/obj/httpLib.o
DEPS_91 += $(CONFIG)/bin/libhttp.a
DEPS_91 += $(CONFIG)/inc/appweb.h
DEPS_91 += $(CONFIG)/inc/customize.h
DEPS_91 += $(CONFIG)/obj/config.o
DEPS_91 += $(CONFIG)/obj/convenience.o
DEPS_91 += $(CONFIG)/obj/dirHandler.o
DEPS_91 += $(CONFIG)/obj/fileHandler.o
DEPS_91 += $(CONFIG)/obj/log.o
DEPS_91 += $(CONFIG)/obj/server.o
DEPS_91 += $(CONFIG)/bin/libappweb.a
DEPS_91 += $(CONFIG)/inc/testAppweb.h
DEPS_91 += $(CONFIG)/obj/testAppweb.o
DEPS_91 += $(CONFIG)/obj/testHttp.o
DEPS_91 += $(CONFIG)/bin/testAppweb.out

test/web/auth/basic/basic.cgi: $(DEPS_91)
	( \
	cd test; \
	echo "#!`type -p ejs`" >web/auth/basic/basic.cgi ; \
	echo 'print("HTTP/1.0 200 OK\nContent-Type: text/plain\n\n" + serialize(App.env, {pretty: true}) + "\n")' >>web/auth/basic/basic.cgi ; \
	chmod +x web/auth/basic/basic.cgi ; \
	)
endif

ifeq ($(BIT_PACK_CGI),1)
#
#   test-cgiProgram
#
DEPS_92 += $(CONFIG)/inc/bit.h
DEPS_92 += $(CONFIG)/obj/cgiProgram.o
DEPS_92 += $(CONFIG)/bin/cgiProgram.out

test/cgi-bin/cgiProgram.out: $(DEPS_92)
	( \
	cd test; \
	cp ../$(CONFIG)/bin/cgiProgram.out cgi-bin/cgiProgram.out ; \
	cp ../$(CONFIG)/bin/cgiProgram.out cgi-bin/nph-cgiProgram.out ; \
	cp ../$(CONFIG)/bin/cgiProgram.out 'cgi-bin/cgi Program.out' ; \
	cp ../$(CONFIG)/bin/cgiProgram.out web/cgiProgram.cgi ; \
	chmod +x cgi-bin/* web/cgiProgram.cgi ; \
	)
endif

#
#   installBinary
#
installBinary: $(DEPS_93)

#
#   install
#
DEPS_94 += compile
DEPS_94 += installBinary

install: $(DEPS_94)


#
#   uninstall
#
DEPS_95 += build
DEPS_95 += compile

uninstall: $(DEPS_95)
	( \
	cd package; \
	rm -f "$(BIT_VAPP_PREFIX)/appweb.conf" ; \
	rm -f "$(BIT_VAPP_PREFIX)/esp.conf" ; \
	rm -f "$(BIT_VAPP_PREFIX)/mine.types" ; \
	rm -f "$(BIT_VAPP_PREFIX)/install.conf" ; \
	rm -fr "$(BIT_VAPP_PREFIX)/inc/appweb" ; \
	)

#
#   genslink
#
genslink: $(DEPS_96)
	( \
	cd src/server; \
	esp --static --genlink slink.c compile ; \
	)


#
#   run
#
DEPS_97 += compile

run: $(DEPS_97)
	( \
	cd src/server; \
	sudo ../../$(CONFIG)/bin/appweb -v ; \
	)

