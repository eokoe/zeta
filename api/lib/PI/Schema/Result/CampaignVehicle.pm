use utf8;
package PI::Schema::Result::CampaignVehicle;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PI::Schema::Result::CampaignVehicle

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

=head1 TABLE: C<campaign_vehicle>

=cut

__PACKAGE__->table("campaign_vehicle");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'campaign_vehicle_id_seq'

=head2 vehicle_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 campaign_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 vehicle_invitation_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "campaign_vehicle_id_seq",
  },
  "vehicle_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "campaign_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "vehicle_invitation_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
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

=head2 vehicle_invitation

Type: belongs_to

Related object: L<PI::Schema::Result::VehicleInvitation>

=cut

__PACKAGE__->belongs_to(
  "vehicle_invitation",
  "PI::Schema::Result::VehicleInvitation",
  { id => "vehicle_invitation_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-07-23 11:21:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ieVe2sSc6FCduWyoZf+1sg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
