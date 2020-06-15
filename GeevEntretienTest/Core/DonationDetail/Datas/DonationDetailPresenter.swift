//
//  DonationDetailPresenter.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 14/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class DonationDetailPresenter: DonationDetailPresenterCSProtocol, DonationDetailPresentationCSProtocol {
    
    // MARK: - DonationDetailPresenterCSProtocol
    weak var controller: DonationDetailDisplayCSProtocol!
    
    // MARK: - DonationDetailPresentationCSProtocol
    func presentDonationDetail(response: DonationDetailCSConfig.DataModels.FetchDetail.Response) {
        switch response.result {
            case .success(let donation):
                let presentation = self.donationToPresentation(donation)
                self.controller.displayDonationDetail(presentation)
            case .failure(let error):
                self.controller.displayError(error)
        }
    }
    
    func presentLoading() {
        self.controller.displayLoading()
    }
    
    // MARK: - Transform
    typealias Presentation = DonationDetailCSConfig.DataModels.FetchDetail.Presentation
    private func donationToPresentation(_ donation: Donation) -> Presentation {
        
        func getLocation() -> Presentation.Location {
            let location = donation.location
            return Presentation.Location(obfuscated: location.obfuscated,
                                         coordinate: location.coordinate,
                                         distance: UserLocationManager.shared.getDistanceByUserLocation(location))
        }
        
        func getAuthor() -> Presentation.Author {
            return Presentation.Author(fullname: donation.author.fullname, image: donation.author.picture)
        }
        
        return Presentation(type: donation.type,
                            duration: Date(timeIntervalSince1970: donation.lastUpdateTimestamp).dateDuration(),
                            category: donation.category,
                            title: donation.title,
                            description: donation.description,
                            images: donation.pictures,
                            location: getLocation(),
                            author: getAuthor()
                )
    }
}
