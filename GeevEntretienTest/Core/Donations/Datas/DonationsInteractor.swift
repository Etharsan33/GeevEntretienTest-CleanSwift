//
//  DonationsInteractor.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 14/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation

protocol DonationsWorkerProtocol {
    func getDonations(keywords: String?, completion: @escaping (Swift.Result<PaginatedModel<Donation>, Error>) ->())
}

class DonationsInteractor: DonationsInteractorCSProtocol, DonationsBusinessCSProtocol, DonationsDataStoreCSProtocol {
    
    // MARK: - DonationsInteractorCSProtocol
    var presenter: DonationsPresentationCSProtocol!
    var worker: DonationsWorkerProtocol!
    
    // MARK: - DonationsDataStoreCSProtocol
    var paginatedDonations: PaginatedModel<Donation>?
    
    // MARK: - DonationsBusinessCSProtocol
    func fetchDonations(_ request: DonationsCSConfig.DataModels.FetchDonations.Request) {
        self.presenter.presentLoading()
        
        DonationsWorker().getDonations(keywords: request.keywords) { [weak self] result in
            self?.paginatedDonations = try? result.get()
            self?.presenter.presentDonations(response: DonationsCSConfig.DataModels.FetchDonations.Response(result: result))
        }
    }
}
