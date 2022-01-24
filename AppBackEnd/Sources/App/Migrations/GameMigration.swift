import Fluent

extension Game {
    
    struct Create: Migration {
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Game.schema)
                .id()
                .field(Game.Key.date, .datetime, .required)
                .field(Game.Key.location, .string, .required)
                .field(Game.Key.homeTeamID, .uuid, .required, .references(Team.schema, "id"))
                .field(Game.Key.awayTeamID, .uuid, .required, .references(Team.schema, "id"))
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Game.schema).delete()
        }
    }
}

