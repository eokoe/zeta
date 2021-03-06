use utf8;
package Zeta::Schema::Result::Country;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Zeta::Schema::Result::Country

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

=head1 TABLE: C<country>

=cut

__PACKAGE__->table("country");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'country_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 acronym

  data_type: 'text'
  is_nullable: 0

=head2 name_url

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "country_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "acronym",
  { data_type => "text", is_nullable => 0 },
  "name_url",
  { data_type => "text", is_nullable => 1 },
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
  { "foreign.country_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 electoral_superior_courts

Type: has_many

Related object: L<Zeta::Schema::Result::ElectoralSuperiorCourt>

=cut

__PACKAGE__->has_many(
  "electoral_superior_courts",
  "Zeta::Schema::Result::ElectoralSuperiorCourt",
  { "foreign.country_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 promises

Type: has_many

Related object: L<Zeta::Schema::Result::Promise>

=cut

__PACKAGE__->has_many(
  "promises",
  "Zeta::Schema::Result::Promise",
  { "foreign.country_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 states

Type: has_many

Related object: L<Zeta::Schema::Result::State>

=cut

__PACKAGE__->has_many(
  "states",
  "Zeta::Schema::Result::State",
  { "foreign.country_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-06-25 20:18:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/itAQT+qBInvaUFyrNWVQg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
