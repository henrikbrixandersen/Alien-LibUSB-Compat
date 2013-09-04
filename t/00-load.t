#!/usr/bin/perl

use 5.006;
use strict;
use warnings FATAL => 'all';

use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Alien::LibUSB::Compat' ) || print "Bail out!\n";
}

diag( "Testing Alien::LibUSB::Compat $Alien::LibUSB::Compat::VERSION, Perl $], $^X" );
