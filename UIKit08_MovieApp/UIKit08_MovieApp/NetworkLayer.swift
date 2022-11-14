//
//  NetworkLayer.swift
//  UIKit08_MovieApp
//
//  Created by 이준형 on 2022/11/11.
//

import Foundation

enum MovieApiType {
    case onlyURL(urlString: String)
    case searchMovie(queries: [URLQueryItem])
}

enum MovieApiError: Error {
    case badURL
}


class NetworkLayer {
    // only url or url + param
    
    typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error:Error?) -> Void
    
    func request(type: MovieApiType, completion: @escaping NetworkCompletion) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let request = try buildRequest(type: type)
            
            session.dataTask(with: request) { data, response, error in
                print( (response as! HTTPURLResponse).statusCode )
                completion(data, response, error)
            }.resume()  // datatask는 반드시 실행해야함
            session.finishTasksAndInvalidate()
        } catch {
            print(error)
        }
    }
    
    
    func buildRequest(type: MovieApiType) throws -> URLRequest {    // 옵셔널 말고 throw로 구현한 형태
        switch type {
        case .onlyURL(urlString: let urlString):
            guard let hasURL = URL(string: urlString) else {
                throw MovieApiError.badURL
            }
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            return request
            
            
        case .searchMovie(queries: let queries):
            var components = URLComponents(string: "https://itunes.apple.com/search")
            components?.queryItems = queries
            
            guard let hasUrl = components?.url else {
                throw MovieApiError.badURL
            }
            var request = URLRequest(url: hasUrl)
            request.httpMethod = "GET"
            return request
        }
        
    }
}
