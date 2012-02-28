package Class::DOES::Moose::Role;

use namespace::autoclean;
use Moose::Role;

around 'DOES' => sub {
    my $orig = shift;
    my $self = shift;
    my ($role) = @_;

    return 1 if $self->$orig(@_);
    my $meta = $self->meta;
    unless ($meta->{extra_does_cache}) {
        my @meta = map { $_->meta, $_->meta->calculate_all_roles } $self, $meta->linearized_isa;
        my %does = map { $_ => 1 } map { @{ $_->{extra_does} } } grep { $_->{extra_does} } @meta;
        $meta->{extra_does_cache} = \%does;
    }

    return $meta->{extra_does_cache}{$role} || 0;
};

1;
