package me.twammer.domain

import grails.test.*

class ConversationIntegrationTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testConversationSave() {
		
		// create a new User cause a conversation belongs to a user.
		def user = new User(userName:"jim", password:"bob")
		assertNotNull user.save()
		def message = "My First Twam in a convseration"
		def twam = new Twam(message:message, fromWho:"JimBob", shownDatePosted:"1 min ago", actualDatePosted:new Date())
		
		def conversation = new Conversation(title:"My First Conversation")
		conversation.addToTwams(twam)
		user.addToConversations(conversation)
		
		def foundUser = user.get(user.id)
		assertNotNull foundUser
		def foundConversation = user.conversations[0]
		assertNotNull foundConversation
		assertEquals message, foundConversation.twams[0].message
		

    }
}
