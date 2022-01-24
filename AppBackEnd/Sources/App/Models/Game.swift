import Vapor
import Fluent

final class Game: Model, Content {
    
    static let schema = "games"
    
    enum Key {
        static let date: FieldKey = "date"
        static let location: FieldKey = "location"
        static let homeTeamID: FieldKey = "homeTeamID"
        static let awayTeamID: FieldKey = "awayTeamID"
    }
    
    @ID var id: UUID?
    
    @Field(key: Key.date)
    var date: Date
    
    @Field(key: Key.location)
    var location: String
    
    @Parent(key: Key.homeTeamID)
    var homeTeam: Team
    
    @Parent(key: Key.awayTeamID)
    var awayTeam: Team
    
    init() {}
    
    init(id: UUID? = nil, date: Date, location: String, homeTeamID: Team.IDValue, awayTeamID: Team.IDValue) {
        self.id = id
        self.date = date
        self.location = location
        self.$homeTeam.id = homeTeamID
        self.$awayTeam.id = awayTeamID
    }
}

extension Date {
    init(_ iso8601DateString:String) {
        let formatter = ISO8601DateFormatter()
        let datetime = formatter.date(from: iso8601DateString)!
        self.init(timeInterval: 0, since: datetime)
    }
    
    static func isoString(year: Int, month: Int, day: Int, hour: Int, min: Int, second: Int) -> String {
        return "\(year)-\(month)-\(day)T\(hour):\(min):\(second)Z"
    }
}
