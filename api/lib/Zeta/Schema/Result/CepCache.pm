use utf8;
package Zeta::Schema::Result::CepCache;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Zeta::Schema::Result::CepCache

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

=head1 TABLE: C<cep_cache>

=cut

__PACKAGE__->table("cep_cache");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cep_cache_id_seq'

=head2 address

  data_type: 'text'
  is_nullable: 0

=head2 postal_code

  data_type: 'integer'
  is_nullable: 0

=head2 neighborhood

  data_type: 'text'
  is_nullable: 1

=head2 city_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 state_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 location

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cep_cache_id_seq",
  },
  "address",
  { data_type => "text", is_nullable => 0 },
  "postal_code",
  { data_type => "integer", is_nullable => 0 },
  "neighborhood",
  { data_type => "text", is_nullable => 1 },
  "city_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "state_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "location",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 city

Type: belongs_to

Related object: L<Zeta::Schema::Result::City>

=cut

__PACKAGE__->belongs_to(
  "city",
  "Zeta::Schema::Result::City",
  { id => "city_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 state

Type: belongs_to

Related object: L<Zeta::Schema::Result::State>

=cut

__PACKAGE__->belongs_to(
  "state",
  "Zeta::Schema::Result::State",
  { id => "state_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-06-24 10:51:01
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Etd0kRwYK+QvuGSOJmCNHw


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
                address => {
                    required    => 0,
                    type        =>  'Str'
                },
                postal_code =>  {
                    required    => 0,
                    type        =>  'Str'
                },
                neighborhood => {
                    required    => 0,
                    type        =>  'Str'
                },
                city_id => {
                    required    => 0,
                    type        =>  'Str'
                },
                state_id => {
                    required    => 0,
                    type        =>  'Str'
                },
                location => {
                    required    => 0,
                    type        =>  'Str'
                }
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

            my $address_cache = $self->update( \%values );

            return $address_cache;
        },

    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
