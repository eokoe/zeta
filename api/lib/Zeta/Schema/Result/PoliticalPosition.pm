use utf8;
package Zeta::Schema::Result::PoliticalPosition;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Zeta::Schema::Result::PoliticalPosition

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<political_position>

=cut

__PACKAGE__->table("political_position");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'political_position_id_seq'

=head2 position

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "political_position_id_seq",
  },
  "position",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 election_campaigns

Type: has_many

Related object: L<Zeta::Schema::Result::ElectionCampaign>

=cut

__PACKAGE__->has_many(
  "election_campaigns",
  "Zeta::Schema::Result::ElectionCampaign",
  { "foreign.political_position_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-06-25 17:45:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ssZ4A0rteviw77mzocYsag
with 'Zeta::Role::Verification';
with 'Zeta::Role::Verification::TransactionalActions::DBIC';
with 'Zeta::Schema::Role::ResultsetFind';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;
use Zeta::Types qw /DataStr TimeStr/;

sub verifiers_specs {
    my $self = shift;
     return {
        update => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                position => {
                    required => 0,
                    type     => 'Str',
                },
            }
        ),
    };
}

sub action_specs {
    my $self = shift;
    return {
        update => sub {
            my %values = shift->valid_values;

            not defined $values{$_} and delete $values{$_} for keys %values;

            my $political_position = $self->update( \%values );

            return $political_position;
        }
    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;