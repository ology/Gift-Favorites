use Mojolicious::Lite;
use lib 'lib';

use Data::Dumper::Compact 'ddc';

my $config = plugin 'Config' => { file => 'reply_table.conf' };
plugin 'DB';

app->secrets($config->{secrets});

get '/' => sub { shift->redirect_to('index') };

get '/index' => sub { shift->render } => 'index';

post '/login' => sub {
  my $c = shift;

  if ($c->auth($c->param('username'), $c->param('password'))) {
    my $account = $c->schema->resultset('Account')->search({ name => $c->param('username') })->first;
    $c->session(auth => $account->id);
    return $c->redirect_to('table');
  }

  $c->flash(error => 'Invalid login');
  $c->redirect_to('index');
} => 'login';

get '/logout' => sub {
  my $c = shift;

  delete $c->session->{auth};

  $c->redirect_to('index');
} => 'logout';

under sub {
  my $c = shift;

  my $session = $c->session('auth') // '';

  return 1
      if $session;

  $c->redirect_to('index');
  return 0;
};

get '/table' => sub {
  my $c = shift;

  my $tab = $c->param('tab') || 'name';

  my $account = $c->schema->resultset('Account')->search({ id => $c->session->{auth} })->first;
  my $name = $account->name;

  my $selected = $c->schema->resultset('AccountMap')->search({ account_id => $account->id })->first;
  $selected = $selected->selected if $selected;
  my $selected_id = $selected ? $selected->id : 0;
  my $selected_name = $selected ? $selected->name : '';

  my $favorites = $c->schema->resultset('Favorite');

  my $responses;
  if ($tab eq 'name') {
    $responses = $c->schema->resultset('Response')->search({ account_id => $account->id });
  }
  else {
    $responses = $c->schema->resultset('Response')->search({ account_id => $selected_id })
      if $selected_id;
  }
  my %response;
  while (my $response = $responses->next) {
    $response{ $response->favorite_id } = $response->response;
  }

  my @items;
  while (my $favorite = $favorites->next) {
    push @items, [$favorite->name, exists $response{ $favorite->id } ? $response{ $favorite->id } : ''];
  }

  my $accounts = $c->schema->resultset('Account')->search({ id => { '!=' => $account->id } });
  my $acct_maps = $c->schema->resultset('AccountMap');
  my $diff = $accounts->count - $acct_maps->count;

  $c->stash(
    name => ucfirst($name),
    selected => ucfirst($selected_name),
    tab => $tab,
    diff => $diff,
    items => \@items,
  );
} => 'table';

post '/table' => sub {
  my $c = shift;

  my $account = $c->schema->resultset('Account')->search({ id => $c->session->{auth} })->first;
  my $favorites = $c->schema->resultset('Favorite');

  my $params = $c->every_param('response');

  my $i = 0;
  while (my $favorite = $favorites->next) {
    my $r = $c->schema->resultset('Response')->search({ account_id => $account->id, favorite_id => $favorite->id })->first;
    if ($r) {
      $r->update({ response => $params->[$i] });
    }
    else {
      $c->schema->resultset('Response')->create({ account_id => $account->id, favorite_id => $favorite->id, response => $params->[$i] });
    }

    $i++;
  }

  $c->redirect_to('table');
} => 'update_table';

get '/draw' => sub {
  my $c = shift;

  my $account = $c->schema->resultset('Account')->search({ id => $c->session->{auth} })->first;
  my $accounts = $c->schema->resultset('Account')->search({ id => { '!=' => $account->id } });
  my $acct_map = $c->schema->resultset('AccountMap')->search({ account_id => $account->id })->first;
  my $acct_maps = $c->schema->resultset('AccountMap');

  my %unseen;
  while (my $acct = $accounts->next) {
    if (! $acct_maps->search({ selected_id => $acct->id })->first) {
      $unseen{ $acct->id }++;
    }
  }

  if (keys %unseen) {
    my @draw;
    my $drawn = (keys %unseen)[int rand keys %unseen];

    if ($acct_map) {
      $acct_map->update({ selected_id => $drawn });
    }
    else {
      $c->schema->resultset('AccountMap')->create({ account_id => $account->id, selected_id => $drawn });
    }
  }
  else {
    $c->flash(error => 'No more names to draw');
  }

  $c->redirect_to('table');
};

get '/refresh' => sub {
  my $c = shift;

  my $acct_maps = $c->schema->resultset('AccountMap');
  while (my $acct = $acct_maps->next) {
    $acct->update({ selected_id => undef });
  }

  $c->redirect_to('table');
};

app->start;
