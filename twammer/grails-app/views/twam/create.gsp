

<%@ page import="me.twammer.domain.Twam" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'twam.label', default: 'Twam')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${twamInstance}">
            <div class="errors">
                <g:renderErrors bean="${twamInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:if test="${conversation}">
	            <div class="conversation-row" >
					<div class="conversation-text">
						${conversation.title}
					</div>
					<g:if test="${conversation.twams}">
						<g:each var="twamInstance" in="${conversation.twams}">
		
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
				</div>
            </g:if>
            <g:form action="save" enctype="multipart/form-data">
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
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user"><g:message code="twam.avatar.label" default="Avatar" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: twamInstance, field: 'avatar', 'errors')}">
                                	<input name="avatar" id="avatar" type="file" />
                                	 <div style="font-size:0.8em; margin: 1.0em;">
      										For best results, your avatar should have a width-to-height ratio of 4:5.
      										For example, if your image is 80 pixels wide, it should be 100 pixels high.
    								</div>
                                </td>
                            </tr>
                            <g:if test="${conversation}">
                        		<g:hiddenField name="conversation_id" value="${conversation.id}" />
                        	</g:if>
                        
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
