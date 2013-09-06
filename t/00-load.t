#!/usr/bin/perl -w

use strict;

use Config;
use Test::More tests => 5;

BEGIN { use_ok('Alien::LibUSB::Compat') };
require_ok('Alien::LibUSB::Compat');

diag("Testing Alien::LibUSB::Compat $Alien::LibUSB::Compat::VERSION, Perl $], $^X, OS $^O ($Config{'archname'})");

my $alien = new_ok('Alien::LibUSB::Compat');

isa_ok($alien, 'Alien::Base');

can_ok($alien, qw/cflags libs/);
