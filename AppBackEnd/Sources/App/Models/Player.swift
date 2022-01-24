import Vapor
import Fluent

final class Player: Model, Content {
    
    static let schema = "players"
    
    enum Key {
        static let firstName: FieldKey = "firstName"
        static let lastName: FieldKey = "lastName"
        static let playerNumber: FieldKey = "playerNumber"
        static let height: FieldKey = "height"
        static let position: FieldKey = "position"
        static let currentTeamID: FieldKey = "currentTeamID"
        static let playerPicture: FieldKey = "playerPicture"
    }
    
    enum PlayerPosition: String, Codable {
        case advancer = "Advancer"
        case aimeeter = "Aimeeter"
        case blocker = "Blocker"
        case participer = "Participer"
    }
    
    @ID
    var id: UUID?
    
    @Field(key: Key.firstName)
    var firstName: String
    
    @Field(key: Key.lastName)
    var lastName: String
    
    @Field(key: Key.playerNumber)
    var playerNumber: Int
    
    @Field(key: Key.height)
    var height: Int
    
    @Field(key: Key.position)
    var position: PlayerPosition
    
    @OptionalField(key: Key.playerPicture)
    var playerPicture: String?
    
    @Parent(key: Key.currentTeamID)
    var currentTeam: Team
    
    init() {}
    
    init(id: UUID? = nil, firstName: String, lastName: String, playerNumber: Int,
         height: Int, position: PlayerPosition, teamID: Team.IDValue, playerPicture: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.playerNumber = playerNumber
        self.height = height
        self.position = position
        self.$currentTeam.id = teamID
        self.playerPicture = playerPicture
    }
}
