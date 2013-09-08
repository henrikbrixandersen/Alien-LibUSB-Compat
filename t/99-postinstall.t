#!/usr/bin/perl -w

use strict;

use Test::More;
use Alien::LibUSB::Compat;

my $libusb = Alien::LibUSB::Compat->new;

if ($libusb->install_type eq 'system' || $ENV{POSTINSTALL_TESTING}) {
    eval 'use Inline';
    if ($@) {
        plan(skip_all => 'Inline required');
    } else {
        plan tests => 1;
    }
} else {
    plan(skip_all => 'Skipping post-install tests');
}

my $c = <<END;
#include <usb.h>

void
init()
{
    /* Not many handles for us to test here without making assumptions about
       the USB busses/devices available on the system. This will have to do. */
    usb_init();
}
END

Inline->bind(C => $c, CCFLAGS => $libusb->cflags, LIBS => $libusb->libs);

eval "init()";
pass('Initialize libusb-0.1') unless $@;

my $type = $libusb->install_type;
diag "Initialized libusb-0.1, install type $type\n";

