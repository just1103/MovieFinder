//
//  APIRequest.swift
//  MovieFinder
//
//  Created by Hyoju Son on 2022/09/01.
//

import Foundation
import RxSwift

protocol APIRequest {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var parameters: [String: String] { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}

extension APIRequest {
    var url: URL? {  // direct dispatch
        var urlComponents = URLComponents(string: "\(baseURL)\(path)")
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        return urlComponents?.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.description
        headers.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }
        urlRequest.httpBody = body

        return urlRequest
    }
}

protocol Gettable: APIRequest {
    func fetchData() -> Observable<SearchResultDTO>
}

extension Gettable {
    var method: HttpMethod {
        return .get
    }
    
    var body: Data? {
        nil
    }
}

enum HttpMethod {
    case get
    case post
    case put
    case delete
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}
