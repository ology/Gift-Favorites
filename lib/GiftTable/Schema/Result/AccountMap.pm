package GiftTable::Schema::Result::AccountMap;
use parent 'DBIx::Class::Core';

__PACKAGE__->table('account_maps');

__PACKAGE__->add_columns(
    id          => { data_type => 'int', is_nullable => 0, is_serializable => 1, is_auto_increment => 1 },
    account_id  => { data_type => 'int', is_nullable => 0, is_serializable => 1 },
    selected_id => { data_type => 'int', is_nullable => 1, is_serializable => 1 },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to(account => 'GiftTable::Schema::Result::Account', 'account_id');
__PACKAGE__->belongs_to(selected => 'GiftTable::Schema::Result::Account', 'selected_id');

1;
