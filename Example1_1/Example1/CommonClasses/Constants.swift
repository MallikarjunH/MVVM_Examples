//
//  Constants.swift
//  Example1
//
//  Created by EOO61 on 02/02/24.
//

import Foundation


struct API {
    
    static let baseAPI = "https://jsonplaceholder.typicode.com/"
    
    //Other API:-
    static let ValidateLogin =  API.baseAPI + "ValidateLogin"
    static let getAllPosts =  API.baseAPI + "posts"
}

struct AlertMessages {
    
    static let somethingWentWrong = "Something went wrong"
    static let sessionTimedOut = "Your session has timed out. Please login again"
}
