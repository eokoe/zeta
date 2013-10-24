use utf8;
package PI::Schema::Result::Campaign;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PI::Schema::Result::Campaign

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

=head1 TABLE: C<campaign>

=cut

__PACKAGE__->table("campaign");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'campaign_id_seq'

=head2 valid_from

  data_type: 'date'
  is_nullable: 1

=head2 valid_to

  data_type: 'date'
  is_nullable: 1

=head2 status

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 est_drivers

  data_type: 'integer'
  is_nullable: 1

=head2 activated_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 customer_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "campaign_id_seq",
  },
  "valid_from",
  { data_type => "date", is_nullable => 1 },
  "valid_to",
  { data_type => "date", is_nullable => 1 },
  "status",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "est_drivers",
  { data_type => "integer", is_nullable => 1 },
  "activated_at",
  { data_type => "timestamp", is_nullable => 1 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "customer_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "name",
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
  { "foreign.campaign_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 customer

Type: belongs_to

Related object: L<PI::Schema::Result::Customer>

=cut

__PACKAGE__->belongs_to(
  "customer",
  "PI::Schema::Result::Customer",
  { id => "customer_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 invitations

Type: has_many

Related object: L<PI::Schema::Result::Invitation>

=cut

__PACKAGE__->has_many(
  "invitations",
  "PI::Schema::Result::Invitation",
  { "foreign.campaign_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 status

Type: belongs_to

Related object: L<PI::Schema::Result::StatusDescription>

=cut

__PACKAGE__->belongs_to(
  "status",
  "PI::Schema::Result::StatusDescription",
  { id => "status" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-10-24 11:57:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:q7eXPNvNx9jEiJ/A2HROSQ
with 'PI::Role::Verification';
with 'PI::Role::Verification::TransactionalActions::DBIC';
with 'PI::Schema::Role::ResultsetFind';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;
use PI::Types qw /DataStr/;

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
                valid_from=> {
                    required => 0,
                    type     => DataStr,
                },
                valid_to=> {
                    required => 0,
                    type     => DataStr,
                },
                status => {
                    required => 0,
                    type     => 'Int',
                },
                est_drivers => {
                    required => 0,
                    type     => 'Int',
                },
                activated_at => {
                    required => 0,
                    type     => DataStr,
                },
                customer_id => {
                    required => 0,
                    type     => 'Int',
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

            my $campaign = $self->update( \%values );

            return $campaign;
        },
    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
