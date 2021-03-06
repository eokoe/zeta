package WebZeta::Controller::Form::Login;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/form/root') : PathPart('') : CaptureArgs(0) {
}

sub login : Chained('base') : PathPart('login') : Args(0) {
    my ( $self, $c ) = @_;
    
    if ( $c->authenticate( $c->req->params ) ) {
        if ( $c->req->param('remember') ) {
            $c->session_time_to_live(2629743)    # 1 month
        }
        else {
            $c->session_time_to_live(14400)      # 4h
        }

        $self->after_login($c);

    }
    else {
        $c->detach( '/form/redirect_error', [] );
    }
}

sub after_login {
    my ( $self, $c ) = @_;
    my $url = \'/';
    if ( grep { /^user$/ } $c->user->roles ) {
        $url = '/user/dashboard/index';
    }
    elsif ( grep { /^admin|organization$/ } $c->user->roles ) {
        $url = '/admin/dashboard/index';
    }
    
	if ($c->req->params->{redirect_to} && $c->req->params->{redirect_to} =~ /^\//){
		$url = $c->req->params->{redirect_to};
		$c->res->redirect($url);
		$c->detach;
	}

    $c->detach( '/form/redirect_ok', [ $url, {}, 'Bem vindo, ' . $c->user->name ] );
}

__PACKAGE__->meta->make_immutable;

1;
