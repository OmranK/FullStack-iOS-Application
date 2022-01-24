//
//  NetworkingProtocol.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/10/21.
//

import Foundation
import Combine

// MARK: - Networker Protocol for Dependency Inversion

protocol NetworkingProtocol {
    func dispatch<T: Codable>(request: URLRequest) -> AnyPublisher<T, NetworkRequestError>
}

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}








// https://www.swiftbysundell.com/articles/different-flavors-of-type-erasure-in-swift/
// https://www.donnywals.com/changing-a-publishers-failure-type-in-combine/

// https://www.youtube.com/watch?v=XWoNjiSPqI8


//    associatedtype
//    typealias Handler = (URLRequest) -> AnyPublisher<T, NetworkError>
//    associatedtype NetworkError: LocalizedError, Equatable



//struct AnyNetworkingProtocol<T: Codable> {
//    private let _dispatch: (_ request: URLRequest) -> AnyPublisher<T, Error>
//
//
//    init<Model: NetworkingProtocol>(_ model: Model)  {
//        self._dispatch = model.dispatch
//    }
//
//    func dispatch<T: Codable>(request: URLRequest) -> AnyPublisher<T, NetworkError> {
//        return _dispatch(request)
//    }
//}
//
//class _AnyNetworkingProtocolBase<NetworkRequestError>: NetworkingProtocol {
//
//    @available(*, unavailable)
//    init() {}
//
//    func dispatch<T: Codable>(request: URLRequest) -> AnyPublisher<T, NetworkRequestError> {
//        fatalError("Method has to be overriden this is an abstract class")
//    }
//}
//
//
//protocol Request {
//    associatedtype Response
//    associatedtype NetworkError: Error
//
//    typealias Handler = (Result<Response, Error>) -> Void
//
//    func perform(then handler: @escaping Handler)
//}
//
//// This will let us wrap a Request protocol implementation in a
//// generic has the same Response and Error types as the protocol.
//struct AnyRequest<Response, NetworkError: Error> {
//    typealias Handler = (Result<Response, Error>) -> Void
//
//    let perform: (@escaping Handler) -> Void
//    let handler: Handler
//}
//
//// This will let us wrap a Request protocol implementation in a
//// generic has the same Response and Error types as the protocol.
//struct AnyNetworkRequest<NetworkError: LocalizedError> {
//    typealias Handler = (Error>) -> Void
//
//    let perform: (@escaping Handler) -> Void
//    let handler: Handler
//}
