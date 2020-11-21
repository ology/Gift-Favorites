use utf8;
package GiftTable::Schema::Result::Account;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

GiftTable::Schema::Result::Account

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<accounts>

=cut

__PACKAGE__->table("accounts");

=head1 COMPONENTS

EncodedColumn

=cut

__PACKAGE__->load_components(qw/ EncodedColumn /);

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  id => { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  name => { data_type => "varchar", is_nullable => 0, size => 255 },
  password => {
    data_type => "varchar",
    is_nullable => 0,
    size => 255,
    encode_column => 1,
    encode_class => 'Crypt::Eksblowfish::Bcrypt',
    encode_args => { key_nul => 0, cost => 6 },
    encode_check_method => 'check_password',
  },
  created => {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-12-14 23:39:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ewJm8YyHzXX3gkgRzsWVLg


# You can replace this text with custom code or comments, and it will be preserved on regeneration

1;
