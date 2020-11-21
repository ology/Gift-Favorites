#!/usr/bin/env perl
use strict;
use warnings;

use lib 'lib';
use GiftTable::Schema;

my ($name, $pass) = @ARGV;

my $config = do './gift_table.conf';

(my $db_file = $config->{database}) =~ s/^.*?=(.*)$/$1/;

unlink $db_file
    if -e $db_file;
unlink $db_file . '.journal'
    if -e $db_file . '.journal';

my $schema = GiftTable::Schema->connect($config->{database}, '', '');

$schema->deploy({ add_drop_table => 1 });

if ($name && $pass) {
    $schema->resultset('Account')->create({
        name => $name,
        password => $pass,
    });
}
