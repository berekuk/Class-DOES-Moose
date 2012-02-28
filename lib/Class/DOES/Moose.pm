package Class::DOES::Moose;

# ABSTRACT: syntax sugar for adding extra non-Moose roles to Moose classes

=head1 SYNOPSIS

    use Moose;
    use Class::DOES::Moose;

    extra_does qw/ My::Foo My::Bar /;

    __PACKAGE__->new->DOES('My::Foo'); # 1
    __PACKAGE__->new->does('My::Foo'); # 0

=cut

use namespace::autoclean;

use Moose ();
use Moose::Exporter;

use Moose::Util;
use Class::DOES::Moose::Role;

Moose::Exporter->setup_import_methods(
    with_meta => ['extra_does'],
);

sub extra_does {
    my $meta = shift;
    my @does = @_;

    if (defined $MooseX::Role::Parameterized::CURRENT_METACLASS) {
        $meta = $MooseX::Role::Parameterized::CURRENT_METACLASS;
    }

    push @{ $meta->{extra_does} }, @does;

    Moose::Util::apply_all_roles($meta, 'Class::DOES::Moose::Role');
}

=head1 SEE ALSO

L<Class::DOES>

=cut

1;
