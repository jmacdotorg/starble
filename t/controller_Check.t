use strict;
use warnings;
use Test::More;

use FindBin;
use lib (
    "$FindBin::Bin/lib",
    "$FindBin::Bin/../lib",
);
use StarbleTest;
use JSON::XS;

unless (eval q{use Test::WWW::Mechanize::Catalyst 0.55; 1}) {
    plan skip_all => 'Test::WWW::Mechanize::Catalyst >= 0.55 required';
    exit 0;
}

ok( my $mech = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Starble'), 'Created mech object' );

my $schema = StarbleTest->init_schema;

$mech->get_ok( '/star/count?thing=343EE14A-8243-11E5-A92D-D7D8146448B6' );
is ( get_result(), 3 );

$mech->get_ok( '/star/check?thing=343EE14A-8243-11E5-A92D-D7D8146448B6' );
is ( get_result(), 0 );

$mech->get_ok( '/star/toggle?thing=343EE14A-8243-11E5-A92D-D7D8146448B6' );
is ( get_result(), 1 );

$mech->get_ok( '/star/count?thing=343EE14A-8243-11E5-A92D-D7D8146448B6' );
is ( get_result(), 4 );

$mech->get_ok( '/star/check?thing=343EE14A-8243-11E5-A92D-D7D8146448B6' );
is ( get_result(), 1 );

$mech->get_ok( '/star/toggle?thing=343EE14A-8243-11E5-A92D-D7D8146448B6' );
is ( get_result(), 1 );

$mech->get_ok( '/star/check?thing=343EE14A-8243-11E5-A92D-D7D8146448B6' );
is ( get_result(), 0 );

$mech->get_ok( '/star/count?thing=343EE14A-8243-11E5-A92D-D7D8146448B6' );
is ( get_result(), 3 );

$mech->get( '/star/count?thing=this-is-not-a-valid-guid' );
is ( $mech->status, '400' );

done_testing();

sub get_result {
    my $data = decode_json( $mech->content );
    return $data->{ result };
}
