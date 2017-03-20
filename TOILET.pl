#!/usr/local/bin/perl
use strict; use warnings;
##########################
# TOILET - dump html form
get '/' => sub {
	my $c = shift;
	return $c->render(template => 'index');
};
app->start('daemon', '-l', 'http://*:6664');
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
