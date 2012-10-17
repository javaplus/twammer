
<%@ page import="me.twammer.domain.Conversation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'conversation.label', default: 'Conversation')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="conversation.title.label" default="Title" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: conversationInstance, field: "title")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="conversation.user.label" default="User" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${conversationInstance?.user?.id}">${conversationInstance?.user?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <g:if test="${twams}">
				<g:each var="twamInstance" in="${twams}">
	
					<div class="twam-row" >
						<div class="twam-image">
							<g:if test="${twamInstance.avatar}">
  								<img class="avatar" src="${createLink(controller:'image', action:'avatar_image', id:twamInstance.ident())}" />
							</g:if>
						</div>
						<div class="twam-text">
							<div class="twam-fromwho">${twamInstance.fromWho}</div>
							<div class="twam-message">${twamInstance.message}</div>
						</div>
					</div>	
				</g:each>
			</g:if>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${conversationInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:link controller="twam" action="create" id="${conversationInstance.id}">Add Twam</g:link></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
