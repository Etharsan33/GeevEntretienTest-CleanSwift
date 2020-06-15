//
//  DonationDetailInteractor.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 14/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation

protocol DonationDetailWorkerProtocol {
    func getDonation(id: String, completion: @escaping (Swift.Result<Donation, Error>) ->())
}

class DonationDetailInteractor: DonationDetailInteractorCSProtocol, DonationDetailBusinessCSProtocol, DonationDetailDataStoreCSProtocol {
    
    // MARK: - DonationDetailInteractorCSProtocol
    var presenter: DonationDetailPresentationCSProtocol!
    var worker: DonationDetailWorkerProtocol!
    
    // MARK: - DonationDetailDataStoreCSProtocol
    var id: String!
    var donation: Donation?
    
    // MARK: - DonationDetailBusinessCSProtocol
    func fetchDetail(_ request: DonationDetailCSConfig.DataModels.FetchDetail.Request) {
        self.presenter.presentLoading()
        
        self.worker.getDonation(id: self.id) { [weak self] result in
            self?.donation = try? result.get()
            self?.presenter.presentDonationDetail(response: DonationDetailCSConfig.DataModels.FetchDetail.Response(result: result))
        }
    }
}
