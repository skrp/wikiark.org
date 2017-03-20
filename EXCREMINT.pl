#!/usr/local/bin/perl
use strict; use warnings;
#######################
# EXCREMINT - http dump
post '/upload' => sub {
	my $c = shift;
	my $file = $c->req->upload('file');
# ERROR NULL UP ##############
	unless ($file) {
		return $c->render(
		template => 'error',
		message => 'Upload failed. File not specified.'
		);
	}
# ERROR SIZE #################
	my $size = $file->size;
	if ($size > $max) {
		return $c->render(
		template => 'error',
		message => 'Upload failed. File size over 10GB'
		);
	}
# STORE ######################
	my $name = $file->filename;
	my $newfile = $DUMP . $name;
	$file->move_to($newfile);
	$c->render(text => 'Thanks for $size bytes');
};
# END ########################
app->start('daemon', '-l', 'http://*:6660');
