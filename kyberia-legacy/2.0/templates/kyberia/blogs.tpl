<!--
This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.
-->

{get_movement_params}
{include file="modules/header.tpl"}
{if $error eq true}
<center><font style='error'>{$error}</font></center>
{/if}

{if $user_id eq false}
<center>{include file="modules/loginbox.tpl"}</center>

{else}

<table width='100%'><tr>

<!--left column-->
<td valign='top' align='center' width='23%'>
{*include file="modules/get_nodetype_by_views.tpl" type=6 listing_amount=$listing_amount*}

<br>
</td>
<!--end of left column-->

<!--main central column-->
<td width='66%' valign='top'>
<center>{include file="modules/movement.tpl"}</center>
{include file="modules/get_nodes_by_type.tpl" type=6 vector=;1 listing_amount=$listing_amount}
<form method='post' action='/id/{$node.node_id}'>
<br><br><center>pridaj dennik<br><br>{include file="modules/addnode.tpl"}</center>
</form>
<!--end of central column-->

</td></tr></table>
{/if}

{include file="modules/footer.tpl"}