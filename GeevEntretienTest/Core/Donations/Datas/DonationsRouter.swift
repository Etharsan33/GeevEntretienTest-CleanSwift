//
//  DonationsRouter.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 14/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class DonationsRouter: DonationsRouterCSProtocol, DonationsRoutingCSProtocol, DonationsDataPassingCSProtocol {
    
    // MARK: - DonationsRouterCSProtocol
    weak var controller: UIViewController!
    
    // MARK: - DonationsDataPassingCSProtocol
    var dataStore: DonationsDataStoreCSProtocol!
    
    // MARK: - DonationsRoutingCSProtocol
    func routeToDetail(_ request: DonationsCSConfig.DataModels.Routing.DonationDetail.Request) {
        let donationDetail = DonationDetailViewController.instanceCS as! DonationDetailViewController
        var detailDataStore: DonationDetailDataStoreCSProtocol = donationDetail.interactor
        detailDataStore.id = request.id
        controller.navigationController?.pushViewController(donationDetail, animated: true)
    }
}
