<!--
This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.
-->

{include file="modules/header.tpl"}

<table width=100%>
<tr><td valign='top' width=12%>
{include file="modules/get_userlist.tpl"}
</td>

<td valign='top' width=50%>
23

<center>

</center>
{get_bookmarks}
{foreach from=$get_bookmarks item=bookmark_category}
{* showing bookmark category  *}
{if $bookmark_category.node_name neq false && $bookmarks.node_id neq ''}
<a class='important' href='/id/{$bookmark_category.node_id}/'>{$bookmark_category.node_name}</a>
{if $bookmark_category.sum neq false}
:: <span class='most_important'> {$bookmark_category.sum} NEW</span>
{/if}
&nbsp;&nbsp;
{if $bookmark_category.on_main eq yes}
<a class='important' href='/id/{$node.node_id}/{$bookmark_category.node_id}'>^</a>
{else}
<a class='important' href='/id/{$node.node_id}/{$bookmark_category.node_id}'>^</a>
{/if}
{/if}
<br>
{if $bookmark_category.on_main neq 'no'}
{foreach from=$bookmark_category.children item=bookmarks}
{if $bookmarks.node_name neq false && $bookmarks.node_id neq ''}
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='/id/{$bookmarks.node_id}'>{$bookmarks.node_name}</a>
{if $bookmarks.node_user_subchild_count neq false}
:: <span class='most_important'> {$bookmarks.node_user_subchild_count} NEW CHILDREN</span>
{/if}
{if $bookmarks.lastdescendant_created > $bookmarks.last_visit}
:: <span class='most_important'>!!NEW DESCENDANT!!</span>
{/if}

{/if}
<br>
{/foreach}
{/if}
<br>
{/foreach}

{include file="modules/addnode_small.tpl"}


</td></tr></table>

{include file="modules/footer.tpl"}
