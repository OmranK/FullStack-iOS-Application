import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    // MARK: - Register API routes Here
    
    // Players API
    let playersAPI = PlayersAPI()
    try app.register(collection: playersAPI)
    
    // Teams API
    let teamsAPI = TeamsAPI()
    try app.register(collection: teamsAPI)
    
    // Games API
    let gamesAPI = GamesAPI()
    try app.register(collection: gamesAPI)
}
