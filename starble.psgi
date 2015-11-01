use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Starble;

my $app = Starble->apply_default_middlewares(Starble->psgi_app);
$app;

