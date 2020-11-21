package Mojolicious::Plugin::DB;

use Mojo::Base 'Mojolicious::Plugin';

use GiftTable::Schema;

sub register {
    my ( $self, $app ) = @_;

    $app->helper( schema => sub {
        my ($c) = @_;
        return state $schema = GiftTable::Schema->connect( $c->config('database') );
    } );

    $app->helper( auth => sub {
        my ( $c, $user, $pass ) = @_;

        my $result = $c->schema->resultset('Account')->search({ name => $user })->first;

        return 1
            if $result && $result->check_password($pass);
    } );

    $app->helper( add => sub {
        my ( $c, $user, $pass ) = @_;

        return 0
            unless $user && $pass;

        my $result = $c->schema->resultset('Account')->create({ name => $user, password => $pass });

        return $result;
    } );

    $app->helper( accounts => sub {
        my ($c) = @_;

        my $result = $c->schema->resultset('Account');

        return $result;
    } );

}

1;
