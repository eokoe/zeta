package PI::Schema::ResultSet::City;
use namespace::autoclean;

use utf8;
use Moose;
extends 'DBIx::Class::ResultSet';
with 'PI::Schema::Role::InflateAsHashRef';


1;

