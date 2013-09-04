#!/usr/bin/perl

use strict;
use warnings;

use Alien::Base::ModuleBuild;
use Alien::LibUSBx;

my $libusb_compat_version = '0.1.5';

# Mirror list: http://sourceforge.net/apps/trac/sourceforge/wiki/Mirrors
my @mirrors = qw/aarnet dfn freefr garr heanet hivelocity internode
jaist kaz kent master nchc netcologne softlayer-dal switch tenet ufpr
waix/;

my @alien_repos;
foreach my $mirror (@mirrors) {
    my $alien_repo = {
        host => "$mirror.dl.sourceforge.net",
    };
    push @alien_repos, $alien_repo;
}

my $libusbx = Alien::LibUSBx->new;
my $cflags = $libusbx->cflags();
my $libs = $libusbx->libs();

my $builder = Alien::Base::ModuleBuild->new(
    module_name => 'Alien::LibUSB::Compat',
    dist_author => 'Henrik Brix Andersen <brix@cpan.org>',
    license  => 'perl',

    configure_requires => {
        'Alien::Base' => '0.003',
        'Module::Build' => '0.4004',
        'Alien::LibUSBx' => '0.01',
    },

    test_requires => {
        'Test::More' => '0',
    },

    requires => {
        'perl' => '5.006',
        'Alien::Base' => '0.003',
        'Alien::LibUSBx' => '0.01',
    },

    alien_name => 'libusbx',
    alien_repository_default => {
        protocol => 'http',
        location => "/project/libusb/libusb-compat-0.1/libusb-compat-$libusb_compat_version",
        exact_filename => "libusb-compat-$libusb_compat_version.tar.bz2",
        exact_version => $libusb_compat_version,
    },
    alien_repository => \@alien_repos,
    alien_build_commands => [
        "env LIBUSB_1_0_CFLAGS='$cflags' LIBUSB_1_0_LIBS='$libs' %pconfigure --prefix=%s",
        'make',
    ],
);

$builder->create_build_script;
