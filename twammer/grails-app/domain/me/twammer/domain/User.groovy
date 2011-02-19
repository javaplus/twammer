package me.twammer.domain

import me.twammer.security.SecUser;

/*
 * This class represents the user that actually does the posting.
 * Not who the post says it's from.
 * The user information may not even be visible to anyone, but will
 * be tracked to each post. (At least thats the plan for now)
 */
class User extends SecUser{
	
	String email
	List<Twam> twams
	List<Conversation> conversations
	
	// has many twams
	static hasMany = [twams: Twam, conversations:Conversation]


    static constraints = {
		// create a validator to check that there's no user name like it with different case
		// Ilike = like ignore case
		username(size:3..20,unique:true,matches:"[a-zA-Z0-9]+",nullable:false,validator: {
              return !User.findByUsernameIlike(it)
            })
		password(nullable:false)
		email(email:true)
		twams()
		conversations()
    }
	
	String toString(){
		"User [${username}]"
	}
}
