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
<link rel="shortcut icon" href="http://freezy.rulez.sk/kyb.ico">

<!-- CSS -->
<link rel='stylesheet' type='text/css' href='http://freezy.rulez.sk/kyb_orange.css'>

<!-- TITLE -->
<title>{if $new_mail eq true}{$new_mail} m@il from {$new_mail_name} || {/if}{$node.node_name} || {$node.node_id} || {$user_k}K left ||</title>

<!-- IN MAIL SCRIPT -->
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
<!-- HEADER -->
<div class="t1">
<form enctype="multipart/form-data" action='/id/{$user_id}/' method='post'>
<a href='/id/1/'>main</a>&nbsp;
<a href='/id/101/'>kyberia</a>&nbsp;
<a href='/id/102/'>hysteria</a>&nbsp;
<a href='/id/19/'>bookmarks</a>&nbsp;
{if $new_mail eq true}
<a href='/id/1693948/'><i><b><font color='white'>mail</font></b></i></a>&nbsp;
{else}
<a href='/id/1693948/'>mail</a>&nbsp;
{/if}
<!-- <a href='/id/24/'>mail</a> -->
<a href='/id/23/'>last</a>&nbsp;
<!-- <a href='/id/15/'>k!</a>&nbsp; -->
<a href='/id/1670413/'>k!</a>&nbsp;
<!-- <a href='/id/27'>people</a> -->
<a href='/id/21/'>blogs</a>&nbsp;
<!-- <a href='/id/29'>news</a> -->
<a href='/id/25/'>search</a>&nbsp;
<a href='/id/1127438/'>frz&#39;s</a>&nbsp;
<a href='/id/{$user_id}/'>me</a>&nbsp;
<a href='/id/{$user_id}/configure'>configure</a>&nbsp;&nbsp;
 <input type='submit' value='logout' name='event' tabindex='23'>
 </form>
</div>
 <div class="t2"></div>
{if $new_mail eq true}
<center><a href='/id/1693948' class='mail'>u have {$new_mail} new mail, last from {$new_mail_name}</a></center>
{/if}

{if $error eq true}
<center><span align='center' class='most_important'>{$error}</span></center>
{/if}
