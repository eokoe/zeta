package WebZeta::Controller::Candidate;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/root') : PathPart('') : CaptureArgs(0) { }

sub candidate_profile : Chained('base') : PathPart('perfil-candidato') : Args(1) {
	my ( $self, $c, $candidate_id ) = @_;
	
	my $api = $c->model('API');
	
	$api->stash_result(
		$c, [ 'candidates', $candidate_id ],
		stash => 'candidate_obj'
	);
	
	$api->stash_result(
		$c, [ 'election_campaigns', $c->stash->{candidate_obj}{election_campaigns}[0] ],
		stash => 'election_campaign_obj',
	);
	
	$c->stash->{without_wrapper} = 1;
}

__PACKAGE__->meta->make_immutable;

1;