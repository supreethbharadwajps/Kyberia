<!--
This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.
-->

<html>
<head>
<meta http-equiv="Cache-Control" content="Public">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250">

<link rel='stylesheet' type='text/css' href='/id/1491446/download'>
<title> {$node.node_name}</title>
{if $node.node_name eq 'mail'}
<script>
function vymena() {ldelim}
document.formular.mail_to.value = document.formular.mail_to.value.toLowerCase() ;
document.images['fricon'].src = '/images/users/'+document.formular.mail_to.value+'.gif';
{rdelim}

function chngto(name,id) {ldelim}
document.formular.mail_to.value = name ;
name = name.toLowerCase() ;
document.images['fricon'].src = '/images/nodes/' +id.substr(0,1)+'/'+id.substr(1,1)+'/'+id+'.gif';
{rdelim}
</script>
{/if}

</head>

<body>
<!-- here you can realize yourself -->
<div class="t1">
<form enctype="multipart/form-data" action='/id/{$user_id}/' method='post'>
<a href='/id/1/'>id1</a> ----
<a href='/id/101/'>kyberia</a> ----
<a href='/id/19'>elskanligr</a> ----
<a href='/id/24'>sendingar</a> ----
<a href='/id/23'>n�ligr</a> ----
<a href='/id/15'>k</a> ----
<a href='/id/27'>menn</a> ----
<!-- <a href='/id/20'>clanky</a> ---- -->
<a href='/id/21'>dagligr</a> ----
<a href='/id/25'>leita</a> ----
<a href='/id/{$user_id}/configure'>config</a> -----
<input type='submit' value='strj�ka' name='event' tabindex='23'>
</form>
</div>
<div class="t2"></div>
{if $new_mail eq true}
<center><a href='/id/24'><b>&#254;� hafi&#240; {$new_mail} sendingar -- n�ligr fr� {$new_mail_name}</b></a></center>
{/if}

{if $error eq true}
<center><span align='center' class='most_important'>{$error}</span></center>
{/if}

