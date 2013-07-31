package WebPI::Controller::Form::Logout;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }


sub base : Chained('/root') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->response->headers->header( 'charset' => 'utf-8' );
}

sub logout: Chained('base') : PathPart('logout') : Args(0) {
    my ( $self, $c ) = @_;

    $c->logout;

    $c->detach( '/form/redirect_ok', [ '/', 'Volte sempre!' ] );
}


__PACKAGE__->meta->make_immutable;

1;