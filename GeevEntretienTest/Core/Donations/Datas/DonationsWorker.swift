//
//  DonationsWorker.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 11/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

// https://stage.geev.fr/api/v0.19/olditems?location=44.837789,-0.5791799999999512&type=donation&presentation=summary&distance=50000&keywords=Table

import Foundation

struct DonationsWorker: DonationsWorkerProtocol {
    
    struct DonationParameters: Encodable {
        let page: Int = 1
        let pageLength: Int = 20
        let location: String
        let type: String = "donation"
        let presentation: String = "summary"
        let distance: Double
        let keywords: String?
        
        enum CodingKeys: String, CodingKey {
            case page
            case pageLength = "page_length"
            case location
            case type
            case presentation
            case distance
            case keywords
        }
    }
    
    func getDonations(keywords: String?,
                      completion: @escaping (Swift.Result<PaginatedModel<Donation>, Error>) ->()) {
        
        let coordinate = Constants.defaultCoordinate
        let params = DonationParameters(location: "\(coordinate.latitude), \(coordinate.longitude)", distance: Constants.defaultDistance, keywords: keywords)
        
        NetworkManager.shared.request(.getDonations, method: .get, params: params) { response in
            
            switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(NetworkManager.NetworkError.noData))
                        return
                    }
                    
                    do {
                        let paginatedDonations = try JSONDecoder().decode(PaginatedModel<Donation>.self, from: data)
                        completion(.success(paginatedDonations))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                    break
            }
        }
    }
    
}
