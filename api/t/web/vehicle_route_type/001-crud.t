use utf8;
use FindBin qw($Bin);
use lib "$Bin/../../lib";

use Zeta::Test::Further;

api_auth_as user_id => 1, roles => ['superadmin'];

db_transaction {

    #criar novo endereço
    rest_post '/addresses',
      name  => 'criar novo endereço',
      list  => 1,
      stash => 'address',
      [
        address      => 'Av. Paulista',
        number       => '568',
        neighborhood => 'Bela Vista',
        user_id      => 1,
        postal_code  => '01310000'
      ];

    #criar novo tipo de estacionamento
    rest_post '/vehicle_parking_types',
      name  => 'criar novo tipo de estacionamento',
      list  => 1,
      stash => 'vehicle_parking_type',
      [ name => 'Galpão fechado' ];

    #criar novo estacionamento
    rest_post '/vehicle_parking',
      name  => 'criar estacionamento veiculos',
      list  => 1,
      stash => 'vehicle_parking',
      [
        arrival_time            => '09:00:00',
        departure_time          => '18:00:00',
        address_id              => stash 'address.id',
        name                    => 'Casa',
        user_id                 => 1,
        vehicle_parking_type_id => stash 'vehicle_parking_type.id',
      ];

    #criar novo profile de rota
    rest_post '/vehicle_route_types',
      name  => 'criar tipo de rota de veiculos',
      list  => 1,
      stash => 'vehicle_route_type',
      [
        name               => 'Casa',
        address_id         => stash 'address.id',
        vehicle_parking_id => stash 'vehicle_parking.id'
      ];

    stash_test 'vehicle_route_type.get', sub {
        my ($me) = @_;

        is( $me->{id}, stash 'vehicle_route_type.id', 'get has the same id!' );
    };

    stash_test 'vehicle_route_type.list', sub {
        my ($me) = @_;

        ok( $me = delete $me->{vehicle_route_types}, 'vehicle_route_type list exists' );

        is( @$me, 1, '1 vehicle_route_type' );

        $me = [ sort { $a->{id} cmp $b->{id} } @$me ];

        is( $me->[0]{name}, 'Casa', 'listing ok' );
    };

    rest_put stash 'vehicle_route_type.url',
      name => 'atualizar rota',
      [ name => 'Trabalho', ];

    rest_reload 'vehicle_route_type';

    stash_test 'vehicle_route_type.get', sub {
        my ($me) = @_;

        is( $me->{id}, stash 'vehicle_route_type.id', 'get has the same id!' );
        is( $me->{name}, 'Trabalho', 'route type updated!' );
    };

    rest_delete stash 'vehicle_route_type.url';

    rest_reload 'vehicle_route_type', 404;

    rest_reload_list 'vehicle_route_type';

    stash_test 'vehicle_route_type.list', sub {
        my ($me) = @_;
        ok( $me = delete $me->{vehicle_route_types}, 'vehicle_route_type list exists' );

        is( @$me, 0, '0 vehicle_route_type' );
    };
};

done_testing;
