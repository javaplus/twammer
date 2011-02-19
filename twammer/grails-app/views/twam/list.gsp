
<%@ page import="me.twammer.domain.Twam" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'twam.label', default: 'Twam')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'twam.id.label', default: 'Id')}" />
                            
                            <g:sortableColumn property="avatar" title="${message(code: 'twam.avatar.label', default: 'Avatar')}" />
                        
                            <g:sortableColumn property="message" title="${message(code: 'twam.message.label', default: 'Message')}" />
                        
                            <g:sortableColumn property="shownDatePosted" title="${message(code: 'twam.shownDatePosted.label', default: 'Shown Date Posted')}" />
                        
                            <g:sortableColumn property="fromWho" title="${message(code: 'twam.fromWho.label', default: 'From Who')}" />
                        
                            <g:sortableColumn property="actualDatePosted" title="${message(code: 'twam.actualDatePosted.label', default: 'Actual Date Posted')}" />
                        
                            <th><g:message code="twam.user.label" default="User" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${twamInstanceList}" status="i" var="twamInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${twamInstance.id}">${fieldValue(bean: twamInstance, field: "id")}</g:link></td>
                        
                            <td><g:if test="${twamInstance.avatar}">
  									<img class="avatar" src="${createLink(controller:'image', action:'avatar_image', id:twamInstance.ident())}" />
								</g:if>
							</td>
                            <td>${fieldValue(bean: twamInstance, field: "message")}</td>
                        
                            <td>${fieldValue(bean: twamInstance, field: "shownDatePosted")}</td>
                        
                            <td>${fieldValue(bean: twamInstance, field: "fromWho")}</td>
                        
                            <td><g:formatDate date="${twamInstance.actualDatePosted}" /></td>
                        
                            <td>${fieldValue(bean: twamInstance, field: "user")}</td>
                            
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${twamInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
