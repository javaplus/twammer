package me.twammer.domain

import grails.plugins.springsecurity.Secured;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import grails.converters.*;

class TwamController {
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

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
        return [twamInstance: twamInstance]
    }
	
	@Secured(['ROLE_USER'])
    def save = {
		if(request instanceof MultipartHttpServletRequest)
		{
			println("This is a Multipart Request!")
		}
        def twamInstance = new Twam(params)
		// get User object and set the twam on it before saving the TWAM
		// have to do this because of this:http://jira.codehaus.org/browse/GRAILS-2986
		def user = User.get(params["user.id"])
		println("user found=" + user)
		user.addToTwams(twamInstance)
		if(user.hasErrors()){
			println user.errors.each{println it}
		}
		// get image:
		// Get the avatar file from the multi-part request 
		def f = request.getFile('avatar')
		// List of OK mime-types 
		def okcontents = ['image/png', 'image/jpeg', 'image/gif', 'image/pjpeg']
		println("content type = ${f.getContentType()}") 
		if (! okcontents.contains(f.getContentType())) {
			println("Avatar must be one of: ${okcontents}")
			 flash.message = "Avatar must be one of: ${okcontents}" 
			 // render(view:'select_avatar', model:[user:user]) 
			 return; 
		}
		twamInstance.avatar = f.getBytes()
		twamInstance.avatarType = f.getContentType()
		log.info("File uploaded: " + twamInstance.avatarType)
		
        if (twamInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'twam.label', default: 'Twam'), twamInstance.id])}"
            redirect(action: "show", id: twamInstance.id)
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
        def twamInstance = Twam.get(params.id)
        if (twamInstance) {
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
			println("No TWAMS Found!")
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
			println("No TWAMS Found!")
			flash.message = 'twam.not.found.by.user.message'
			flash.args = [params.username]
			flash.defaultMessage = 'No Twams found!'
		}
		def converter = twams as JSON
		
		def jsonString = converter.toString()
		println("JSON list= " + jsonString)
		
		converter = twams[0] as JSON		
		
		println("JSON = " + converter.toString())
		render jsonString
		
		
		}
	
}
