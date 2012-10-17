/**
 * 
 */
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"></script>
<script type="text/javascript" src="./jquery.periodicalupdater.js"></script>

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

            $.PeriodicalUpdater('twams/active.html',
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
	$('#twam-text').html(twam.text);
	$('#twam-user').html(twam.user);
	$('#twam-time').html(twam.time);
	$("#myImage").attr("src", twam.image);	
}

</script>
