package Class::DOES::Moose;

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
    my @does = shift;

    if (defined $MooseX::Role::Parameterized::CURRENT_METACLASS) {
        $meta = $MooseX::Role::Parameterized::CURRENT_METACLASS;
    }

#    warn Dumper($meta->{extra_does});
    push @{ $meta->{extra_does} }, @does;
#    warn Dumper($meta->{extra_does});
    #$meta->add_attribute('extra_does' => (
    #    is => 'ro',
    #    isa => 'ArrayRef',
    #    default => sub { \@does },
    #));

    Moose::Util::apply_all_roles($meta, 'Class::DOES::Moose::Role');
}

1;
