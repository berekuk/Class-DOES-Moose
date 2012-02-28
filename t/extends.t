#!/usr/bin/perl

use strict;
use warnings;

use lib 'lib';
use Test::More;

{
    package X;
    use Moose;
    use Class::DOES::Moose;
    extra_does qw/ foo bar /;

    package Y;
    use Moose;
    extends 'X';

}

ok(Y->new->DOES('foo'));

done_testing;
