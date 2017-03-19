#!/usr/bin/perl
use Mojolicious::Lite;
#########################
# DUMP - http dump daemon
# SETUP #################
my $DUMP = 'dump/';
die "no dump dir" unless -d $DUMP;
my $max = 10_000_000_000; # ~10GB
#########################
# HOME 
get '/' => sub {
	my $c = shift;
	return $c->render(template => 'index');
};
##########################
# UPLOAD 
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
##############################
# END 
app->start('daemon', '-l', 'http://*:3000');

__DATA__

@@ error.html.ep
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" >
    <title>Error</title>
  </head>
  <body>
    <%= $message %>
  </body>
</html>

@@ index.html.ep
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" >
    <title>MKRX WEB DUMP</title>
  </head>
  <body>
    <h1>WEB FILE DUMP</h1>
    <form method="post" action="<%= url_for('upload') %>" enctype ="multipart/form-data">
      <div>
        Select File
        <input type="file" name="file" >
        <input type="submit" value="Upload" >
      </div>
    </form>
  </body>
</html>
