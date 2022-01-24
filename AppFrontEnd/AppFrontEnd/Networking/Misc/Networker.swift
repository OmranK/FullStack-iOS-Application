//
//  Networker.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/9/21.
//

//import Foundation
//import Combine
//
//// MARK: - Networker Protocol for Dependency Inversion
//protocol NetworkerProtocol {
//    func get<T>(url: URL) -> AnyPublisher<T, Error> where T: Codable
////    func getData(url: URL) -> AnyPublisher<Data, URLError>
////
////    func create<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T: Decodable
//
//}
//
//
//// MARK: - Concrete Implementation of Networking Module
//final class Networker: NetworkerProtocol {
//
//    // Generic GET function
//    func get<T>(url: URL) -> AnyPublisher<T, Error> where T : Codable {
//
//        // Create URLRequest object from the URL.
//        let urlRequest = URLRequest(url: url)
//
//        // Using URLSession's implementation of Combines
//        return URLSession.shared.dataTaskPublisher(for: urlRequest)
//            .map(\.data)
//            .decode(type: T.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//
////    func create<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T : Decodable {
////
////        // Create URLRequest object from the URL.
////        let urlRequest = URLRequest(url: url)
////
////        // Using URLSession's implementation of Combines
////        return URLSession.shared.dataTaskPublisher(for: urlRequest)
////            .map(\.data)
////            .decode(type: T.self, decoder: JSONDecoder())
////            .eraseToAnyPublisher()
////    }
//
////    func getData(url: URL) -> AnyPublisher<Data, URLError> {
////        let urlRequest = URLRequest(url: url)
////
////        return URLSession.shared.dataTaskPublisher(for: urlRequest)
////            .map(\.data)
////            .eraseToAnyPublisher()
////    }
////
////    func sendData<T>(type: T.Type, url: URL) -> AnyPublisher<HTTPURLResponse, Error> where T: Codable{
////        let urlRequest = URLRequest(url: url)
////
////        return URLSession.shared.dataTaskPublisher(for: urlRequest)
////            .mapError { error in return NetworkError.invalidRequest }
////            .tryMap { response, error in
//////                DATA
////            }
////            .eraseToAnyPublisher()
////    }
//}
