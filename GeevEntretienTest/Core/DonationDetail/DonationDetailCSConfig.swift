//
//  DonationDetailCSConfig.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 14/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit
import MapKit

//MARK: - Interactor

protocol DonationDetailBusinessCSProtocol {
    func fetchDetail(_ request: DonationDetailCSConfig.DataModels.FetchDetail.Request)
}

protocol DonationDetailDataStoreCSProtocol {
    var id: String! {get set}
    var donation: Donation? {get set}
}

protocol DonationDetailInteractorCSProtocol {
    var presenter : DonationDetailPresentationCSProtocol! {get}
    var worker: DonationDetailWorkerProtocol! {get}
}

//MARK: - Presenter

protocol DonationDetailPresentationCSProtocol {
    func presentDonationDetail(response: DonationDetailCSConfig.DataModels.FetchDetail.Response)
    func presentLoading()
}

protocol DonationDetailPresenterCSProtocol {
    var controller : DonationDetailDisplayCSProtocol! {get}
}


//MARK: - Controller

protocol DonationDetailDisplayCSProtocol : class {
    func displayDonationDetail(_ presentation: DonationDetailCSConfig.DataModels.FetchDetail.Presentation)
    func displayLoading()
    func displayError(_ error: Error)
}

protocol DonationDetailControllerCSProtocol {
    var interactor : (DonationDetailBusinessCSProtocol & DonationDetailDataStoreCSProtocol)! {get}
}


class DonationDetailCSConfig {
    
    //MARK: - Setup
    func setup(_ controller : DonationDetailViewController) {
        
        let interactor = DonationDetailInteractor()
        let presenter = DonationDetailPresenter()
        let worker = DonationDetailWorker()
        
        //Controller
        controller.interactor = interactor
        
        //Interactor
        interactor.presenter = presenter
        interactor.worker = worker
        
        //Presenter
        presenter.controller = controller
    }
    
    //MARK: - DataModel
    struct DataModels {
        
        //MARK: - FetchDetail
        struct FetchDetail {
            
            struct Request { }
            
            struct Response {
                var result : Result<Donation, Error>
            }
            
            struct Presentation {
                struct Author {
                    let fullname: String
                    let image: String?
                }
                
                struct Location {
                    let obfuscated: Bool
                    let coordinate: CLLocationCoordinate2D
                    let distance: String?
                }
                
                let type: String?
                let duration: String
                let category: String?
                let title: String
                let description: String?
                let images: [String]
                let location: Location
                let author: Author
            }
        }
    }
}
