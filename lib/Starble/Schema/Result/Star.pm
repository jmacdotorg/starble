use utf8;
package Starble::Schema::Result::Star;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Starble::Schema::Result::Star

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

=head1 TABLE: C<star>

=cut

__PACKAGE__->table("star");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 thing

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 session

  data_type: 'char'
  default_value: (empty string)
  is_foreign_key: 1
  is_nullable: 0
  size: 72

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "thing",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "session",
  {
    data_type => "char",
    default_value => "",
    is_foreign_key => 1,
    is_nullable => 0,
    size => 72,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 session

Type: belongs_to

Related object: L<Starble::Schema::Result::Session>

=cut

__PACKAGE__->belongs_to(
  "session",
  "Starble::Schema::Result::Session",
  { shorter_id => "session" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 thing

Type: belongs_to

Related object: L<Starble::Schema::Result::Thing>

=cut

__PACKAGE__->belongs_to(
  "thing",
  "Starble::Schema::Result::Thing",
  { id => "thing" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-01 12:45:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LNr/4WXp2vslHpInfjA7Qg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
