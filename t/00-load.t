#!/usr/bin/perl -w

use strict;

use Test::More tests => 2;

BEGIN { use_ok('Alien::LibUSB::Compat') };
require_ok('Alien::LibUSB::Compat');

diag("Testing Alien::LibUSB::Compat $Alien::LibUSB::Compat::VERSION, Perl $], $^X");
