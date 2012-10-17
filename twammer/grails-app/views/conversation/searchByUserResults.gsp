<html>
<head>
<title>Search Results</title>

<meta name="layout" content="main" />
</head>
<body>
<h1>Results</h1>
<p>Searched ${me.twammer.domain.Conversation.count()} records for items
matching <em>
${name}
</em>. 

<g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMsg}"/>
<g:if test="${!conversations}">
	<br><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMsg}"/>
</g:if>
<g:else>
Found <strong>
${conversations.size()}
</strong> hits.</p>
	<g:each var="conversation" in="${conversations}">
	
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
	</g:each>
</g:else>
<div><g:link action='searchByUser'>Search Again</g:link></div>

</body>
</html>