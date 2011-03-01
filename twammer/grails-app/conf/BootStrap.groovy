import me.twammer.domain.Twam
import me.twammer.security.SecRole
import grails.converters.JSON


class BootStrap {

    def init = { servletContext ->
		
		JSON.registerObjectMarshaller(Twam) {
			def returnArray = [:]
			returnArray['text'] = it.message
			returnArray['image'] = "image/avatar_image/${it.id}"
			returnArray['user'] = it.fromWho
			returnArray['time'] = it.shownDatePosted
			return returnArray
		}
		
		def userRole = SecRole.findByAuthority('ROLE_USER') ?: new SecRole(authority: 'ROLE_USER').save(failOnError: true)
		def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN').save(failOnError: true)
		
    }
    def destroy = {
    }
	
	

}
