#!/usr/bin/perl

use strict;
use warnings;

use lib 'lib';
use Test::More;

{
    package T;
    use MooseX::Role::Parameterized;

    use Class::DOES::Moose;

    parameter 'param' => (is => 'ro', required => 1);

    role {
        my $p = shift;
        extra_does ($p->param);
    };

    package Y1;
    use Moose;
    with 'T' => { param => 'xxx' };

    package Y2;
    use Moose;
    with 'T' => { param => 'yyy' };

}

ok(Y1->new->DOES('xxx'));
ok(not Y1->new->DOES('yyy'));
ok(not Y2->new->DOES('xxx'));
ok(Y2->new->DOES('yyy'));

done_testing;
