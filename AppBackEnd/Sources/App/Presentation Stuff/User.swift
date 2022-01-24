//
//  File.swift
//  
//
//  Created by Omran Khoja on 12/8/21.
//

import Fluent
import Vapor


final class User: Model {
    
    static let schema = "users"
    
    @ID
    var id: UUID?
    
    @Field(key: "firstName")
    var firstName: String
    
    @Field(key: "lastName")
    var lastName: String
    
    init() {}
    
    init(id: UUID? = nil, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension User: Content{}

