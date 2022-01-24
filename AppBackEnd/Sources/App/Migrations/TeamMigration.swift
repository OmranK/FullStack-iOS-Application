import Fluent

extension Team {
    
    struct Create: Migration {
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Team.schema)
                .id()
                .field(Team.Key.name, .string, .required)
                .field(Team.Key.wins, .int, .required)
                .field(Team.Key.losses, .int, .required)
                .field(Team.Key.teamPicture, .string)
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Team.schema).delete()
        }
    }
}
