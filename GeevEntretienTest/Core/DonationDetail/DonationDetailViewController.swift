//
//  DonationDetailViewController.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxRelay

class DonationDetailViewController: BaseViewController, CSControllerProtocol, DonationDetailControllerCSProtocol, DonationDetailDisplayCSProtocol, UIScrollViewDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var imagesScrollView: UIScrollView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var imagesPageControl: UIPageControl!
    @IBOutlet weak var adTypeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var productStateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - CSControllerProtocol
    func setupCS() {
        DonationDetailCSConfig().setup(self)
    }
    
    // MARK: - DonationDetailControllerCSProtocol
    var interactor: (DonationDetailBusinessCSProtocol & DonationDetailDataStoreCSProtocol)!
    
    private let disposeBag = DisposeBag()
    typealias Presentation = DonationDetailCSConfig.DataModels.FetchDetail.Presentation
    private let presentation: BehaviorRelay<Presentation?> = .init(value: nil)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagesPageControl.currentPageIndicatorTintColor = .donationColor
        
        self.imagesScrollView.delegate = self
        self.userImageView.setCornerRadius(userImageView.frame.height / 2)
        self.mapView.delegate = self
        
        self.observePresentation()
        
        self.interactor.fetchDetail(DonationDetailCSConfig.DataModels.FetchDetail.Request())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.transparent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.transparent(false)
    }
}

// MARK: - DonationDetailDisplayCSProtocol
extension DonationDetailViewController {
    
    func displayDonationDetail(_ presentation: DonationDetailCSConfig.DataModels.FetchDetail.Presentation) {
        self.loadingView.state = .none
        self.presentation.accept(presentation)
    }
    
    func displayLoading() {
        self.loadingView.state = .loading
    }
    
    func displayError(_ error: Error) {
        self.showAlert(title: GEEVLoc.Error.ERROR_DEFAULT_TILE.localized, message: error.localizedDescription, buttons: nil, highlightedButtonIndex: nil) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Rx
extension DonationDetailViewController {
    
    private func observePresentation() {
        
        self.presentation
            .compactMap { $0 }
            .subscribe(onNext: { [unowned self] presentation in
                
                self.imagesPageControl.numberOfPages = presentation.images.count
                self.imagesPageControl.currentPage = 0
                
                presentation.images
                    .map { pictureId -> UIImageView in
                        let imageView = UIImageView()
                        imageView.contentMode = .scaleAspectFit
                        imageView.translatesAutoresizingMaskIntoConstraints = false
                        imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
                        ResourcesManager.shared.loadImageUrl(pictureId, imageView: imageView)
                        return imageView
                }
                .forEach(self.imageStackView.addArrangedSubview)
                
                self.adTypeLabel.text = presentation.type
                self.durationLabel.text = presentation.duration
                self.productStateLabel.text = presentation.category
                self.titleLabel.text = presentation.title
                self.descriptionLabel.text = presentation.description
                self.distanceLabel.text = presentation.location.distance
                self.userNameLabel.text = presentation.author.fullname
                
                ResourcesManager.shared.loadImageUrl(presentation.author.image, imageView: self.userImageView)
                
                self.setCircleOrPinInMaps(location: presentation.location)
                
                }, onError: { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setCircleOrPinInMaps(location: Presentation.Location) {
        if location.obfuscated {
            let circle = MKCircle(center: location.coordinate, radius: 200)
            self.mapView.addOverlay(circle)
        } else {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            self.mapView.addAnnotation(annotation)
        }
        
        self.mapView.centerMap(location.coordinate, animated: false)
    }
}

// MARK: - UIScrollViewDelegate
extension DonationDetailViewController {
    
    // Set pageControl currentPage
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageSide = self.view.frame.width
        let offset = scrollView.contentOffset.x
        let currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        self.imagesPageControl.currentPage = currentPage
    }
}

// MARK: - MKMapViewDelegate
extension DonationDetailViewController {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = .donationColor
            circle.fillColor = UIColor.donationColor.withAlphaComponent(0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return MKPolylineRenderer()
        }
    }
}
