#!/usr/bin/perl

use strict;
use warnings;

use lib 'lib';
use Test::More;

{
    package R;
    use Moose::Role;

    use Class::DOES::Moose;

    extra_does qw/ foo bar /;

    package X;
    use Moose;
    with 'R';

}

ok(X->new->DOES('foo'));

done_testing;
