//
//  DonationsCSConfig.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 14/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit
import MapKit

//MARK: - Interactor

protocol DonationsBusinessCSProtocol {
    func fetchDonations(_ request: DonationsCSConfig.DataModels.FetchDonations.Request)
}

protocol DonationsDataStoreCSProtocol {
    var paginatedDonations: PaginatedModel<Donation>? {get set}
}

protocol DonationsInteractorCSProtocol {
    var presenter : DonationsPresentationCSProtocol! {get}
    var worker: DonationsWorkerProtocol! {get}
}

//MARK: - Presenter

protocol DonationsPresentationCSProtocol {
    func presentDonations(response: DonationsCSConfig.DataModels.FetchDonations.Response)
    func presentLoading()
}

protocol DonationsPresenterCSProtocol {
    var controller : DonationsDisplayCSProtocol! {get}
}


//MARK: - Controller

protocol DonationsDisplayCSProtocol : class {
    func displayDonations(_ presentation: DonationsCSConfig.DataModels.FetchDonations.Presentation)
    func displayLoading()
    func displayError(_ error: Error)
}

protocol DonationsControllerCSProtocol {
    var interactor : DonationsBusinessCSProtocol! {get}
    var router : DonationsRoutingCSProtocol! {get}
}

//MARK: - Router

protocol DonationsRoutingCSProtocol {
    func routeToDetail(_ request: DonationsCSConfig.DataModels.Routing.DonationDetail.Request)
}

protocol DonationsDataPassingCSProtocol {
    var dataStore: DonationsDataStoreCSProtocol! {get}
}

protocol DonationsRouterCSProtocol {
    var controller: UIViewController! {get}
}


class DonationsCSConfig {
    
    //MARK: - Setup
    func setup(_ controller : DonationsViewController) {
        
        let interactor = DonationsInteractor()
        let presenter = DonationsPresenter()
        let router = DonationsRouter()
        let worker = DonationsWorker()
        
        //Controller
        controller.interactor = interactor
        controller.router = router
        
        //Interactor
        interactor.presenter = presenter
        interactor.worker = worker
        
        //Presenter
        presenter.controller = controller
        
        //Router
        router.controller = controller
        router.dataStore = interactor
    }
    
    //MARK: - DataModel
    struct DataModels {
        
        //MARK: - FetchDonations
        struct FetchDonations {
            
            struct Request {
                var keywords: String?
            }
            
            struct Response {
                var result : Result<PaginatedModel<Donation>, Error>
            }
            
            struct Presentation {
                struct Donation {
                    let id: String
                    let title: String
                    let image: String?
                    let distance: String?
                    let duration: String
                    let coordinate: CLLocationCoordinate2D
                }
                
                var donations: [Donation]
            }
        }
        
        //MARK: - Routing
        struct Routing {
            
            //MARK: - DonationDetail
            struct DonationDetail {
                
                struct Request {
                    var id: String
                }
            }
        }
    }
}
