## -*- mode: Makefile; c-indent-level: 4; c-basic-offset: 4;  tab-width: 8; -*-
##
## Qt usage example for RInside, inspired by the standard 'density
## sliders' example for other GUI toolkits
##
## This file can be used across operating systems as qmake selects appropriate 
## values as needed, as do the R and R-related calls below. See the thread at
##     http://thread.gmane.org/gmane.comp.lang.r.rcpp/4376/focus=4402
## for discussion specific to Windows.
##
## Copyright (C) 2012  Dirk Eddelbuettel and Romain Francois

## build an app based on the one headers and two source files

windows:CONFIG += c++11
macx:CONFIG += c++11
linux:CONFIG += c++11


TARGET = qtdensity
TEMPLATE = app


## beyond the default configuration, also use SVG graphics
QT += svg

## comment this out if you need a different version of R, 
## and set set R_HOME accordingly as an environment variable
R_HOME = 		$$system(R RHOME)
message("R_HOME is" $$R_HOME)


windows {
    isEmpty(R_HOME):R_HOME = $$OUT_PWD/../R
        message(QT_ARCH $$QT_ARCH)
        contains(QT_ARCH, i386) {
                ARCH = i386
        } else {
                ARCH = x64
        }
}

## addition clean targets
QMAKE_CLEAN +=		qtdensity Makefile

INCLUDEPATH += ./Rcpp/inst/include


DEFINES += QT_DEPRECATED_WARNINGS


HEADERS =		qtdensity.h \
    RInside/Callbacks.h \
    RInside/MemBuf.h \
    RInside/RInside.h \
    RInside/RInsideCommon.h \
    RInside/RInsideConfig.h \
    qtdensity.h \
    RInside/RInsideEnvVars.h \
    RInside/RInsideAutoloads.h

SOURCES = 		qtdensity.cpp main.cpp \
    RInside/MemBuf.cpp \
    RInside/RInside.cpp


INCLUDEPATH += \
    $$R_HOME/library/Rcpp/include \
    $$R_HOME/include

linux:INCLUDEPATH += \
    /usr/share/R/include \
    /usr/lib/R/library/include \
    $$R_HOME/site-library/Rcpp/include

macx:LIBS += \
    -L$$R_HOME/lib -lR

win32:LIBS += \
    -L$$R_HOME/bin/$$ARCH -lR

