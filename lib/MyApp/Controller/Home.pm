package MyApp::Controller::Home;
use v5.36;
use Mojo::Base 'MyApp::Controller';

sub _index : GET ($c) {
    $c->render();
}

1;
