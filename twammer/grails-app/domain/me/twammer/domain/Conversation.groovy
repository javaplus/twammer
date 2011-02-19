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

	static hasMany = [twams:Twam]
	static belongsTo = [user:User]
	
    static constraints = {
		twams()
    }
}
