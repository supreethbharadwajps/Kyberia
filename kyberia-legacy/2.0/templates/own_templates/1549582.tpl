<!--
This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.
-->

{if $template_event eq 'preview'}
<table>
<tr>
<td valign='top' rowspan='2' ><img hspace='5' src='{get_image_link id=$user_id}'></td>
<td width='100%' valign='top'>
<table width='100%'><tr class='header'>
<td align='center'>PREVIEW

<tr><td>{$post_vars.node_content|preview}</td></tr>
</table>
</table>
{* end of preview *}

{elseif $template_event eq 'filter_by'}
	{get_children listing_amount=23232322323 offset=$offset types=$children_types search_type=$post_vars.search_type search=$post_vars.node_content}
{elseif $node.node_user_subchild_count eq true}
	{get_children children_type=$children_type listing_amount=$node.node_user_subchild_count+5 offset=$offset}
{else}
	{get_children children_type=$children_type listing_amount=$listing_amount offset=$offset}
{/if}

{get_linked_nodes}

{merge_arrays array1=$get_children array2=$get_linked_nodes sort_by='node_created'}


{foreach from=$merged item=child}
<table class='bordered' cellspacing='0' cellpadding='0'>
<tr>
<td align='center' valign='top' rowspan='2'>
	<img vspace='5' hspace='5' width='50' src='{get_image_link id=$child.node_creator}'>
	{if $child.k eq true}<span class='most_important'>{$child.k} k</span>{/if}
</td>

<td valign='top' style='width: 100%'>
	<table width=100%>
		<tr class='header' width=100% valign='top'><td>
		&nbsp;<a href='/id/{$child.node_creator}'>{$child.creator}</a>
		{if $child.user_action neq false}
			&nbsp;[lokacia :: <a href='/{$child.user_action}/'>{$child.user_action}</a>]
		{/if}
		&nbsp;&nbsp;{$child.node_created|date_format:"%H:%M:%S - %d.%m.%Y"}&nbsp;
		&nbsp;&nbsp;<input type='checkbox' value='{$child.node_id}' name='node_chosen[]'>
		&nbsp;&nbsp;<a href='/id/{$child.node_id}'>{$child.node_name}</a>&nbsp;&nbsp;
		{if $child.node_created > $node.last_visit}<span class='most_important'>&nbsp;&nbsp;NEW</span>{/if}
		{if $child.node_children_count}<span class='most_important'>{$child.node_children_count}&nbsp;&nbsp;CHILDREN</span>{/if}
		{if $child.node_parent neq $node.node_id}<span class='most_important'>LINKED</span>{/if}
		</td></tr>
		<tr><td>{$child.node_content|stripslashes}</td></tr>
	</table>
</table>
<br>
{/foreach}
