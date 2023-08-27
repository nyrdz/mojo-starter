package MyApp::Controller;
use v5.36;
use Mojo::Base 'Mojolicious::Controller';
use Scalar::Util qw( refaddr );

my %ACCEPTED_ATTRIBUTES = (
    GET    => 1,
    POST   => 1,
    DELETE => 1,
    PATCH  => 1,
    HEAD   => 1,
);

my %attrs;

sub MODIFY_CODE_ATTRIBUTES {
    my ( $package, $subref, @attrs ) = @_;
    $attrs{ refaddr $subref } = [ grep { $ACCEPTED_ATTRIBUTES{$_} } @attrs ];
    return;
}

sub FETCH_CODE_ATTRIBUTES {
    my ( $package, $subref ) = @_;
    my $attrs = $attrs{ refaddr $subref } // [];
    return @{$attrs};
}

1;
