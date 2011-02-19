package me.twammer.domain

class Profile {
	
	String fullName
	String website
	byte[] photo
	
	static belongsTo = []
	
    static constraints = {
    }
}
