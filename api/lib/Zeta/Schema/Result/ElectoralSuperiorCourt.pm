use utf8;
package Zeta::Schema::Result::ElectoralSuperiorCourt;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Zeta::Schema::Result::ElectoralSuperiorCourt

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

=head1 TABLE: C<electoral_superior_court>

=cut

__PACKAGE__->table("electoral_superior_court");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'electoral_superior_court_id_seq'

=head2 country_id

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
    sequence          => "electoral_superior_court_id_seq",
  },
  "country_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 country

Type: belongs_to

Related object: L<Zeta::Schema::Result::Country>

=cut

__PACKAGE__->belongs_to(
  "country",
  "Zeta::Schema::Result::Country",
  { id => "country_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 federal_electoral_processes

Type: has_many

Related object: L<Zeta::Schema::Result::FederalElectoralProcess>

=cut

__PACKAGE__->has_many(
  "federal_electoral_processes",
  "Zeta::Schema::Result::FederalElectoralProcess",
  { "foreign.electoral_superior_court_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-07-05 19:06:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:te6+E/4KKqVBMlQz3EeV7Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
