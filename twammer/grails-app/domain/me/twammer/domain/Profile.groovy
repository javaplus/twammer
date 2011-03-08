package me.twammer.domain

class Profile {
	
	String fullName
	String website
	String bio
	byte[] photo
	
	static belongsTo = User
	
    static constraints = {
		website(url:true)
    }
}
