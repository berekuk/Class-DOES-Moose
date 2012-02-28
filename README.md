# Class-DOES-Moose

Class::DOES::Moose provides a syntax sugar for adding extra non-Moose roles to your classes DOES() calls.

## Synopsis

    use Moose;
    use Class::DOES::Moose;

    extra_does qw/ My::Foo My::Bar /;

    __PACKAGE__->new->DOES('My::Foo'); # 1
    __PACKAGE__->new->does('My::Foo'); # 0

