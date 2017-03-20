#!/usr/local/bin/perl
use strict; use warnings;
#########################
# ROWDY - raw http server
get '/:id' => sub {
  my $c = shift;
  my $id = $c->stash('id');
  my $loc = $dir . $id;
  return $c->render(message => 'PASTE NO EXIST') unless -e $loc;
  my $paste = read_file($loc);
  $c->render(text => $paste, format => 'txt');
};
app->start('daemon', '-l', 'http://*:6662');
