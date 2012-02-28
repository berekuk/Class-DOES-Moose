package Class::DOES::Moose::Role;

use namespace::autoclean;
use Moose::Role;

around 'DOES' => sub {
    my $orig = shift;
    my $self = shift;

    return 1 if $self->$orig(@_);

    my @meta = map { $_->meta, $_->meta->calculate_all_roles_with_inheritance } $self, $self->meta->linearized_isa;
    @meta = grep { $_->{extra_does} } @meta;
    return 1 if grep { $_[0] eq $_ } map { @{ $_->{extra_does} } } @meta;

    return 0;
};

1;
