use utf8;
use strict;
use warnings;

use lib './lib';
use FindBin qw($Bin);
use lib "$Bin/../lib";

use JSON::XS;
use PI::Redis;
use PI::TrackingManager;

use DDP;

package PI;
use Catalyst qw( ConfigLoader  );

__PACKAGE__->setup();

package main;

my $coder                   = JSON::XS->new;
my $redis                   = PI::Redis->new();
my $schema                  = PI->model('DB')->schema;
my $tracking_manager        = PI::TrackingManager->new( { schema => $schema } );

&process;

sub process {
    print "Consumer initialized successfully, waiting for data.......\n";

    eval {
        while (1) {
            my ( $list, $trackers ) = $redis->redis->blpop( 'new_trackers', 0 );

            open(my $fh, '>>', 'tracker_new.log');

            if( $trackers ) {
                if ( !$tracking_manager->new_tracker($trackers) ) {
                    print $fh "Error adding new trackers: ".$trackers."\n";
                }
            }

            close $fh;

            next;
        }
    };

    print $@ if $@;
}