<!--
This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.
-->

{if $user_id eq false}
<center>{include file="modules/loginbox.tpl"}</center><br><br>
{/if}

<table width='70%'>
<tr><td>name/keywordz: 
<td><input type='text' name='node_name' value='{$node.node_name}'>
<td>system_access
<td><select name='node_system_access'>
<option value='public' {if $node.node_system_access eq 'public'}selected{/if}>public</option>
<option value='moderated' {if $node.node_system_access eq 'moderated'}selected{/if}>moderated</option>
<option value='private' {if $node.node_system_access eq 'private'}selected{/if}>private</option>
<option value='personal' {if $node.node_system_access eq 'personal'}selected{/if}>personal</option>
<option value='crypto' {if $node.node_system_access eq 'crypto'}selected{/if}>crypto</option>
</select></td>
{*<td>node_creator<td><input type='text' name='node_creator' value='$node.owner'>*}
<tr><td>parent: 
<td align='left'>
<input type='text' name='node_parent' value='{$node.node_parent}'>
<td>external_access<td><input name='node_external_access' type='checkbox' value='yes' {if $node.node_external_access eq 'yes'}checked{/if}>
<td>image</td><td><input type='file' name='description_image'>
<tr><td colspan='6' align='center'><input type='submit' name='event' value='configure'></td></tr></table>
<br>
{if $node.node_system_access eq 'crypto'}crypto password: {$crypto_pass}{/if}
<br>sablona:
default: <input type='radio' name='node_template' value='default' {if $node.node_template eq 'default'}checked{/if}>
own: <input type='radio' name='node_template' value='own' {if $node.node_template eq 'own'}checked{/if}>
<input type='file' name='template_file'>&nbsp;&nbsp;<input type='submit' name='event' value='upload_own_template'><br><br>
