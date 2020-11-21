package GiftTable::Schema::Result::Favorite;
use parent 'DBIx::Class::Core';

__PACKAGE__->table('favorites');

__PACKAGE__->add_columns(
    id   => { data_type => 'int', is_nullable => 0, is_serializable => 1, is_auto_increment => 1 },
    name => { data_type => 'text', is_nullable => 0, is_serializable => 1 },
);

__PACKAGE__->set_primary_key('id');

1;
