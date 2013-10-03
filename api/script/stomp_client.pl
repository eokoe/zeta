use strict;
use warnings;
use utf8;
use lib './lib';
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Furl;
use Net::Stomp;
use JSON::XS;
use XML::LibXML::Simple;
use PI::TrackingManager;

package PI;
use Catalyst qw( ConfigLoader  );

__PACKAGE__->setup();

package main;

my $schema      = PI->model('DB')->schema;
my $coder       = JSON::XS->new;
my $host        = '184.106.196.147';
my $port        = 61613;
my $user_id     = "pi";
my $pass        = "Inte11Ad";
my $queue_name  = "/queue/DEVREP.PIPE.PI";

my $tracking_manager    = PI::TrackingManager->new( { schema => $schema } );
my $stomp               = Net::Stomp->new( { hostname => $host, port => $port } );

eval { $stomp->connect( { login => $user_id, passcode => $pass } ); };

die $@ if $@;

&process;

sub process {
   $stomp->subscribe({
        destination             => $queue_name,
        'ack'                   => 'client',
        'activemq.prefetchSize' => 1
    });

    my $xml_parser = XML::LibXML::Simple->new();

    print "Consumer initialized successfully, waiting for data.......\n";

    eval {
        while (1) {
            my $frame = $stomp->receive_frame;

            my $data = $xml_parser->XMLin(
                $frame->body,
                ForceArray => 1
            );

            my ( $y, $m, $d, $h, $i, $s )   = $data->{happened} =~ m/^(\d{4})(\d{1,2})(\d{1,2})(\d{1,2})(\d{1,2})(\d{1,2})$/;
            my $date = "$y-$m-$d $h:$i:$s";

            eval {
                $tracking_manager->add(
                    tracker_code    => $data->{deviceIdentifier},
                    latitude        => $data->{latitude},
                    longitude       => $data->{longitude},
                    speed           => $data->{speed},
                    track_event     => $date,
                );
            };

            if ( $@ ) {
#                 insere no erro
            } else {
                $stomp->ack( { frame => $frame } );
            }

        }
    };

    use DDP; p $@ if $@;

    $stomp->disconnect;
}