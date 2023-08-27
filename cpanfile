requires 'Mojolicious', '9.33';
requires 'Namespace::Subroutines', '>= 0.02';

on 'test' => sub {
	requires 'Test::Simple', '>= 1.302195';
};

on 'develop' => sub {
	requires 'App::perlimports', '>= 0.000052';
	requires 'Perl::Tidy', '>= 20230701';
	requires 'Perl::Critic', '>= 1.150';
	requires 'Perl::Critic::Policy::ValuesAndExpressions::ProhibitAccessOfPrivateData';
	requires 'Perl::Critic::Policy::Freenode::WhileDiamondDefaultAssignment';
	requires 'Mojolicious::Plugin::AutoReload';
};
