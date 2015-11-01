package Starble::Controller::Star;
use Moose;
use namespace::autoclean;
use URI::Escape;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Starble::Controller::Fave - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=cut


sub get_thing :Chained('/') :PathPart('star') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my $thing_uri = $c->req->params->{ thing };

    unless ( $thing_uri ) {
        $c->res->code( '400' );
        $c->res->content( 'No "thing" argument found in query.' );
        $c->detach;
        return;
    }

    $thing_uri = uri_unescape( $thing_uri );

    my $thing = $c->model( 'StarbleDB::Thing' )->find( $thing_uri, { key => 'uri' } );

    $c->stash->{ thing } = $thing;
    $c->stash->{ thing_uri } = $thing_uri;
    $c->stash->{ uri } = $thing_uri;

    unless ( $c->user ) {
       $c->authenticate( { username => 'starble', password => 'starble' } );
    }
}

sub check :Chained('get_thing') :PathPart('check') :Args(0) {
    my ( $self, $c ) = @_;

    # Has this thing been starred by the requesting IP?
    my $thing = $c->stash->{ thing };
    my $checked = 0;
    if ( $thing && $thing->is_starred_by( $c->sessionid ) ) {
        $checked = 1;
    }

    $c->stash->{ result } = $checked;
}

sub count :Chained('get_thing') :Args(0) {
    my ( $self, $c ) = @_;

    my $thing = $c->stash->{ thing };
    my $count;
    if ( $thing ) {
        $count = $thing->star_count;
    }
    else {
        $count = 0;
    }

    $c->stash->{ result } = $count;
}

sub toggle :Chained('get_thing') :Args(0) {
    my ( $self, $c ) = @_;

    $c->model( 'StarbleDB::Thing' )->toggle_star(
        $c->stash->{ thing_uri },
        $c->sessionid,
    );

    $c->stash->{ result } = 1;

}

=encoding utf8

=head1 AUTHOR

Jason McIntosh

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
