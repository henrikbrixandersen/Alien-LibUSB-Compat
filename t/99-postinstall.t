#!/usr/bin/perl -w

use strict;

use Test::More;

unless ($ENV{POSTINSTALL_TESTING}) {
    plan(skip_all => "Skipping post-install tests");
} else {
    plan tests => 1;
}

my $libusb;
BEGIN {
    use Alien::LibUSB::Compat;
    $libusb = Alien::LibUSB::Compat->new;
}
use Inline (C => 'DATA', CCFLAGS => $libusb->cflags, LIBS => $libusb->libs);

eval "init()";
pass("init()") unless $@;

my $type = $libusb->install_type;
diag "Initialized libusb-0.1, install type $type\n";

__DATA__
__C__

#include <usb.h>

void
init()
{
    /* Not many handles for us to test here without making assumptions about
       the USB busses/devices available on the system. This will have to do. */
    usb_init();
}
