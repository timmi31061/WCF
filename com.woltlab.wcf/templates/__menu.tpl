<nav>
	<ol class="boxMenu">
		{foreach from=$menuItemNodeList item=menuItemNode}
			<li class="{if $menuItemNode->isActiveNode()}active{/if}{if $menuItemNode->hasChildren()} boxMenuHasChildren{/if}">
				<a href="{$menuItemNode->getMenuItem()->getURL()}" class="boxMenuLink">
					<span class="boxMenuLinkTitle">{lang}{$menuItemNode->getMenuItem()->title}{/lang}</span>
					{if $menuItemNode->getMenuItem()->getOutstandingItems() > 0}
						<span class="boxMenuLinkOutstandingItems badge badgeUpdate">{#$menuItemNode->getMenuItem()->getOutstandingItems()}</span>
					{/if}
				</a>
				
				{if $menuItemNode->hasChildren()}<ol class="boxMenuDepth{@$menuItemNode->getDepth()}">{else}</li>{/if}
					
				{if !$menuItemNode->hasChildren() && $menuItemNode->isLastSibling()}
					{@"</ol></li>"|str_repeat:$menuItemNode->getOpenParentNodes()}
				{/if}
		{/foreach}
	</ol>
</nav>
