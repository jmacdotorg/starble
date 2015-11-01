use utf8;
package Starble::Schema::Result::Thing;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Starble::Schema::Result::Thing

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

=head1 TABLE: C<thing>

=cut

__PACKAGE__->table("thing");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 uri

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 128

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "uri",
  { data_type => "char", default_value => "", is_nullable => 0, size => 128 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<uri>

=over 4

=item * L</uri>

=back

=cut

__PACKAGE__->add_unique_constraint("uri", ["uri"]);

=head1 RELATIONS

=head2 stars

Type: has_many

Related object: L<Starble::Schema::Result::Star>

=cut

__PACKAGE__->has_many(
  "stars",
  "Starble::Schema::Result::Star",
  { "foreign.thing" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-10-28 00:51:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2qfz7qvZPRIXzCJRcHryWg

use DateTime;

sub star_count {
    my $self = shift;

    my $count = $self->stars->count;

    return $count;
}

sub is_starred_by {
    my $self = shift;
    my ( $session_id ) = @_;

    my $count = $self->stars->search( { session => $session_id } )->count;

    return $count;
}

__PACKAGE__->meta->make_immutable;
1;
