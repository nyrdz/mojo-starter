use Mojo::Base -strict;

use Test::More import => [qw( done_testing )];
use Test::Mojo;

my $t = Test::Mojo->new('MyApp');
$t->get_ok('/')->status_is(200);

done_testing();
