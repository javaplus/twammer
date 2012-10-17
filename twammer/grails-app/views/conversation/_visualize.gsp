<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="keywords" content="">
<meta name="description" content="">
<title>Visual Twammer - Twitter, Yammer, and Spam Altogether Now</title>
<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7/themes/cupertino/jquery-ui.css">
<style>

.container {
		   background-color: #000000;
		   text-align:center;
		   
}

.twammer {
        z-index:9999;
        padding:30px;
        background-color: #8599A8;
}

</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"></script>
<g:javascript src="jquery.periodicalupdater.js" />
<g:javascript library="utility" />

<script>

var log = function(msg) {
      try {
        console.log(msg);
      } catch(err) {}
    }

$.fn.centerInClient = function(options) {
    /// <summary>Centers the selected items in the browser window. Takes into account scroll position.
    /// Ideally the selected set should only match a single element.
    /// </summary>    
    /// <param name="fn" type="Function">Optional function called when centering is complete. Passed DOM element as parameter</param>    
    /// <param name="forceAbsolute" type="Boolean">if true forces the element to be removed from the document flow 
    ///  and attached to the body element to ensure proper absolute positioning. 
    /// Be aware that this may cause ID hierachy for CSS styles to be affected.
    /// </param>
    /// <returns type="jQuery" />
    var opt = { forceAbsolute: false,
                container: window,    // selector of element to center in
                completeHandler: null
              };
    $.extend(opt, options);
   
    return this.each(function(i) {
        var el = $(this);
        var jWin = $(opt.container);
        var isWin = opt.container == window;

        // force to the top of document to ENSURE that 
        // document absolute positioning is available
        if (opt.forceAbsolute) {
            if (isWin)
                el.remove().appendTo("body");
            else
                el.remove().appendTo(jWin.get(0));
        }

        // have to make absolute
        el.css("position", "absolute");

        // height is off a bit so fudge it
        var heightFudge = isWin ? 2.0 : 1.8;

        var x = (isWin ? jWin.width() : jWin.outerWidth()) / 2 - el.outerWidth() / 2;
        var y = (isWin ? jWin.height() : jWin.outerHeight()) / heightFudge - el.outerHeight() / 2;

        el.css("left", x + jWin.scrollLeft());
        el.css("top", y + jWin.scrollTop());

        // if specified make callback and pass element
        if (opt.completeHandler)
            opt.completeHandler(this);
    });
}

function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function eraseCookie(name) {
	createCookie(name,"",-1);
}

$(function() {
 $("#twammer").centerInClient();
});


$(document).ready(function(){

            $.PeriodicalUpdater('<g:createLink controller="conversation" action="getLatestTwam" id="${conversation.id}" />',
			    {
                    method: 'get',
                    maxTimeout: 3000
                },
                function(data){
                   switchTwam(data);
			              });
			
   			 
})


function switchTwam (data) {
      log ('new content: ' + data);
	  $('#twammer').fadeOut(400);
	  var t = setTimeout ( function () {
	  
	  	  	  //$('#twammer').replaceWith(data);
			  processTwam(data);
			  $('#twammer').centerInClient();
	  	  	  $('#twammer').fadeIn(400);
			  log ('done');
	  }, 400 );
}

function processTwam (data) {
	var twam = eval('('+ data +')');
	
	$('#twam-text').html(urlify(twam.text));
	$('#twam-user').html(twam.user);
	$('#twam-time').html(twam.time);
	$("#myImage").attr("src", '../..'+ twam.image);	
}

</script>


</head>
<body class="container">
<div id="header" style="float:left;">
	 <div id="header" style="padding: 0px; margin: 0px; color: #D4D6D9;">
	 	  <div style="font-size: 30px; padding-top: 10px;"><b>Visual Twammer</b></div>
	 </div>
	 <img src="${resource(dir:'images',file:'twam-explode.gif')}" alt="Twammer" border="0" />
</div>
<div id="twammer" class="twammer" style="margin: 50px;">
<div style="float: right; text-align: left; font-size: 45px;">

  <div id="twam-text">
  Welcome to the Java Community of Practice Reference Architecture Refresh user group!
  </div>
<br>
<div style="float: left; margin: 0px; padding: 0px; padding-right: 10px">
  <img id="myImage" src="twams/images/PUGHJ.jpg" height="80" width="80"/>
</div>
<div style="padding-top: 20px; font-size: 25px;">
<b style="margin-left: 10px; padding-left: 10px;">
  <span id="twam-user">
  pughj
  </span>,
  <span id="twam-time">

  2 mins ago
  </span>
</b>
</div>
</div>

</div>
  <g:hiddenField name="conversation-id" id="conversation-id" value="${conversation.id}" />
</body>
</html>
