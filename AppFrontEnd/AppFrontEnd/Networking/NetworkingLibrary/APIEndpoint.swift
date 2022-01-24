//
//  Endpoint.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/9/21.
//

import Foundation

public protocol APIEndpoint {
    var path: String { get }
//    var queryItems: [URLQueryItem] { get }
    var url: URL { get }
}
