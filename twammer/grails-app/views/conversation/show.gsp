
<%@ page import="me.twammer.domain.Conversation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'conversation.label', default: 'Conversation')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:javascript library="prototype"/>
    </head>
    <body>
        
<%--            <h1><g:message code="default.show.label" args="[entityName]" /></h1>--%>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
          		<div class="conversation-row" >
					<div class="conversation-text">	${conversation.title}</div>
					<div id="conversation_twam${conversation.id}">
						<g:if test="${conversation.twams}">
<%--						// include the twams here for the conversation--%>
							<g:include view="twam/conversation.gsp" />
<%--							<g:link controller="twam" action="conversation" id="${conversation.id}" update="conversation_twam${conversation.id}">Show Twams</g:link>--%>
						</g:if>	
					</div>
					<div id="conversation_twam_create${conversation.id}">
					<g:remoteLink controller="twam" action="create_ajax" id="${conversation.id}" update="conversation_twam_create${conversation.id}">Add Twams</g:remoteLink>
					</div>
				</div>	
        
          
    </body>
</html>
