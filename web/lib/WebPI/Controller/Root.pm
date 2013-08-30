package WebPI::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config( namespace => '' );

=encoding utf-8

=head1 NAME

WebPI::Controller::Root - Root Controller for WebPI

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    $self->root($c);

}

sub root : Chained('/') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash->{c_req_path} = $c->req->path;

    $c->load_status_msgs;
    my $status_msg = $c->stash->{status_msg};
    my $error_msg  = $c->stash->{error_msg};

    @{ $c->stash }{ keys %$status_msg } = values %$status_msg if ref $status_msg eq 'HASH';
    @{ $c->stash }{ keys %$error_msg }  = values %$error_msg  if ref $error_msg eq 'HASH';

    my ($class, $action) = ($c->action->class, $c->action->name);
    $class =~ s/^WebPI::Controller:://;
    $class =~ s/::/-/g;

    $c->stash->{body_class} = lc "$class $class-$action";

    if ($c->user){
        if ( grep { /^user$/ } $c->user->roles ) {
        $c->stash->{role_controller} = 'user';
        }elsif ( grep { /^admin-tracker$/ } $c->user->roles ) {
        $c->stash->{role_controller} = 'trackermanager';
        }elsif ( grep { /^admin$/ } $c->user->roles ) {
        $c->stash->{role_controller} = 'admin';
        }

    }
}

=head2 default

Standard 404 error page

=cut

sub default : Path {
    my ( $self, $c ) = @_;

    $self->root($c);
    my $maybe_view = join '/', @{ $c->req->arguments };
    my $output;
    eval {
        $c->stash->{body_class} .= ' ' . $maybe_view;
        $c->stash->{body_class} =~ s/\//-/g;
        $output = $c->view('TT')->render( $c, "auto/$maybe_view.tt" );
    };
    if ( $@ && $@ =~ /not found$/ ) {
        $c->response->body('Page not found');
        $c->response->status(404);
    }
    elsif ( !$@ ) {
        $c->response->body($output);
    }
    else {
        die $@;
    }
}

sub rest_error : Private {
    my ( $self, $c ) = @_;

    $c->stash->{template}        = 'rest_error.tt';
    $c->stash->{without_wrapper} = 1;

    # TODO enviar um email se não estiver com $c->debug ?
    $c->res->status(500);

}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
    my ( $self, $c ) = @_;

    if ($c->debug){
        my $x = $c->stash;
        use DDP; p $x;
    }
}

=head1 AUTHOR

renato,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
