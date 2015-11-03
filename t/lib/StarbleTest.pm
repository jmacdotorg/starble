package StarbleTest;
use strict;
use warnings;

use FindBin;
$ENV{CATALYST_CONFIG} = "$FindBin::Bin/conf/starble.conf";
$ENV{CATALYST_DEBUG} = 0;

use Starble::Schema;

my $db_dir    = "$FindBin::Bin/db";
my $db_file   = "$db_dir/starble.db";
my $dsn       = "dbi:SQLite:dbname=$db_file";

sub init_schema {
    my $self = shift;

    if (-e $db_file) {
        unlink $db_file
            or croak("Couldn't unlink $db_file: $!");
    }

    my $schema = Starble::Schema->
        connect( $dsn, '', '', {}, );

    $schema->deploy( { add_drop_table => 1 }, $db_dir );

    $schema->populate(
        'Thing',
        [
            [qw/id guid/],
            [1, '343EE14A-8243-11E5-A92D-D7D8146448B6', ],
            [2, '3449F292-8243-11E5-A92D-D7D8146448B6', ],
            [3, '344AF962-8243-11E5-A92D-D7D8146448B6', ],
        ]
    );

    $schema->populate(
        'Star',
        [
            [qw/id session thing/],
            [1, 1, 1],
            [2, 2, 1],
            [3, 3, 1],
            [4, 4, 2],
        ]
    );

    $schema->populate(
        'Session',
        [
            [qw/id shorter_id/],
            [1, 1],
            [2, 2],
            [3, 3],
            [4, 4],
        ]
    );

    return $schema;
}

1;
