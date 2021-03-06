package me.twammer.domain

import org.springframework.validation.ObjectError;

import java.util.Date;
import java.util.List;

import org.springframework.validation.Errors;

import grails.test.*

class TwamIntegrationTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

	void testTwamBasicSave() {
		def user = new User(userName:"Jim", password:"bob")
		
		assertNotNull user.save()
		
		def twam = new Twam(message:"My First Twam", fromWho:"JimBob", shownDatePosted:"1 min ago", actualDatePosted:new Date())
		user.addToTwams(twam)
		
		System.out.println("Twam user:" + twam.user.toString());
		
		// make sure we can save it
		assertNotNull user.id
		
		// try to retrieve it.
		def foundUser = User.get(user.id);
		def foundTwam = foundUser.twamlist[0] // get first twam
		System.out.println("found twam = " + foundTwam.toString());
		assertEquals 'JimBob',foundTwam.fromWho
	}
	
    void testTwamBasicNoUserSave() {
		
		def twam = new Twam(message:"My First Twam", fromWho:"JimBob", timePosted:"1 min ago")
		// make sure we can't save it because there is no User.
		assertNull twam.save()
		
		Errors errors = twam.errors
		// should have errors because user is not nullable.
		assertNotNull errors
		List<ObjectError> errorsList = errors.allErrors
		for (ObjectError objectError: errorsList) {
			System.out.println("error:" + objectError.getDefaultMessage());
		}
		
		// make sure it doesn't have
		assertNull twam.id		
		
    }
}
