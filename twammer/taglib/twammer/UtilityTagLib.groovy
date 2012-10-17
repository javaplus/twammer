package twammer

import java.util.regex.*

class UtilityTagLib {
	
	def linkify= { attrs, body ->
		String textBody = body()
		def text = textBody
		def matcher = text =~ /http?[s]?:\/\/[a-zA-Z0-9\-\.]+[\/a-zA-Z0-9\-\.]+/
		
		matcher.each {
			textBody = textBody.replace(it, "<a href=\"${it}\">${it}</a>");
			}
		
		// def newText = (text =~ /http?[s]?:\/\/[a-zA-Z0-9]/).replaceAll("<a href=\"${}")
		out << textBody
		
	}

}
