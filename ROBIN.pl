#!/usr/local/bin/perl
use strict; use warnings;
use Mojolicious::Lite;
######################
# ROBIN - raw http bin
post '/', sub {
  my $c = shift;
  my $paste = $c->param('paste');
  $c->stash(paste => '');
  return $c->render(message => 'PASTE FAILED') unless $paste;
  my $enc_paste = Mojo::ByteStream->new($paste)->encode('utf-8');
  my $pre_id = sha1_hex($enc_paste);
  my $id = substr($pre_id, 0, 6);
  my $loc = $dir . $id;
  open(my $pfh, '>', $loc);
  print $pfh $enc_paste;
  $c->render(text => "wikiark.org/raw/$id");
};
