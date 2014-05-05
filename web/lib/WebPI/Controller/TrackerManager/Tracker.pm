package WebPI::Controller::TrackerManager::Tracker;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/trackermanager/base') : PathPart('tracker') : CaptureArgs(0) {
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');
    $api->stash_result( $c, [ 'trackers', $id ], stash => 'tracker_obj' );

    $c->detach( '/form/not_found', [] ) if $c->stash->{tracker_obj}{error};
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    
    my $api = $c->model('API');

    my %params;

    if( exists $c->req->params->{search} ) {
        if( $c->req->params->{search_type} eq 'vehicle_id' && $c->req->params->{search}) {

            $params{vehicle_id} = $c->req->params->{search};

        } elsif ( $c->req->params->{search_type} eq 'code' && $c->req->params->{search}) {

            $params{code} = $c->req->params->{search};

        }
    }

    $api->stash_result(
        $c, ['trackers'],
        params => {
            %params
        }
    );
}

sub edit : Chained('object') : PathPart('') : Args(0) {
    my ($self, $c) = @_;

    my $t_obj   = $c->stash->{tracker_obj};
    my $api     = $c->model('API');

    $api->stash_result(
        $c, ['vehicles', $t_obj->{vehicle_id}],
        stash => 'associated_car',
    );

    $api->stash_result(
        $c, ['drivers', $c->stash->{associated_car}{driver_id}],
        stash => 'associated_driver',
    );
}

sub add : Chained('base') : PathPart('new') : Args(0) {
    my ( $self, $c ) = @_;
}

sub activate : Chained('base') : PathPart('activate') : Args(0) {
    my ( $self, $c ) = @_;
}

__PACKAGE__->meta->make_immutable;

1;
