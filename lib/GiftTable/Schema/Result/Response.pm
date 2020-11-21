package GiftTable::Schema::Result::Response;
use parent 'DBIx::Class::Core';

__PACKAGE__->table('responses');

__PACKAGE__->add_columns(
    id          => { data_type => 'int', is_nullable => 0, is_serializable => 1, is_auto_increment => 1 },
    account_id  => { data_type => 'int', is_nullable => 0, is_serializable => 1 },
    favorite_id => { data_type => 'int', is_nullable => 0, is_serializable => 1 },
    response    => { data_type => 'text', is_nullable => 0, is_serializable => 1 },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to(account => 'GiftTable::Schema::Result::Account', 'account_id');
__PACKAGE__->belongs_to(favorite => 'GiftTable::Schema::Result::Favorite', 'favorite_id');

1;
