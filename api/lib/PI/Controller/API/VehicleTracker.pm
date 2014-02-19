package PI::Controller::API::VehicleTracker;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::VehicleTracker',
    object_key => 'vehicle_tracker',

    update_roles => [qw/superadmin user admin-tracker/],
    create_roles => [qw/superadmin user admin-tracker/],
    delete_roles => [qw/superadmin user admin-tracker/],

    search_ok => {
        vehicle_id => 'Int',
        tracker_id => 'Int'
    }
);
with 'PI::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('vehicle_trackers') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $vehicle_tracker = $c->stash->{vehicle_tracker};
    my %attrs           = $vehicle_tracker->get_inflated_columns;
    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $attrs{$_}, }
                  qw/
                  id
                  tracker_id
                  lat
                  lng
                  vehicle_id
                  speed
                  sat_number
                  hdop
                  /
            ),
            ( map { $_ => $vehicle_tracker->$_->datetime } qw/created_at track_event/ )
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $vehicle_tracker = $c->stash->{vehicle_tracker};

    $vehicle_tracker->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $vehicle_tracker = $c->stash->{vehicle_tracker};

    $vehicle_tracker->execute( $c, for => 'update', with => $c->req->params );
    $self->status_accepted(
        $c,
        location => $c->uri_for( $self->action_for('result'), [ $vehicle_tracker->id ] )->as_string,
        entity => {
            vehicle_id => $vehicle_tracker->vehicle_id,
            tracker_id => $vehicle_tracker->tracker_id,
            id         => $vehicle_tracker->id
        }
      ),
      $c->detach
      if $vehicle_tracker;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') {
}

sub list_GET {
    my ( $self, $c ) = @_;

    my $rs = $c->stash->{collection};

    if ( $c->req->params->{date} ) {

        my $rs = $c->model('DB::ViewVehicleTracker');

        my $data = $rs->search_rs(
            undef,
            {
                bind  => [
                    $c->req->params->{date} . ' 00:00:00',
                    $c->req->params->{date} . ' 23:59:59',
                    $c->req->params->{tracker_id},
                    $c->req->params->{vehicle_id}
                ],
            }
        );

        $self->status_ok(
            $c,
            entity => {
                vehicle_trackers => [
                    map {
                        my $r = $_;
                        +{
                            (
                                map { $_ => $r->get_column($_) }
                                qw/
                                lat
                                lng
                                speed
                                track_event
                                sat_number
                                hdop
                                /
                            ),
                        },
                    } $data->all
                ]
            }
        );

    } else {

        $self->status_ok(
            $c,
            entity => {
                vehicle_trackers => [
                    map {
                        my $r = $_;
                        +{
                            (
                                map { $_ => $r->{$_} }
                                qw/
                                id
                                tracker_id
                                lat
                                lng
                                vehicle_id
                                speed
                                track_event
                                sat_number
                                hdop
                                /
                            ),
                            url => $c->uri_for_action( $self->action_for('result'), [ $r->{id} ] )->as_string
                        },
                    } $rs->as_hashref->all
                ]
            }
        );

    }
}

sub list_POST {
    my ( $self, $c ) = @_;

    my $vehicle_tracker = $c->stash->{collection}->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'), [ $vehicle_tracker->id ] )->as_string,
        entity => {
            id => $vehicle_tracker->id
        }
    );

}

1;
