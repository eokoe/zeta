use utf8;
package PI::Schema::Result::StatusDescription;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PI::Schema::Result::StatusDescription

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

=head1 TABLE: C<status_description>

=cut

__PACKAGE__->table("status_description");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'status_description_id_seq'

=head2 description

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "status_description_id_seq",
  },
  "description",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 campaign_vehicles

Type: has_many

Related object: L<PI::Schema::Result::CampaignVehicle>

=cut

__PACKAGE__->has_many(
  "campaign_vehicles",
  "PI::Schema::Result::CampaignVehicle",
  { "foreign.status" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 campaigns

Type: has_many

Related object: L<PI::Schema::Result::Campaign>

=cut

__PACKAGE__->has_many(
  "campaigns",
  "PI::Schema::Result::Campaign",
  { "foreign.status" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 documents

Type: has_many

Related object: L<PI::Schema::Result::Document>

=cut

__PACKAGE__->has_many(
  "documents",
  "PI::Schema::Result::Document",
  { "foreign.status" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 instalation_kits

Type: has_many

Related object: L<PI::Schema::Result::InstalationKit>

=cut

__PACKAGE__->has_many(
  "instalation_kits",
  "PI::Schema::Result::InstalationKit",
  { "foreign.status" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 vehicle_invitations

Type: has_many

Related object: L<PI::Schema::Result::VehicleInvitation>

=cut

__PACKAGE__->has_many(
  "vehicle_invitations",
  "PI::Schema::Result::VehicleInvitation",
  { "foreign.status" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-11-05 13:57:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WwIqBTeLb55B5o84Kg3hyw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
