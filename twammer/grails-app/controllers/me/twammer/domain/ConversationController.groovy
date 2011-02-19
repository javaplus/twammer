package me.twammer.domain

class ConversationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [conversationInstanceList: Conversation.list(params), conversationInstanceTotal: Conversation.count()]
    }

    def create = {
        def conversationInstance = new Conversation()
        conversationInstance.properties = params
        return [conversationInstance: conversationInstance]
    }

    def save = {
        def conversationInstance = new Conversation(params)
		// get User object and set the twam on it before saving the TWAM
		// have to do this because of this:http://jira.codehaus.org/browse/GRAILS-2986
		def user = User.get(params["user.id"])
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
            [conversationInstance: conversationInstance]
        }
    }

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

    def update = {
        def conversationInstance = Conversation.get(params.id)
        if (conversationInstance) {
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

    def delete = {
        def conversationInstance = Conversation.get(params.id)
        if (conversationInstance) {
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
}
