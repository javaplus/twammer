

<%@ page import="me.twammer.domain.Twam" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'twam.label', default: 'Twam')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${twamInstance}">
            <div class="errors">
                <g:renderErrors bean="${twamInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${twamInstance?.id}" />
                <g:hiddenField name="version" value="${twamInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="message"><g:message code="twam.message.label" default="Message" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: twamInstance, field: 'message', 'errors')}">
                                    <g:textField name="message" value="${twamInstance?.message}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="shownDatePosted"><g:message code="twam.shownDatePosted.label" default="Shown Date Posted" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: twamInstance, field: 'shownDatePosted', 'errors')}">
                                    <g:textField name="shownDatePosted" value="${twamInstance?.shownDatePosted}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fromWho"><g:message code="twam.fromWho.label" default="From Who" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: twamInstance, field: 'fromWho', 'errors')}">
                                    <g:textField name="fromWho" value="${twamInstance?.fromWho}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="actualDatePosted"><g:message code="twam.actualDatePosted.label" default="Actual Date Posted" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: twamInstance, field: 'actualDatePosted', 'errors')}">
                                    <g:datePicker name="actualDatePosted" precision="day" value="${twamInstance?.actualDatePosted}"  />
                                </td>
                            </tr>
                        
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
