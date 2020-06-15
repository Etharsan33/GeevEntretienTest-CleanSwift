//
//  DonationsPresenter.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 14/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation

class DonationsPresenter: DonationsPresenterCSProtocol, DonationsPresentationCSProtocol {
    
    // MARK: - DonationsPresenterCSProtocol
    weak var controller: DonationsDisplayCSProtocol!
    
    // MARK: - DonationsPresentationCSProtocol
    func presentDonations(response: DonationsCSConfig.DataModels.FetchDonations.Response) {
        switch response.result {
            case .success(let paginatedDonations):
                let donationsPresentation = paginatedDonations.content.map(donationToPresentation)
                self.controller.displayDonations(DonationsCSConfig.DataModels.FetchDonations.Presentation(donations: donationsPresentation))
            case .failure(let error):
                self.controller.displayError(error)
        }
    }
    
    func presentLoading() {
        controller.displayLoading()
    }
    
    // MARK: - Transform
    typealias DonationPresentation = DonationsCSConfig.DataModels.FetchDonations.Presentation.Donation
    func donationToPresentation(_ donation: Donation) -> DonationPresentation {
        return DonationPresentation(id: donation.id,
                                    title: donation.title,
                                    image: donation.pictures.first,
                                    distance: UserLocationManager.shared.getDistanceByUserLocation(donation.location),
                                    duration: Date(timeIntervalSince1970: donation.lastUpdateTimestamp).dateDuration(),
                                    coordinate: donation.location.coordinate
                )
    }
}
