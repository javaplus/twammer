
<%@ page import="me.twammer.domain.Twam" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'twam.label', default: 'Twam')}" />
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
                            <td valign="top" class="name"><g:message code="twam.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: twamInstance, field: "id")}</td>
                            
                        </tr>
                    	<tr class="prop">
                    		<td valign="top" class="name"><g:message code="twam.avatar.label" default="Avatar" /></td>
                    		<td><g:if test="${twamInstance.avatar}">
  									<img class="avatar" src="${createLink(controller:'image', action:'avatar_image', id:twamInstance.ident())}" />
								</g:if>
							</td>
                    	</tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="twam.message.label" default="Message" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: twamInstance, field: "message")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="twam.shownDatePosted.label" default="Shown Date Posted" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: twamInstance, field: "shownDatePosted")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="twam.fromWho.label" default="From Who" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: twamInstance, field: "fromWho")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="twam.actualDatePosted.label" default="Actual Date Posted" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${twamInstance?.actualDatePosted}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="twam.user.label" default="User" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${twamInstance?.user?.id}">${twamInstance?.user?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${twamInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
