
<%@ page import="me.twammer.domain.Conversation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'conversation.label', default: 'Conversation')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript library="prototype"/>
    </head>
    <body>
 <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMsg}"/>
<g:if test="${!conversationInstanceTotal}">
	<br><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMsg}"/>
</g:if>
<g:else>
Found <strong>
${conversationInstanceTotal}
</strong> conversations.</p>
	<g:each var="conversation" in="${conversationInstanceList}">
	
		<div class="conversation-row" >
			<div class="conversation-text">
				<g:link controller="conversation" action="show" id="${conversation.id}">${conversation.title}</g:link>
			</div>
			<div class="conversation-visualize">
				<g:link controller="conversation" action="visualize" id="${conversation.id}">Visualize</g:link>
			</div>
			<div id="conversation_twam${conversation.id}"><g:if test="${conversation.twams}">
				<g:remoteLink controller="twam" action="conversation" id="${conversation.id}" update="conversation_twam${conversation.id}">Show Twams</g:remoteLink>
			</g:if>	
			</div>
		</div>	
	</g:each>
</g:else>
<div></div>

</body>
</html>
 </html>
