//
//  DonationDetailWorker.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation

struct DonationDetailWorker: DonationDetailWorkerProtocol {
    
    struct Params: Encodable {
        var id: String
        var presentation: String = "full"
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case presentation
        }
    }
    
    func getDonation(id: String,
                      completion: @escaping (Swift.Result<Donation, Error>) ->()) {
        
        let params = Params(id: id)
        
        NetworkManager.shared.request(.getDonations, method: .get, params: params) { response in
            
            switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(NetworkManager.NetworkError.noData))
                        return
                    }
                    
                    do {
                        // Don't know why server send Paginated Donation Model instead of Donation Model
                        let paginatedDonation = try JSONDecoder().decode(PaginatedModel<Donation>.self, from: data)
                        
                        guard let donation = paginatedDonation.content.first else {
                            completion(.failure(NetworkManager.NetworkError.noData))
                            return
                        }
                        completion(.success(donation))
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
