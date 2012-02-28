package Class::DOES::Moose::Role;

use namespace::autoclean;
use Moose::Role;

around 'DOES' => sub {
    my $orig = shift;
    my $self = shift;

    return 1 if $self->$orig(@_);

    my @roles = $self->meta->calculate_all_roles_with_inheritance;
    @roles = grep { $_->{extra_does} } @roles;
    return 1 if grep { $_[0] eq $_ } map { @{ $_->{extra_does} } } @roles;

    return 0;
};

1;
