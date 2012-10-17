package twammer

import me.twammer.domain.Conversation;

class TwamSecTagLib {
	
	def springSecurityService
	
	
	def userIsOwner = { attrs, body ->
		def currentUser = springSecurityService.getCurrentUser()
		if(currentUser){
			log.debug("current user = ${currentUser.username}")
		}
		
		def owner = attrs['user']
		if(owner){
			log.debug("owner = ${owner.username}")
		}
		// if we have a current user and owner and the ids are the same
		if((currentUser && owner) && (owner.id == currentUser.id)){
			out << body()
		}
	}

}
