import Fluent

extension Player {
    
    struct Create: Migration {
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Player.schema)
                .id()
                .field(Player.Key.firstName, .string, .required)
                .field(Player.Key.lastName, .string, .required)
                .field(Player.Key.playerNumber, .int, .required)
                .field(Player.Key.height, .int, .required)
                .field(Player.Key.position, .string, .required)
                .field(Player.Key.playerPicture, .string)
                .field(Player.Key.currentTeamID, .uuid, .required, .references(Team.schema, "id"))
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Player.schema).delete()
        }
    }
    
}
