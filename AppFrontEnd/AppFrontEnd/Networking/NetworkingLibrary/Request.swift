//
//  NetworkRequest.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/10/21.
//

import Foundation
import Combine

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

struct Request<ResourceType> where ResourceType: Codable {
    var method: HTTPMethod = .get
    var contentType: String = "application/json"
    var body: ResourceType? = nil
    var headers: [String: String]? = nil
    typealias ReturnType = Codable
}

extension Request {
    /// Transforms a Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(data: body)
        request.allHTTPHeaderFields = headers
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        return request
    }
    
    /// Serializes an HTTP dictionary to a JSON Data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    private func requestBodyFrom(data: ResourceType?) -> Data? {
        guard let data = data else { return nil }
        guard let httpBody = try? JSONEncoder().encode(data) else {
            return nil
        }
        return httpBody
    }
}


//public protocol Request {
//    var method: HTTPMethod { get }
//    var contentType: String { get }
//    var body: [String: Any]? { get }
//    var headers: [String: String]? { get }
//    associatedtype ReturnType: Codable
//}

//extension Request {
//    // Defaults
//    var method: HTTPMethod { return .get }
//    var contentType: String { return "application/json" }
//    var queryParams: [String: String]? { return nil }
//    var body: [String: Any]? { return nil }
//    var headers: [String: String]? { return nil }
//}
