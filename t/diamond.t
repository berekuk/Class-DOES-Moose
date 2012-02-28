#!/usr/bin/perl

use strict;
use warnings;

use lib 'lib';
use Test::More;

{
    package S1;
    use Moose::Role;
    use Class::DOES::Moose;
    extra_does qw/ foo /;

    package S2;
    use Moose::Role;
    with 'S1';
    use Class::DOES::Moose;
    extra_does qw/ bar /;

    package S3;
    use Moose::Role;
    with 'S1';
    use Class::DOES::Moose;
    extra_does qw/ baz /;

    package Z;
    use Moose;
    with 'S2', 'S3';
}

ok(Z->new->DOES('foo'));
ok(Z->new->DOES('bar'));
ok(Z->new->DOES('baz'));

done_testing;
