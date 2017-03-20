#!/usr/bin/perl
use strict; use warnings;
use Mojolicious::Lite;
use Digest::SHA1 'sha1_hex';
use File::Slurp 'read_file';
##############################
# RAWBIN - raw pastebin server
#############################
# SETUP
my $dir = 'paste/';
die "no paste dir" unless -d $dir;
#app->renderer->types->type(raw => 'text/plain; charset=utf-8');
##############################
# ROOT 
get '/' => 'form';
##############################
# PASTE
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
# FILE #########################
  	$c->render(text => "PASTE SUCCESS @ wikiark.org/paste/$id");
};
###############################
# CALL
get '/:id' => sub {
	my $c = shift;
	my $id = $c->stash('id');
	my $loc = $dir . $id;
	return $c->render(message => 'PASTE NO EXIST') unless -e $loc;
	my $paste = read_file($loc);
	$c->render(text => $paste); 
} => 'view';
################################
# END
app->start('daemon', '-l', 'http://*:8091');
__DATA__
@@ form.html.ep
<html>
    <head>
        <title>RAWBIN</title>
        <style type="text/css">
            html, body {height: 100%}
            body {background: #fff;font-family: "Helvetica Neue", Arial, Helvetica, sans-serif;}
            h1,h2,h3,h4,h5 {font-family: times, "Times New Roman", times-roman, georgia, serif; line-height: 40px; letter-spacing: -1px; color: #444; margin: 0 0 0 0; padding: 0 0 0 0; font-weight: 100;}
            a,a:active {color:#555}
            a:hover{color:#000}
            a:visited{color:#000}
            img{border:0px}
            pre{padding:0.5em;overflow:auto;overflow-y:visible;width:600px;}
            pre.lines{border:0px;padding-right:0.5em;width:50px}
 						#body {width:700px;min-height:100%;height:auto !important;height:100%;margin:0 auto -6em;}
            #header {text-align:center;padding:0em 0em 2em 0em;}
            .content {background:#eee;border:2px solid #ccc;width:700px}
            .created, .modified {color:#999;margin-left:10px;font-size:small;font-style:italic;padding-bottom:0.5em}
            .modified {margin:0px}
            .label{text-align:right;vertical-align:top;width:1%}
            .center{text-align:center}
            .error {padding:2em;text-align:center}
            #footer{width:75%;margin:auto;font-size:80%;text-align:center;padding:2em 0em 2em 0em;height:2em;}
            .push {height:6em}
            .clear {clear:both}
        </style>
    </head>
    <body>
    <div id="body">
        <div id="header">RAWBIN</div>

        <%== content %>

        <form method="post" action="/">
        <table width="100%">
        <tr><td></td><td>
        <textarea name="paste" cols="100" rows="50"></textarea>
        </td></tr>
        <tr><td></td><td><input type="submit" value="Paste!" /> <input type="reset" value="Clear"></td></tr>
        </form>
   <tr><td><br /></td><td></td></tr>
        </table>

        <div class="push"></div>
        </div>

        <div class="clear">
    </body>
</html>

@@ view.html.ep
% layout 'wrapper';
<table width="100%">
<tr>
% my $class = 'txt';
<td>
<a href="<%= url_for format => 'raw' %>">raw</a> 
</td></tr>
</table>
<br />
% my @paste = split("\n", $paste); my $total = @paste;
<div class="content">
<div style="float:left;text-align:right">
<pre class="lines"><code><%== "$_\n" for 1 .. $total %></code></pre>
</div>
<div class="float:right">
<pre><code class="<%= $class %>"><%= $paste %></code></pre>
</div>
<div class="clear"></div>
</div>
<br />
