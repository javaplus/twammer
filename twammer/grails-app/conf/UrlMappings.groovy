class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller:"conversation", action:"list")
		//"/"("views/index.gsp")
		"500"(view:'/error')
		
		"/login/$action?"(controller: "login")
		"/logout/$action?"(controller: "logout")
		"/twams/search/$username?"(controller:"twam", action:"searchByUser")
	}
}
