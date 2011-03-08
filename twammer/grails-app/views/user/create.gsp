

<%@ page import="me.twammer.domain.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="username"><g:message code="user.username.label" default="User Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'username', 'errors')}">
              	                  <g:hasErrors bean="${userInstance}" field="username">
									<g:eachError bean="${userInstance}" field="username">
										<p style="color: red;"><g:message error="${it}"/></p>
									</g:eachError>
									</g:hasErrors>
                                    <g:textField name="username" maxlength="20" value="${userInstance?.username}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="user.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">
                                    <g:textField name="password" value="${userInstance?.password}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="user.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${userInstance?.email}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fullName"><g:message code="user.profile.fullname.label" default="Full Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'profile.fullName', 'errors')}">
                                    <g:textField name="profile.fullName" value="${userInstance?.profile.fullName}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="website"><g:message code="user.profile.website.label" default="Web site URL" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'profile.website', 'errors')}">
                                    <g:textField name="profile.website" value="${userInstance?.profile.website}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bio"><g:message code="user.profile.bio.label" default="A Little About yourself:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'profile.bio', 'errors')}">
                                    <g:textField name="profile.bio" value="${userInstance?.profile.bio}" />
                                </td>
                            </tr>
                        <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="photo"><g:message code="user.profile.photo.label" default="A picture:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'profile.photo', 'errors')}">
                                    <input name="profile.photo" id="avatar" type="file" />
                                	 <div style="font-size:0.8em; margin: 1.0em;">
      										For best results, your photo should have a width-to-height ratio of 4:5.
      										For example, if your image is 80 pixels wide, it should be 100 pixels high.
    								</div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
