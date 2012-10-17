<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
        <table>
        <div id="TwammerLogo">
        	<tr>
        		<td><a href="http://twammer.me"><img src="${resource(dir:'images',file:'twam-explode.gif')}" alt="Twammer" border="0" /></a></td>
        		<td id="TwammerLogo">Welcome to Twammer!</td>
        	</tr>
        </div>
        </table>
        <g:layoutBody />
    </body>
</html>