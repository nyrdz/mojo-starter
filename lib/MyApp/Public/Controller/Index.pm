package MyApp::Public::Controller::Index;
use v5.36;
use Mojo::Base 'MyApp::Controller';

sub _index : GET ($c) {
    $c->render( template => '_index' );
}

1;
