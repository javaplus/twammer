
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
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'conversation.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="title" title="${message(code: 'conversation.title.label', default: 'Title')}" />
                        
                            <th><g:message code="conversation.user.label" default="User" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${conversationInstanceList}" status="i" var="conversationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${conversationInstance.id}">${fieldValue(bean: conversationInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: conversationInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: conversationInstance, field: "user")}</td>
                            <td><g:remoteLink controller="twam" action="conversation" id="${conversationInstance.id}" update="conversation_twam">Show Twams</g:remoteLink></td>
                            
                        </tr>
                        <div id="conversation_twam"></div>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${conversationInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
