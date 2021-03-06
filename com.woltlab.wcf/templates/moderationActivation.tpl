{include file='documentHeader'}

<head>
	<title>{lang}wcf.moderation.activation{/lang}: {$queue->getTitle()} - {PAGE_TITLE|language}</title>
	
	{include file='headInclude'}
	
	<script data-relocate="true">
		//<![CDATA[
		$(function() {
			WCF.Language.addObject({
				'wcf.moderation.activation.enableContent.confirmMessage': '{lang}wcf.moderation.activation.enableContent.confirmMessage{/lang}',
				'wcf.moderation.activation.removeContent.confirmMessage': '{lang}wcf.moderation.activation.removeContent.confirmMessage{/lang}',
				'wcf.moderation.assignedUser': '{lang}wcf.moderation.assignedUser{/lang}',
				'wcf.moderation.assignedUser.change': '{lang}wcf.moderation.assignedUser.change{/lang}',
				'wcf.moderation.assignedUser.error.notAffected': '{lang}wcf.moderation.assignedUser.error.notAffected{/lang}',
				'wcf.moderation.status.outstanding': '{lang}wcf.moderation.status.outstanding{/lang}',
				'wcf.moderation.status.processing': '{lang}wcf.moderation.status.processing{/lang}',
				'wcf.user.username.error.notFound': '{lang __literal=true}wcf.user.username.error.notFound{/lang}'
			});
			
			new WCF.Moderation.Activation.Management({@$queue->queueID}, '{link controller='ModerationList' encode=false}{/link}');
		});
		//]]>
	</script>
</head>

<body id="tpl{$templateName|ucfirst}" data-template="{$templateName}" data-application="{$templateNameApplication}">

{include file='header'}

<header class="boxHeadline">
	<h1>{lang}wcf.moderation.activation{/lang}: {$queue->getTitle()}</h1>
	
	{if $queue->lastChangeTime}
		<dl class="plain inlineDataList">
			<dt>{lang}wcf.moderation.lastChangeTime{/lang}</dt>
			<dd>{@$queue->lastChangeTime|time}</dd>
		</dl>
	{/if}
	
	<dl class="plain inlineDataList" id="moderationAssignedUserContainer">
		<dt>{lang}wcf.moderation.assignedUser{/lang}</dt>
		<dd>
			<span>
				{if $queue->assignedUserID}
					<a href="{link controller='User' id=$assignedUserID}{/link}" class="userLink" data-user-id="{@$assignedUserID}">{$queue->assignedUsername}</a>
				{else}
					{lang}wcf.moderation.assignedUser.nobody{/lang}
				{/if}
			</span>
		</dd>
	</dl>
	
	<dl class="plain inlineDataList" id="moderationStatusContainer">
		<dt>{lang}wcf.moderation.status{/lang}</dt>
		<dd>{$queue->getStatus()}</dd>
	</dl>
</header>

{include file='userNotice'}

{include file='formError'}

<header class="boxHeadline boxSubHeadline">
	<h2>{lang}wcf.moderation.activation.content{/lang}</h2>
	<p>{lang}wcf.moderation.type.{@$queue->getObjectTypeName()}{/lang}</p>
</header>

<div class="marginTop">
	{@$disabledContent}
</div>

<div class="contentNavigation">
	<nav>
		<ul>
			{if !$queue->isDone()}
				{if $queueManager->canRemoveContent($queue->getDecoratedObject())}<li class="jsOnly"><a id="enableContent" class="button"><span class="icon icon16 icon-check"></span> <span>{lang}wcf.moderation.activation.enableContent{/lang}</span></a></li>{/if}
				<li class="jsOnly"><a id="removeContent" class="button"><span class="icon icon16 icon-remove"></span> <span>{lang}wcf.moderation.activation.removeContent{/lang}</span></a></li>
			{/if}
			{if $queue->getAffectedObject()}<li><a href="{$queue->getAffectedObject()->getLink()}" class="button"><span class="icon icon16 fa-arrow-right"></span> <span>{lang}wcf.moderation.jumpToContent{/lang}</span></a></li>{/if}
			
			{event name='contentNavigationButtons'}
		</ul>
	</nav>
</div>

<header id="comments" class="boxHeadline boxSubHeadline">
	<h2>{lang}wcf.moderation.comments{/lang} <span class="badge">{#$queue->comments}</span></h2>
	<p>{lang}wcf.moderation.comments.description{/lang}</p>
</header>

{include file='__commentJavaScript' commentContainerID='moderationQueueCommentList'}

<div class="container marginTop moderationComments">
	<ul id="moderationQueueCommentList" class="commentList containerList" data-can-add="true" data-object-id="{@$queueID}" data-object-type-id="{@$commentObjectTypeID}" data-comments="{@$commentList->countObjects()}" data-last-comment-time="{@$lastCommentTime}">
		{include file='commentList'}
	</ul>
</div>

{include file='footer'}

</body>
</html>
