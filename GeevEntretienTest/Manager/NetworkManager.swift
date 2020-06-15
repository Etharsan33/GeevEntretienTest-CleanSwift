//
//  NetworkManager.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    typealias Route = Constants.Network.Route
    
    func request<Parameters: Encodable>(_ route: Route, method: HTTPMethod,
                                    params: Parameters? = nil, encoder: ParameterEncoder? = nil,
                                    completion: @escaping (_ response: AFDataResponse<Data?>) -> ()) {
        
        let path = Constants.Network.baseURL + route.rawValue
        let encoder = (encoder == nil) ? method.getParameterEncoder() : encoder!
        
        AF.request(path,
                   method: method,
                   parameters: params,
                   encoder: encoder)
            .validate()
            .response { response in
                completion(response)
            }
    }
}

// MARK: - Error
extension NetworkManager {
    
    enum NetworkError: Error {
       case noData
    }
}

// MARK: - HTTPMethod
extension HTTPMethod {
    func getParameterEncoder() -> ParameterEncoder {
        switch self {
        case .get:
            return URLEncodedFormParameterEncoder.default
        case .post:
            return JSONParameterEncoder.default
        default:
            return JSONParameterEncoder.default
        }
    }
}

