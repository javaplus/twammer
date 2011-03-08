package me.twammer.domain

import grails.plugins.springsecurity.Secured;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import grails.converters.*;

class TwamController {
	
	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [twamInstanceList: Twam.list(params), twamInstanceTotal: Twam.count()]
    }

	@Secured(['ROLE_USER'])
    def create = {
        def twamInstance = new Twam()
        twamInstance.properties = params
		// check if we have a Conversation id.
		if(params.id){
			def conversation = Conversation.get(params.id)
			return [twamInstance: twamInstance, conversation:conversation]
		}
        return [twamInstance: twamInstance]
    }
	
	@Secured(['ROLE_USER'])
	def create_ajax = {
		def twamInstance = new Twam()
		twamInstance.properties = params
		// check if we have a Conversation id.
		if(params.id){
			def conversation = Conversation.get(params.id)
			return [twamInstance: twamInstance, conversation:conversation]
		}
		return [twamInstance: twamInstance]
	}
	
	@Secured(['ROLE_USER'])
    def save = {
		if(request instanceof MultipartHttpServletRequest)
		{
			log.debug("This is a Multipart Request!")
		}
        def twamInstance = new Twam(params)
		// set date
		twamInstance.actualDatePosted = new Date()
		// get image:
		// Get the avatar file from the multi-part request 
		def f = request.getFile('avatar')
		// List of OK mime-types 
		def okcontents = ['image/png', 'image/jpeg', 'image/gif', 'image/pjpeg']
		log.debug("content type = ${f.getContentType()}") 
		if (! okcontents.contains(f.getContentType())) {
			log.debug("Avatar must be one of: ${okcontents}")
			 flash.message = "Avatar must be one of: ${okcontents}" 
			 // render(view:'select_avatar', model:[user:user]) 
			 return; 
		}
		twamInstance.avatar = f.getBytes()
		twamInstance.avatarType = f.getContentType()
		log.info("File uploaded: " + twamInstance.avatarType)
		
		// add this twam to a conversation if we have a conversation id.
		def conversation = null;
		if(params.conversation_id){
			conversation = Conversation.get(params.conversation_id)
			log.debug("Saving Twam to conversation with id ${params.conversation_id}")
			
			conversation.addToTwams(twamInstance)
		}
		
		// get User object and set the twam on it before saving the TWAM
		// have to do this because of this:http://jira.codehaus.org/browse/GRAILS-2986
		def user = springSecurityService.currentUser
		log.debug("User with id=${user.id}")
		user = User.get(user.id)
		log.debug("user found=" + user)
		user.addToTwamlist(twamInstance)
		if(params.conversation_id){
			if(conversation.save(flush: true)){
				log.debug("conversation save with twam success!!")
			}
		}
		if(user.hasErrors()){
			user.errors.each{log.debug it}
		}else{
			user.save(flush:true)
		}
        if (twamInstance.save(flush: true)) {
			
        	flash.message = "${message(code: 'twam.created.conversation.message', args: [message(code: 'twam.label', default: 'Twam')])}"
			redirect(uri:"/conversation/show/${conversation.id}")
		
        }
        else {
            render(view: "create", model: [twamInstance: twamInstance])
        }
		
		
    }

    def show = {
        def twamInstance = Twam.get(params.id)
        if (!twamInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'twam.label', default: 'Twam'), params.id])}"
            redirect(action: "list")
        }
        else {
            [twamInstance: twamInstance]
        }
    }

	@Secured(['ROLE_USER'])
    def edit = {
        def twamInstance = Twam.get(params.id)
        if (!twamInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'twam.label', default: 'Twam'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [twamInstance: twamInstance]
        }
    }

	@Secured(['ROLE_USER'])
    def update = {
        def twamInstance = Twam.get(params.id)
        if (twamInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (twamInstance.version > version) {
                    
                    twamInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'twam.label', default: 'Twam')] as Object[], "Another user has updated this Twam while you were editing")
                    render(view: "edit", model: [twamInstance: twamInstance])
                    return
                }
            }
            twamInstance.properties = params
            if (!twamInstance.hasErrors() && twamInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'twam.label', default: 'Twam'), twamInstance.id])}"
                redirect(action: "show", id: twamInstance.id)
            }
            else {
                render(view: "edit", model: [twamInstance: twamInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'twam.label', default: 'Twam'), params.id])}"
            redirect(action: "list")
        }
    }

	@Secured(['ROLE_USER'])
    def delete = {
		log.debug("in delete for id=${params.id}")
        def twamInstance = Twam.get(params.id)
		def currentUser = springSecurityService.getCurrentUser()
		if (twamInstance) {
			log.debug("We do have a twam")
			// validate that the current user is the user that owns this twam
			if(currentUser.id != twamInstance.user.id){
				// cannot delete someone elses twam
				log.debug("User deleting does NOT own twam!")
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'twam.label', default: 'Twam'), params.id])}"
			}else{
				// if there's a conversation that this twam is tied to... remove it first.
				def conversation = twamInstance.conversation
				if(conversation){
					log.debug("We have a conversation!")
				}
				conversation.removeFromTwams(twamInstance).save()
				try {
                	twamInstance.delete(flush: true)
                	flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'twam.label', default: 'Twam'), params.id])}"
                	redirect(action: "list")
            	}
            	catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'twam.label', default: 'Twam'), params.id])}"
                redirect(action: "show", id: params.id)
            	}
			}
        }
        else {
            flash.message = "'default.not.found.message', args: [message(code: 'twam.label', default: 'Twam'), params.id])}"
            redirect(action: "list")
        }
    }
	
	// get list of twams for a user: 
	def results = {
		def twams = null
		def user = User.findByUsernameIlike(params.username)
		if(user){
			twams = Twam.findAllByUser(user)
		}
		if(!twams){
			log.debug("No TWAMS Found!")
			flash.message = 'twam.not.found.by.user.message'
			flash.args = [params.username]
			flash.defaultMessage = 'No Twams found!'
		}
		return [twams:twams,name:params.username]
		
		
		}
	// passes through to search.gsp
	def search = {
		
	}
	
	// get list of twams for a user:
	def searchByUser= {
		def twams = null
		def user = User.findByUsernameIlike(params.username)
		if(user){
			twams = Twam.findAllByUser(user)
		}
		if(!twams){
			log.debug("No TWAMS Found!")
			flash.message = 'twam.not.found.by.user.message'
			flash.args = [params.username]
			flash.defaultMessage = 'No Twams found!'
		}
		def converter = twams as JSON
		
		def jsonString = converter.toString()
		log.debug("JSON list= " + jsonString)
		
		converter = twams[0] as JSON		
		
		log.debug("JSON = " + converter.toString())
		render jsonString
		
		
		}
	// get twams for a conversation
	def conversation={
		log.debug "in conversation on TwamController for id=${params.id}"
		def conversation = Conversation.get(params.id)
		
		[conversation:conversation]
		
		}
	
	def userIsOwner(Conversation conversation){
		currentUser = springSecurityService.getCurrentUser()
		owner = conversation.user
		if(owner.id == currentUser.id){
			return true
		}else{
			return false
		}
	}
	
}
