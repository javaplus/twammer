<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
 "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
   <title><g:layoutTitle default="Twammer" /></title>
   <link rel="stylesheet" href="http://yui.yahooapis.com/2.8.0r4/build/reset-fonts-grids/reset-fonts-grids.css" type="text/css">
   <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
   <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
   <g:layoutHead />
   <g:javascript library="application" />
   <style type="text/css">
   #custom-doc { width: 71%; min-width: 250px; background: #000;}
   </style>
</head>
<body>
<div id="custom-doc" class="yui-t7">
   <div id="hd" role="banner"> 
   		<div id="TwammerLogo">
        	<a href="http://twammer.me"><img src="${resource(dir:'images',file:'twam-explode.gif')}" alt="Twammer" border="0" /></a>
        </div>
        <div id="TwammerText">Welcome to Twammer!</div>
        	
   		
   </div>
   <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
			<sec:ifLoggedIn>
				<span class="menuButton"><g:link class="create" controller="conversation" action="create">Create Conversation</g:link></span>
			</sec:ifLoggedIn>            
        </div>
   <div id="bd" role="main">
		<div class="yui-ge">
    		<div class="yui-u first">
				<g:layoutBody />
	    	</div>
    		<div class="yui-u">
				<sec:ifNotLoggedIn>
					<g:include controller='login' action='auth'/>
				</sec:ifNotLoggedIn>
				<sec:ifLoggedIn>
					Welcome Back <sec:loggedInUserInfo field="username"/><br> 
					<g:link controller="logout" >logout</g:link>
				</sec:ifLoggedIn>
	    	</div>
		</div>

	</div>
   <div id="ft" role="contentinfo"><p>Footer</p></div>
</div>
</body>
</html>
