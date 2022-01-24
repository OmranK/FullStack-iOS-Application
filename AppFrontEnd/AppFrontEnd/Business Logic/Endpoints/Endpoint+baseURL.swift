//
//  EndpointURL.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/9/21.
//

import Foundation

struct Endpoint: APIEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    var url: URL {
        // URLComponents - A structure that parses URLs into and constructs URLs from their constituent parts.
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8080
        components.path = "/api" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}




