import Vapor
import Fluent

final class Team: Model, Content {
    
    static let schema = "teams"
    
    enum Key {
        static let name: FieldKey = "name"
        static let wins: FieldKey = "wins"
        static let losses: FieldKey = "losses"
        static let teamPicture: FieldKey = "teamPicture"
    }
    
    @ID
    var id: UUID?
    
    @Field(key: Key.name)
    var name: String
    
    @Field(key: Key.wins)
    var wins: Int
    
    @Field(key: Key.losses)
    var losses: Int
    
    @OptionalField(key: Key.teamPicture)
    var teamPicture: String?
    
    @Children(for: \Player.$currentTeam)
    var players: [Player]
    
    @Children(for: \Game.$homeTeam)
    var homeGames: [Game]
    
    @Children(for: \Game.$awayTeam)
    var awayGames: [Game]
    

    init() {}
    
    init(id: UUID? = nil, name: String, wins: Int = 0, losses: Int = 0, teamPicture: String? = nil) {
        self.id = id
        self.name = name
        self.wins = wins
        self.losses = losses
        self.teamPicture = teamPicture
    }
    
}
