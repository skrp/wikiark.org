#!/usr/local/bin/perl
use strict; use warnings;
########################
# GREETY - raw http dump
get '/' => 'form';
app->start('daemon', '-l', 'http://*:6661');
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
