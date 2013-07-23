use utf8;
package PI::Schema::Result::VehicleOwner;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PI::Schema::Result::VehicleOwner

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

=head1 TABLE: C<vehicle_owner>

=cut

__PACKAGE__->table("vehicle_owner");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'vehicle_owner_id_seq'

=head2 email

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 last_name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 birth_date

  data_type: 'date'
  is_nullable: 0

=head2 cpf

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 bank_code

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 bank_ag

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 bank_cc

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 telephone_number

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 mobile_provider

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 mobile_number

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 address

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 state

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 city

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 neighborhood

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 complement

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 number

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 postal_code

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 created_by

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "vehicle_owner_id_seq",
  },
  "email",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "last_name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "birth_date",
  { data_type => "date", is_nullable => 0 },
  "cpf",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "bank_code",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "bank_ag",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "bank_cc",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "telephone_number",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "mobile_provider",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "mobile_number",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "address",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "state",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "city",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "neighborhood",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "complement",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "number",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "postal_code",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "created_by",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 contracts

Type: has_many

Related object: L<PI::Schema::Result::Contract>

=cut

__PACKAGE__->has_many(
  "contracts",
  "PI::Schema::Result::Contract",
  { "foreign.vehicle_owner_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 vehicles

Type: has_many

Related object: L<PI::Schema::Result::Vehicle>

=cut

__PACKAGE__->has_many(
  "vehicles",
  "PI::Schema::Result::Vehicle",
  { "foreign.vehicle_owner_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-07-23 11:21:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GxJOalFcAJ6tEiOR9PWfag


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
