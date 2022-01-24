//
//  File.swift
//  
//
//  Created by Omran Khoja on 12/9/21.
//

import XCTVapor
import App

extension Application {
    static func testable() throws -> Application {
        
        let app = Application(.testing)
        do {
            try configure(app)
            try app.autoRevert().wait()
            try app.autoMigrate().wait()
        } catch {
            app.logger.critical("\(error)")
        }
        
        return app
        
    }
}
