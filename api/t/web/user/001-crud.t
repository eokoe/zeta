use utf8;
use FindBin qw($Bin);
use lib "$Bin/../../lib";

use Zeta::Test::Further;

api_auth_as user_id => 1, roles => ['superadmin'];

db_transaction {

    rest_post '/users',
      name  => 'criar usuario',
      list  => 1,
      stash => 'user',
      [
        name             => 'Foo Bar',
        email            => 'foo1@email.com',
        password         => 'foobarquux1',
        password_confirm => 'foobarquux1',
        role             => 'user',
		is_active		 => 1
      ];

    stash_test 'user.get', sub {
        my ($me) = @_;

        is( $me->{id},    stash 'user.id',  'get has the same id!' );
        is( $me->{email}, 'foo1@email.com', 'email ok!' );
    };

    stash_test 'user.list', sub {
        my ($me) = @_;

        ok( $me = delete $me->{users}, 'users list exists' );
        is( @$me, 4, '4 users' );

        $me = [ sort { $a->{id} <=> $b->{id} } @$me ];

        is( $me->[3]{email}, 'foo1@email.com', 'listing ok' );
    };

    rest_put stash 'user.url',
      name => 'atualizar usuario',
      [
        name             => 'AAAAAAAAA',
        email            => 'foo2@email.com',
        password         => 'foobarquux1',
        password_confirm => 'foobarquux1',
        role             => 'user',
		is_active		 => 1
      ];

    rest_reload 'user';

    stash_test 'user.get', sub {
        my ($me) = @_;

        is( $me->{email}, 'foo2@email.com', 'email updated!' );
    };

    rest_delete stash 'user.url';

    rest_reload 'user';
    
    stash_test 'user.get', sub {
		my ($me) = @_;
		
		is( $me->{is_active}, 0, 'user deactivated' );
	};

    rest_reload_list 'user';

    stash_test 'user.list', sub {
        my ($me) = @_;

        ok( $me = delete $me->{users}, 'users list exists' );

        is( @$me, 4, '4 users' );

        is( $me->[0]{email}, 'superadmin@email.com', 'listing ok' );
    };

};

done_testing;