use utf8;
package PI::Schema::Result::InstalationKit;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PI::Schema::Result::InstalationKit

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

=head1 TABLE: C<instalation_kit>

=cut

__PACKAGE__->table("instalation_kit");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'instalation_kit_id_seq'

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 sent_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 token

  data_type: 'text'
  is_nullable: 0

=head2 status

  data_type: 'integer'
  default_value: 9
  is_foreign_key: 1
  is_nullable: 1

=head2 used_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 campaign_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 vehicle_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "instalation_kit_id_seq",
  },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "sent_at",
  { data_type => "timestamp", is_nullable => 1 },
  "token",
  { data_type => "text", is_nullable => 0 },
  "status",
  {
    data_type      => "integer",
    default_value  => 9,
    is_foreign_key => 1,
    is_nullable    => 1,
  },
  "used_at",
  { data_type => "timestamp", is_nullable => 1 },
  "campaign_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "vehicle_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 campaign

Type: belongs_to

Related object: L<PI::Schema::Result::Campaign>

=cut

__PACKAGE__->belongs_to(
  "campaign",
  "PI::Schema::Result::Campaign",
  { id => "campaign_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 status

Type: belongs_to

Related object: L<PI::Schema::Result::StatusDescription>

=cut

__PACKAGE__->belongs_to(
  "status",
  "PI::Schema::Result::StatusDescription",
  { id => "status" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 vehicle

Type: belongs_to

Related object: L<PI::Schema::Result::Vehicle>

=cut

__PACKAGE__->belongs_to(
  "vehicle",
  "PI::Schema::Result::Vehicle",
  { id => "vehicle_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-11-07 16:09:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HhKtb/xYNICUbFP+RKn/Mg
with 'PI::Role::Verification';
with 'PI::Role::Verification::TransactionalActions::DBIC';
with 'PI::Schema::Role::ResultsetFind';

use Data::Verifier;
use PI::Types qw /DataStr/;

sub verifiers_specs {
    my $self = shift;
    return {
        update => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                vehicle_id => {
                    required => 0,
                    type     => 'Int',
                },
                sent_at => {
                    required => 0,
                    type     => DataStr
                },
                token => {
                    required => 0,
                    type     => 'Str'
                },
                status => {
                    required => 0,
                    type     => 'Int',
                },
                used_at => {
                    required => 0,
                    type     => DataStr
                },
                campaign_id => {
                    required => 0,
                    type     => 'Int',
                },
            },
        ),
    };
}

sub action_specs {
    my $self = shift;
    return {
        update => sub {
            my %values = shift->valid_values;

            my $instalation_kit = $self->update( \%values );

            return $instalation_kit;
        },

    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;