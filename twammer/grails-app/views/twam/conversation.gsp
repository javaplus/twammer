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
						<g:userIsOwner user="${twamInstance.user}"><div class="twam-delete"><g:link controller="twam" action="delete" id="${twamInstance.ident()}">Delete Twam</g:link></div>
						<div class="twam-delete"><g:link controller="twam" action="edit" id="${twamInstance.ident()}">Edit Twam</g:link></div></g:userIsOwner>
						<div class="twam-message"><g:linkify>${twamInstance.message}</g:linkify></div>
					</div>
				</div>
		
				</g:each>
			
			</g:if>