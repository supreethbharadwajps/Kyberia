<!--
This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.
-->

{include file="modules/header.tpl"} 
<table cellspacing='0' cellpadding='0' width='780' align='left' valign='top'>
<tr><td colspan='2' align='center'>
</td></tr>
<tr>
<td align='center' valign='top' style='width: 230px'>
{include file="modules/loginbox.tpl"}
<br>

<br>
</td>
<td>
 <td valign="top"><IMG height=1 src="/images/sv/pruh.gif" width=8></td>
    <td valign="top">
	<div align="right">
		<table border="0" style="border-collapse: collapse" id="table1" cellpadding="0">
			<tr>
				<td>
				<a href='/'><img border="0" src="/images/sv/logo_sv.gif" width="180" height="108"></a></td>
				<td><IMG height=28 src="/images/sv/pruh.gif" width=115></td>
			</tr>
			<tr>
				<td colspan="2">
				&nbsp;</td>
			</tr>
		</table>
	</div>
	
	  <table class="BgContent" border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr valign="top">
          <td><IMG height=4 src="/images/sv/lt.gif" width=4 ></td>
		  <td><IMG height=28 src="/images/sv/pruh.gif" width=462></td>
		  <td align="right"><IMG height=4 src="/images/sv/rt.gif" width=4 ></td>
		  <td style="background-color: #FFFFFF"><IMG height=1 src="/images/sv/pruh.gif" width=8></td>
		  <td><IMG height=4 src="/images/sv/lt.gif" width=4 ></td>
		  <td><IMG height=28 src="/images/sv/pruh.gif" width=148></td>
		  <td align="right"><IMG height=4 src="/images/sv/rt.gif" width=4 ></td>
		</tr>
		<tr>
		  <td colspan="3" valign="top">
		    <table border="0" cellpadding="0" cellspacing="0" width="470">
			  <tr>
				<td height="56" valign="bottom" class="BgTitle"><IMG height=30 alt="" src="/images/sv/pruh.gif" width=11 align=left border=0><span class="title">{$node.node_name}</span></td>
				<td height="56" width="300"><IMG height="56" alt="" src="/images/sv/head_l.jpg" width="300" border="0"></td>
			  </tr>
			  <tr>
				<td valign="bottom" colspan="2">&nbsp;</td>
			  </tr>
			</table>
			<table border="0" style="border-collapse: collapse" width="470" id="table11" cellpadding="0">
		      <tr><td height="20" valign="bottom" bgcolor="#FFFFFF"><img border="0" src="/images/sv/reklama.gif" width="470" height="8"></td>
		      </tr>
		      <tr><td><p align="center"><a href='http://www.konopa.cz'><img src="http://sv.somastudio.sk/dopln/konopaczfull.gif" width="468" height="60" style="border-left: 1px solid #6E6695; border-right: 1px solid #6E6695; border-bottom: 1px solid #6E6695"></a></td>
			  </tr>
			</table>
			<br>



<!--main central column-->
{*showing node_content*}
{include file="modules/node_content.tpl"}
{*showing form for adding child node*}
{if $permissions.r eq true}{include file="modules/addnode.tpl"}{/if}
{include file="modules/get_threaded_children.tpl"}
<!--end of central column-->

</td>

<td  style="background-color: #FFFFFF"><IMG height=1 src="/images/sv/pruh.gif" width=8></td>
<td colspan="3" valign="top">

<table border="0" cellpadding="0" cellspacing="0" width="154">
  <tr>
    <td height="56" valign="bottom"><IMG height="56" alt="" src="/images/sv/head_r.jpg" width="155" border="0"></td>
  </tr>
</table>

<br><br>
{include file="modules/get_poll_box.tpl"}

</td>
</tr>
<tr valign="bottom">
  <td><IMG height=4 src="/images/sv/lb.gif" width=4 ></td>
  <td><p align="center"><IMG height=28 src="/images/sv/pruh.gif" width=1>. o.z. slobodna volba, <a href="mailto:info@slobodnavolba.sk">info@slobodnavolba.sk</a><br><br></td>   <td align="right"><IMG height=4 src="/images/sv/rb.gif" width=4 ></td>
  <td style="background-color: #FFFFFF">&nbsp;</td>
  <td><IMG height=4 src="/images/sv/lb.gif" width=4 ></td>
  <td>&nbsp;</td>
  <td><IMG height=4 src="/images/sv/rb.gif" width=4 ></td>
</tr>

<tr>
  <td style="background-color: #FFFFFF" colspan="7"><IMG height=14
src="/images/sv/pruh.gif" width=1></td>
</tr>

</table>
</td>
</tr>
</table>
</body>
</html>