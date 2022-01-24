//
//  File.swift
//  
//
//  Created by Omran Khoja on 12/8/21.
//

import Vapor
import Fluent

final class UsersAPIController {
    
    func getAllUsersHandler(_ req: Request) -> EventLoopFuture<[User]> {
        User.query(on: req.db).all()
    }
    
    func getUserHandler(_ req: Request) -> EventLoopFuture<User> {
        User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    func updateUserHandler(_ req: Request) throws -> EventLoopFuture<User> {
        let updatedUser = try req.content.decode(User.self)
        return User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
                user.firstName = updatedUser.firstName
                user.lastName = updatedUser.lastName
                return user.save(on: req.db).map {
                    user
                }
            }
    }
    
    func deleteUserHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
                user.delete(on: req.db)
                    .transform(to: .noContent)
            }
    }
    
    //  Because this uses key paths, the compiler can enforce type-safety on the properties and filter terms. This prevents run-time issues caused by specifying an invalid column name or invalid type to filter on. Fluent uses the property wrapper’s projected value, instead of the value itself.
    //  As described in the Swift documentation, “a property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property”.
    func searchUsersHandler(_ req: Request) throws -> EventLoopFuture<[User]> {
        guard let searchTerm = req.query[String.self, at: "term"] else {
                    throw Abort(.badRequest)
                }
        return User.query(on: req.db).group(.or) { or in
            or.filter(\.$firstName == searchTerm)
            or.filter(\.$lastName == searchTerm)
        }.all()
    }
    
//    app.post("api", "users") { req -> EventLoopFuture<User> in
//        let user = try req.content.decode(User.self)
//        return user.save(on: req.db).map {
//            user
//        }
//    }
    
}

extension UsersAPIController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        
        //Set the main path for the whole API
        let usersRoute = routes.grouped("api", "users")
        
        usersRoute.get(use: getAllUsersHandler)
        usersRoute.get(":userID",  use: getUserHandler)
        usersRoute.put(":userID",  use: updateUserHandler)
        usersRoute.delete(":userID",  use: deleteUserHandler)
        
//        routes.delete("api", "users", ":userID",  use: deleteUserHandler)
    }
}
