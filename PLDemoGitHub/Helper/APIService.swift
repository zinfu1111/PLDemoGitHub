//
//  APIService.swift
//  PLDemoGitHub
//
//  Created by 連振甫 on 2021/9/18.
//

import Foundation


private let apiKey = ""
private let baseURL = "https://api.github.com"

enum APIRoute {
    
    case users
    
    var path:String{
        switch self {
        case .users:
            return "/users"
        }
    }
    
}

enum HTTPMethod:String {
    case get     = "GET"
    case post    = "POST"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol APIService {
    var route:APIRoute { get set }
}

extension APIService {
    
    mutating func sendRequest<T>(addPath:String? = nil,body:Data? = nil,method:HTTPMethod,reponse:T.Type ,completion: @escaping (Result<T,Error>)->Void) where T:Decodable {
        
        let url = URL(string: "\(baseURL)\(route.path)\(addPath == nil ? "" : addPath!)")
        var request = URLRequest(url: url!)
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.httpMethod = method.rawValue
        
        if let body = body {
            request.httpBody = body
            
            let json = String(data: body, encoding: .utf8)
            print("[API] request:\(json)")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let json = String(data: data, encoding: .utf8)
                //有印出來
                print("[API][\(url)] response:\(json)")
                do {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(reponse, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
        
    }
}

extension Encodable {
    func encodeToData() -> Data? {
        
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.string(from: Date())
        encoder.dateEncodingStrategy = .formatted(formatter)
        return try? encoder.encode(self)
        
    }
}
