#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'Zeta';
all_from 'lib/Zeta.pm';

requires 'Redis';
requires 'Catalyst::Runtime' => '5.90010';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Authorization::Roles';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::I18N::DBI';
requires 'I18N::AcceptLanguage';

requires 'Catalyst::Authentication::Store::DBIx::Class';
requires 'Catalyst::Component::InstancePerContext';
requires 'Catalyst::Plugin::Params::Nested';
requires 'Catalyst::Controller::REST';
requires 'Catalyst::TraitFor::Controller::DBIC::DoesPaging';
requires 'DBIx::Class::PassphraseColumn';
requires 'DBIx::Class::TimeStamp';
requires 'Moose';
requires 'namespace::autoclean';
requires 'MooseX::Types::Email';
requires 'Data::Diver';
requires 'Data::Printer';
requires 'Data::Manager';
requires 'FindBin';
requires 'JSON';
requires 'JSON::XS';
requires 'List::MoreUtils';
requires 'String::Random';
requires 'Crypt::PasswdMD5';
requires 'DateTime::Duration';
requires 'Catalyst::Plugin::Unicode::Encoding';
requires 'DateTime::Format::Duration';
requires 'DateTimeX::Easy';
requires 'DateTime::Format::Pg';
requires 'Catalyst::View::TT';

requires 'Geo::Coder::Google';
requires 'Text::Iconv';
requires 'Email::Sender';
requires 'Email::Sender::Simple';
requires 'Spreadsheet::WriteExcel';
requires 'Email::Sender::Transport::SMTP::TLS';
requires 'Email::MIME';
requires 'Spreadsheet::XLSX';
requires 'Spreadsheet::ParseExcel::Stream';
requires 'DateTime::Format::Excel';
requires 'Math::Expression::Evaluator';
requires 'Template';
requires 'Catalyst::Plugin::Assets';
requires 'MooseX::MarkAsMethods';
requires 'MooseX::NonMoose';

requires 'Text::CSV_XS';
requires 'Digest::MD5';
requires 'Text2URI';
requires 'MooseX::Traits';
requires 'DBD::Pg';
requires 'Statistics::Descriptive';
requires 'XML::Simple';
requires 'WWW::Correios::CEP';
requires 'Text2URI';
requires 'Digest::SHA';
requires 'Net::Amazon::S3';
requires 'MooseX::Types::CPF';
requires 'Image::Resize'; # apt-get build-dep libgd-gd2-perl

requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
test_requires 'Test::More' => '0.88';
test_requires 'Test::Deep';
tests_recursive('t');
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;




