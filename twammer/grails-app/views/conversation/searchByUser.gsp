<html>
<head>
<meta name="layout" content="main" />
<title>Conversation search</title>
</head>
<body>
<formset>
	<legend>Search for Conversations by user</legend>
	<g:form action="searchByUserResults">
	<label for="username">User Name</label>
	<g:textField name="username"/>
	<g:submitButton name="searchByUser" value="Search"/>
	</g:form>
 </formset>

</body>
</html>