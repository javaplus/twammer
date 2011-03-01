package me.twammer.domain

import grails.plugins.springsecurity.Secured;

class ConversationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [conversationInstanceList: Conversation.list(params), conversationInstanceTotal: Conversation.count()]
    }
	@Secured(['ROLE_USER'])
    def create = {
        def conversationInstance = new Conversation()
        conversationInstance.properties = params
        return [conversationInstance: conversationInstance]
    }
	@Secured(['ROLE_USER'])
    def save = {
		
        def conversationInstance = new me.twammer.domain.Conversation(params)
		// get User object and set the twam on it before saving the TWAM
		// have to do this because of this:http://jira.codehaus.org/browse/GRAILS-2986
		def user = springSecurityService.getCurrentUser()
		
		println("user found=" + user)
		user.addToConversations(conversationInstance)
		if(user.hasErrors()){
			println user.errors.each{println it}
		}
        if (conversationInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'conversation.label', default: 'Conversation'), conversationInstance.id])}"
            redirect(action: "show", id: conversationInstance.id)
        }
        else {
            render(view: "create", model: [conversationInstance: conversationInstance])
        }
    }

    def show = {
        def conversationInstance = Conversation.get(params.id)
        if (!conversationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'conversation.label', default: 'Conversation'), params.id])}"
            redirect(action: "list")
        }
        else {
            [conversation: conversationInstance]
        }
    }

	@Secured(['ROLE_USER'])
    def edit = {
        def conversationInstance = Conversation.get(params.id)
        if (!conversationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'conversation.label', default: 'Conversation'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [conversationInstance: conversationInstance]
        }
    }

	@Secured(['ROLE_USER'])
    def update = {
        def conversationInstance = Conversation.get(params.id)
        if (conversationInstance) {
			// verify user is the owner
			if(!userIsOwner(conversationINstance)){
				// if not owner do something.
				flash.message = "${message(code: 'default.not.owner', args: [message(code: 'conversation.label', default: 'Conversation')])}"
				render(view: "create", model: [conversationInstance: conversationInstance])
			}
            if (params.version) {
                def version = params.version.toLong()
                if (conversationInstance.version > version) {
                    
                    conversationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'conversation.label', default: 'Conversation')] as Object[], "Another user has updated this Conversation while you were editing")
                    render(view: "edit", model: [conversationInstance: conversationInstance])
                    return
                }
            }
            conversationInstance.properties = params
            if (!conversationInstance.hasErrors() && conversationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'conversation.label', default: 'Conversation'), conversationInstance.id])}"
                redirect(action: "show", id: conversationInstance.id)
            }
            else {
                render(view: "edit", model: [conversationInstance: conversationInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'conversation.label', default: 'Conversation'), params.id])}"
            redirect(action: "list")
        }
    }

	@Secured(['ROLE_USER'])
    def delete = {
        def conversationInstance = Conversation.get(params.id)
        if (conversationInstance) {
			// verify user is the owner
			if(!userIsOwner(conversationINstance)){
				// if not owner do something.
				flash.message = "${message(code: 'default.not.owner', args: [message(code: 'conversation.label', default: 'Conversation')])}"
				render(view: "create", model: [conversationInstance: conversationInstance])
			}
            try {
                conversationInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'conversation.label', default: 'Conversation'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'conversation.label', default: 'Conversation'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'conversation.label', default: 'Conversation'), params.id])}"
            redirect(action: "list")
        }
    }
	// pass through
	def searchByUser = {}
	// search for the conversations linked to a user.
	def searchByUserResults = {
		
		def conversations = null
		// get the user name from params to find the user
		def user = User.findByUsernameIlike(params.username)
		
		if(user){
			conversations = Conversation.findAllByUser(user)
			if(conversations){
				println("found ${conversations.size()} converstaions");
				for (twam in conversations.twams) {
					println "twam id = ${twam.id}"
				}
				//conversations[0].twams.each{arg -> println arg.id}
			}
			
		}else{
			flash.message = 'conversation.not.found.by.user.message'
			flash.args = [params.username]
			flash.defaultMessage = 'No Conversations found!'
		}
		
		return [name:params.username,conversations:conversations]
	}
	
	def addTwam(){
		
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
