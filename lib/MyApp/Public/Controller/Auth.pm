package MyApp::Public::Controller::Auth;
use v5.36;
use Mojo::Base 'MyApp::Controller';

sub _index : GET ($c) {
    $c->render();
}

sub sign_in : POST ($c) {
    my $username = $c->param('username');
    my $password = $c->param('password');
    if ( $username eq lc 'admin' && $password eq '123123' ) {
        $c->session(
            session_id => '12341234',
            name       => 'Admin',
            expiration => 60 * 30,
        );
        $c->redirect_to('/app');
        return;
    }
    $c->flash( err_msg => 'Bad credentials' );
    $c->redirect_to('/auth');
}

sub sign_out : GET ($c) {
    $c->session( expires => 1 );
    $c->redirect_to('/');
}

1;
