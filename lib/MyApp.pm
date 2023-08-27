package MyApp;
use v5.36;
use Mojo::Base 'Mojolicious';
use Namespace::Subroutines ();

# This method will run once at server start
sub startup ($self) {

    $self->plugin('AutoReload');

    # Load configuration from config file
    my $config = $self->plugin('NotYAMLConfig');

    # Configure the application
    $self->secrets( $config->{secrets} );

    $self->plugin('DefaultHelpers');

    # Router
    my $r = $self->routes;
    $r->namespaces( [ 'MyApp::Public::Controller', 'MyApp::Controller' ] );

    Namespace::Subroutines::find(
        'MyApp::Public::Controller',
        register_endpoint($r)
    );

    $r->get( '/app' => sub ($c) { $c->redirect_to('/app/home') } );
    my $app = $r->under( '/app' => \&check_session );

    Namespace::Subroutines::find(
        'MyApp::Controller',
        register_endpoint($app)
    );
}

sub register_endpoint {
    my $router = shift;
    sub ( $mod, $subname, $subref, $attrs ) {
        my $controller = join( '::', $mod->@* );
        pop $mod->@* if $mod->[0] eq 'Index';
        my @path = $mod->@*;
        push @path, $subname unless $subname eq '_index';
        my $path = '/' . lc join( '/', @path );
        foreach my $verb ( $attrs->@* ) {
            $verb = lc $verb;
            $router->$verb($path)
                ->to( controller => $controller, action => $subname );
        }
    }
}

sub check_session ($c) {
    return 1 if $c->session('session_id');
    $c->redirect_to('/auth');
    return undef;
}

1;
