#!/usr/bin/env perl
use strict;
use warnings;

use lib 'lib';
use ReplyTable::Schema;

my $config = do './gift_table.conf';

my $schema = ReplyTable::Schema->connect($config->{database}, '', '');

$schema->resultset('Account')->create({ name => 'aaron', password => 'aaron' });
$schema->resultset('Account')->create({ name => 'abi', password => 'abi' });
$schema->resultset('Account')->create({ name => 'adrienne', password => 'adrienne' });
$schema->resultset('Account')->create({ name => 'anthony', password => 'anthony' });
$schema->resultset('Account')->create({ name => 'bill', password => 'bill' });
$schema->resultset('Account')->create({ name => 'brad', password => 'brad' });
$schema->resultset('Account')->create({ name => 'gene', password => 'gene!' });
$schema->resultset('Account')->create({ name => 'janey', password => 'janey' });
$schema->resultset('Account')->create({ name => 'keegan', password => 'keegan' });
$schema->resultset('Account')->create({ name => 'lyra', password => 'lyra' });
$schema->resultset('Account')->create({ name => 'marcy', password => 'marcy' });
$schema->resultset('Account')->create({ name => 'owen', password => 'owen' });
$schema->resultset('Account')->create({ name => 'tabi', password => 'tabi' });

$schema->resultset('Favorite')->create({ name => 'Color 1' }); # 1
$schema->resultset('Favorite')->create({ name => 'Color 2' }); # 2
$schema->resultset('Favorite')->create({ name => 'Candy' }); # 3
$schema->resultset('Favorite')->create({ name => 'TV Show (Or Genre)' }); # 4
$schema->resultset('Favorite')->create({ name => 'Movie Genre' }); # 5
$schema->resultset('Favorite')->create({ name => 'Animal' }); # 6
$schema->resultset('Favorite')->create({ name => 'Subject to Learn' }); # 7
$schema->resultset('Favorite')->create({ name => 'Hobby' }); # 8
$schema->resultset('Favorite')->create({ name => 'Sport' }); # 9
$schema->resultset('Favorite')->create({ name => 'Book' }); # 10
$schema->resultset('Favorite')->create({ name => 'Meal' }); # 11
$schema->resultset('Favorite')->create({ name => 'Snack' }); # 12
$schema->resultset('Favorite')->create({ name => 'Fun to do' }); # 13
$schema->resultset('Favorite')->create({ name => 'Shop/Store' }); # 14
$schema->resultset('Favorite')->create({ name => 'I Collect...' }); # 15
$schema->resultset('Favorite')->create({ name => 'Music/Song Genre' }); # 16
$schema->resultset('Favorite')->create({ name => 'Musician' }); # 17
$schema->resultset('Favorite')->create({ name => 'Inside Activity' }); # 18
$schema->resultset('Favorite')->create({ name => 'Outside Activity' }); # 19
$schema->resultset('Favorite')->create({ name => 'To Learn' }); # 20
$schema->resultset('Favorite')->create({ name => 'Aspiration' }); # 21
$schema->resultset('Favorite')->create({ name => 'Specific Gift Request 1' }); # 22
$schema->resultset('Favorite')->create({ name => 'Specific Gift Request 2' }); # 23
