package me.twammer.ui

import me.twammer.domain.Twam;

class PhotoUploadCommand {
	byte[] photo
	String twamid
	}

class ImageController {

	def avatar_image = {
		println "in avatar_image id=${params.id}"
		def avatarTwam = Twam.get(params.id)
		if (!avatarTwam || !avatarTwam.avatar || !avatarTwam.avatarType) {
		  response.sendError(404)
		  return;
		}
		response.setContentType(avatarTwam.avatarType)
		response.setContentLength(avatarTwam.avatar.size())
		OutputStream out = response.getOutputStream();
		out.write(avatarTwam.avatar);
		out.close();
	  }
}
