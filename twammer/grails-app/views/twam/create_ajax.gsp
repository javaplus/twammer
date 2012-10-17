<%@ page import="me.twammer.domain.Twam" %>
<%@ page import="me.twammer.domain.Conversation" %>
<div>
            <g:form controller="twam" action="save" enctype="multipart/form-data">
                <div class="dialog">
                            <div class="twam_message_label_div">
                                <label for="message"><g:message code="twam.message.label" default="Message" /></label>
                                <g:textArea id="twam-message-textarea" name="message" value="${twamInstance?.message}" rows="5" cols="150" />
                            </div>
                            
                            <div class="twam_shownDate_label_div">
                                <label for="shownDatePosted"><g:message code="twam.shownDatePosted.label" default="Shown Date Posted" /></label>
                                <g:textField name="shownDatePosted" value="${twamInstance?.shownDatePosted}" />  Can be anything  (1 min ago, 200 years ago, etc...)
                            </div>
                                                  
                            <div class="twam_fromWho_label_div">
                             	<label for="fromWho"><g:message code="twam.fromWho.label" default="From Who" /></label>
                                <g:textField name="fromWho" value="${twamInstance?.fromWho}" />  Can be any name
							</div>                        
                            
                            <div class="twam_avatar_label_div">
                                    <label for="user"><g:message code="twam.avatar.label" default="Avatar" /></label>
                                	<input name="avatar" id="avatar" type="file" />
                                	 <div style="font-size:0.8em; margin: 1.0em;">
      										For best results, your avatar should have a width-to-height ratio of 4:5.
      										For example, if your image is 80 pixels wide, it should be 100 pixels high.
      										Max size is 1MB.
    								</div>
                            </div>
                            <g:if test="${conversation}">
                        		<g:hiddenField name="conversation_id" value="${conversation.id}" />
                        	</g:if>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
