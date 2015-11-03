package Starble::Schema::ResultSet::Thing;

use Moose;
extends 'DBIx::Class::ResultSet';

#use Readonly;
#Readonly my $SESSION_PREFIX => 'session:';

sub toggle_star {
    my $self = shift;
    my ( $thing_guid, $session_id ) = @_;

    my $thing = $self->find_or_create(
        { guid => $thing_guid },
        { key => 'guid' },
    );

    my $stars_rs = $thing->stars->search(
        {
            session => $session_id,
        },
    );

    if ( $stars_rs->count ) {
        $stars_rs->delete_all;
    }
    else {
        my $star = $thing->add_to_stars( {
            session => $session_id,
        } );
    }

}

1;
