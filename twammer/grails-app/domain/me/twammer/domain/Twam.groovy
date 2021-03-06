package me.twammer.domain

class Twam {
	
	String message
	String shownDatePosted // this is made up and can be any text "1 min ago", "5 years in the future", etc...
	String fromWho
	Date actualDatePosted
	byte[] avatar // the avatar for this twam
	String avatarType
	Conversation conversation
	User user
	

		
	static constraints = {
		message(maxSize:256,nullable:false)
		shownDatePosted(nullable:false)
		fromWho(nullable:false)
		avatar(nullable:true, maxSize: 1000000 /* 1MB */)
		avatarType(nullable:true)
		conversation(nullable:true)
		
	}
	
	
	
	static mapping = {
		user lazy:true // don't load user with each twam.
	}
	

	@Override
	public String toString() {
		return "message:${message} fromWho:${fromWho} shownDatePosted:${shownDatePosted}";
	}	
	
}
