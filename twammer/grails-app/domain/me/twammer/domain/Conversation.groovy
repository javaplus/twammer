package me.twammer.domain

/**
 * A Conversation represents a series of {@link Twam}s
 * 
 * @author btarlton
 *
 */
class Conversation {
	
	// conversation has a list of twams
	List<Twam> twams 
	String title
	User user
	
	static hasMany = [twams:Twam]
	
    static constraints = {
		twams(nullable:true)
    }
	static mapping = {
		user lazy:true // don't load user with each twam.
		twams lazy:false
	}
}
