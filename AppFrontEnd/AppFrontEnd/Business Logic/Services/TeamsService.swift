//
//  TeamsService.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/9/21.
//

import Foundation
import Combine

// Prototype for
protocol TeamsServiceProtocol: AnyObject {
    var networker: NetworkingProtocol { get }
    func getTeams() -> AnyPublisher<[Team], NetworkRequestError>
    func getTeam(id: UUID) -> AnyPublisher<Team, NetworkRequestError>
    func create(_ team: Team) -> AnyPublisher<Team, NetworkRequestError>
    func getRoster(teamID: UUID) -> AnyPublisher<[Player], NetworkRequestError>
//    func setTeamPhoto()  -> AnyPublisher<Team, Error>
}

final class TeamsService: TeamsServiceProtocol {
    
    
    let networker: NetworkingProtocol
    
    init(networker: NetworkingProtocol = NetworkDispatcher()) {
        self.networker = networker
    }
    
    func getTeams() -> AnyPublisher<[Team], NetworkRequestError> {
        let endpoint = Endpoint.teams
        let request = Request<[Team]>(method: .get)
        guard let urlRequest = request.asURLRequest(url: endpoint.url) else {
            return Fail(outputType: [Team].self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        return networker.dispatch(request: urlRequest)
    }
    
    func getTeam(id: UUID) -> AnyPublisher<Team, NetworkRequestError> {
        let endpoint = Endpoint.team(id: id)
        let request = Request<Team>(method: .get)
        guard let urlRequest = request.asURLRequest(url: endpoint.url) else {
            return Fail(outputType: Team.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        return networker.dispatch(request: urlRequest)
    }
    
    func create(_ team: Team) -> AnyPublisher<Team, NetworkRequestError> {
        let endpoint = Endpoint.teams
        let request = Request<Team>(method: .post, body: team)
        guard let urlRequest = request.asURLRequest(url: endpoint.url) else {
            return Fail(outputType: Team.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        return networker.dispatch(request: urlRequest)
    }
    
    
    func getRoster(teamID: UUID) -> AnyPublisher<[Player], NetworkRequestError> {
        let endpoint = Endpoint.teamRoster(teamID: teamID)
        let request = Request<[Player]>(method: .get)
        guard let urlRequest = request.asURLRequest(url: endpoint.url) else {
            return Fail(outputType: [Player].self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        return networker.dispatch(request: urlRequest)
    }
    
//    enum TeamPictureError: Error {
//        case dataInvalid
//    }
    
//    func setTeamPhoto(id: UUID) -> AnyPublisher<Team, Error> {
//        let endpoint = Endpoint.teamImage(id: id)
//        return networker.sendData(id)
//
//    }
//
//
//    func getTeamPictureData(urlString: String) -> AnyPublisher<Data, Error> {
//        guard let url = URL(string: urlString) else {
//            return Fail<Data, Error>(error: NetworkError.invalidURL).eraseToAnyPublisher()
//        }
//
//        return networker.getData(url: url)
//            .mapError { _ in TeamPictureError.dataInvalid }
//            .eraseToAnyPublisher()
//    }
    
    
    //    func  getTeamPhoto(id: UUID) -> AnyPublisher<String, NetworkRequestError> {
    //        let endpoint = Endpoint.teamImage(id: id)
    //        let request = Request<String>(method: .get)
    //        guard let urlRequest = request.asURLRequest(url: endpoint.url) else {
    //            return Fail(outputType: Team.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
    //        }
    //        return networker.dispatch(request: urlRequest)
    //    }
    //
}
