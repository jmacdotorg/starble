use utf8;
package Starble::Schema::Result::Session;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Starble::Schema::Result::Session

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

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<session>

=cut

__PACKAGE__->table("session");

=head1 ACCESSORS

=head2 id

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 72

=head2 expires

  data_type: 'integer'
  is_nullable: 1

=head2 session_data

  data_type: 'text'
  is_nullable: 1

=head2 shorter_id

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 72

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "char", default_value => "", is_nullable => 0, size => 72 },
  "expires",
  { data_type => "integer", is_nullable => 1 },
  "session_data",
  { data_type => "text", is_nullable => 1 },
  "shorter_id",
  { data_type => "char", default_value => "", is_nullable => 0, size => 72 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<shorter_id>

=over 4

=item * L</shorter_id>

=back

=cut

__PACKAGE__->add_unique_constraint("shorter_id", ["shorter_id"]);

=head1 RELATIONS

=head2 stars

Type: has_many

Related object: L<Starble::Schema::Result::Star>

=cut

__PACKAGE__->has_many(
  "stars",
  "Starble::Schema::Result::Star",
  { "foreign.session" => "self.shorter_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-10-30 22:06:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NqGJGn8Eq4BbKPdB2XQmXw

use Readonly;
Readonly my $SESSION_PREFIX_LENGTH => 8;
# Above number comes from
# https://metacpan.org/pod/Catalyst::Plugin::Session::Store::DBIC#SCHEMA

before 'insert' => sub {
    my $self = shift;

    $self->shorter_id( substr( $self->id, $SESSION_PREFIX_LENGTH ) );
};

__PACKAGE__->meta->make_immutable;
1;
