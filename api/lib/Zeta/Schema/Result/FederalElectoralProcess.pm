use utf8;
package Zeta::Schema::Result::FederalElectoralProcess;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Zeta::Schema::Result::FederalElectoralProcess

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

=head1 TABLE: C<federal_electoral_process>

=cut

__PACKAGE__->table("federal_electoral_process");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'federal_electoral_process_id_seq'

=head2 content

  data_type: 'text'
  is_nullable: 0

=head2 source

  data_type: 'text'
  is_nullable: 0

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 created_by

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 electoral_superior_court_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 external_link

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "federal_electoral_process_id_seq",
  },
  "content",
  { data_type => "text", is_nullable => 0 },
  "source",
  { data_type => "text", is_nullable => 0 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "created_by",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "electoral_superior_court_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "external_link",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 created_by

Type: belongs_to

Related object: L<Zeta::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "created_by",
  "Zeta::Schema::Result::User",
  { id => "created_by" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 electoral_superior_court

Type: belongs_to

Related object: L<Zeta::Schema::Result::ElectoralSuperiorCourt>

=cut

__PACKAGE__->belongs_to(
  "electoral_superior_court",
  "Zeta::Schema::Result::ElectoralSuperiorCourt",
  { id => "electoral_superior_court_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-08-18 00:01:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XHqrFbjaTAsGms+9TJMIaA
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
                name => {
                    required => 0,
                    type     => 'Str',
                },
                content => {
					required => 0,
                    type     => 'Str'
                },
                source => {
					required => 0,
                    type     => 'Str'
                },
                created_by => {
					required => 0,
                    type     => 'Int'
                },
                electoral_superior_court_id => {
					required 	=> 0,
					type		=> 'Int'
                },
                external_link => {
					required 	=> 0,
					type		=> 'Str'
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

            my $federal_electoral_process = $self->update( \%values );

            return $federal_electoral_process;
        },

    };
}
# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
