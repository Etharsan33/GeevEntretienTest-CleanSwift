//
//  DonationsViewController.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 11/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxRelay
import RxCocoa
import RxDataSources

class DonationsViewController: BaseViewController, CSControllerProtocol, DonationsControllerCSProtocol, DonationsDisplayCSProtocol, UICollectionViewDelegateFlowLayout, MKMapViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - CSControllerProtocol
    func setupCS() {
        DonationsCSConfig().setup(self)
    }
    
    // MARK: - DonationsControllerCSProtocol
    var interactor: DonationsBusinessCSProtocol!
    var router: DonationsRoutingCSProtocol!
    
    private let padding: CGFloat = 14
    private var isShowList: Bool = true
    
    override var loadingTitle: String {
        return GEEVLoc.Donation.DONATION_NO_RESULT.localized
    }
    
    private var donations: BehaviorRelay<[SectionData]> = .init(value: [])
    private let disposeBag = DisposeBag()
    
    private typealias DonationPresentation = DonationsCSConfig.DataModels.FetchDonations.Presentation.Donation
    private typealias DataSource = RxCollectionViewSectionedReloadDataSource<SectionData>
    private struct SectionData: SectionModelType {
        typealias Item = DonationPresentation
        var items: [Item]
        
        init(items: [DonationPresentation]) {
            self.items = items
        }
        
        init(original: DonationsViewController.SectionData, items: [DonationPresentation]) {
            self = original
            self.items = items
        }
    }

    private class DonationAnnotation: MKPointAnnotation {
        var id: String!
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarItem: UIBarButtonItem!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
        let mapBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "map_icon"), style: .plain, target: self, action: #selector(toggleMapListAction))
        self.searchBarItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarAction))
        self.navigationItem.rightBarButtonItems = [self.searchBarItem, mapBarItem]
        
        // setup SearchController
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        
        self.mapView.isHidden = self.isShowList
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        
        self.collectionView.delegate = self
        DonationHeaderViewCell.registerNibFor(collectionView: collectionView)
        DonationViewCell.registerNibFor(collectionView: collectionView)
        
        // Configure Custom FlowLayout
        let alignedFlowLayout = collectionView?.collectionViewLayout as? AlignedCollectionViewFlowLayout
        alignedFlowLayout?.sectionInset = UIEdgeInsets(top: 20, left: self.padding / 2, bottom: 20, right: self.padding / 2)
        alignedFlowLayout?.horizontalAlignment = .left
        
        // Setup Cells
        let dataSource = self.configureCells()
        self.configureSupplementaryView(dataSource)
        self.bindItemsToCells(dataSource)
        self.setupTapCell()
        
        self.observeDonations()
        self.observeSearchBarText()
        
        self.interactor.fetchDonations(DonationsCSConfig.DataModels.FetchDonations.Request(keywords: nil))
    }
    
    // MARK: - Private
    private func configureMapAnnotations(_ donations: [DonationPresentation]) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        let annotations = donations.map { donation -> MKPointAnnotation in
            let annotation = DonationAnnotation()
            annotation.id = donation.id
            annotation.title = donation.title
            annotation.coordinate = donation.coordinate
            return annotation
        }
        
        self.mapView.addAnnotations(annotations)
        self.mapView.showAnnotations(self.mapView.annotations, animated: false)
    }
    
    // MARK: - Actions
    @objc func toggleMapListAction(_ barItem: UIBarButtonItem) {
        self.isShowList.toggle()
        barItem.image = (self.isShowList) ? #imageLiteral(resourceName: "map_icon") : #imageLiteral(resourceName: "list_icon")
        self.collectionView.isHidden = !self.isShowList
        self.mapView.isHidden = self.isShowList
    }
    
    @objc func searchBarAction(_ barItem: UIBarButtonItem) {
        self.navigationItem.titleView = self.searchController.searchBar
        if let index = self.navigationItem.rightBarButtonItems?.firstIndex(where: {$0 == barItem}) {
            self.navigationItem.rightBarButtonItems?.remove(at: index)
        }
        self.searchController.searchBar.becomeFirstResponder()
    }
}

// MARK: - DonationsDisplayCSProtocol
extension DonationsViewController {
    
    func displayDonations(_ presentation: DonationsCSConfig.DataModels.FetchDonations.Presentation) {
        self.loadingView.state = .none
        self.donations.accept([SectionData(items: presentation.donations)])
    }
    
    func displayLoading() {
        self.loadingView.state = .loading
    }
    
    func displayError(_ error: Error) {
        self.loadingView.state = .titleOnly
    }
}

// MARK: - RxDataSources
extension DonationsViewController {
    
    private func configureCells() -> DataSource {
        return RxCollectionViewSectionedReloadDataSource<SectionData>(configureCell: { (dataSource, collectionView, indexPath, donationPresentation) -> UICollectionViewCell in
            
            let cell = DonationViewCell.cellForCollection(collectionView: collectionView, indexPath: indexPath)
            cell.widthConstraint.constant = self.collectionView.bounds.width / 2 - (self.padding)
            cell.presentation = donationPresentation
            ResourcesManager.shared.loadImageUrl(donationPresentation.image, imageView: cell.imageView)
            return cell
            
        })
    }
    
    private func configureSupplementaryView(_ dataSource: DataSource) {
        dataSource.configureSupplementaryView = { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            let header = DonationHeaderViewCell.reusableViewForCollection(collectionView: collectionView, indexPath: indexPath)
            return header
        }
    }
}

// MARK: - Rx
extension DonationsViewController {
    
    private func bindItemsToCells(_ dataSource: RxCollectionViewSectionedReloadDataSource<SectionData>) {
        self.donations
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
    private func setupTapCell() {
        self.collectionView.rx
            .modelSelected(DonationPresentation.self)
            .subscribe(onNext: { donation in
                self.router.routeToDetail(DonationsCSConfig.DataModels.Routing.DonationDetail.Request(id: donation.id))
        }).disposed(by: self.disposeBag)
    }
    
    // Observers
    private func observeDonations() {
        self.donations.subscribe(onNext: { sectionDatas in
            if let sectionData = sectionDatas.first {
                self.configureMapAnnotations(sectionData.items)
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func observeSearchBarText() {
        self.searchController.searchBar.rx.text
            .orEmpty
            .skip(1) // Ship first time when initial searchController
            .debounce(.milliseconds(250), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                let keywords = text.isEmpty ? nil : text
                self?.interactor.fetchDonations(DonationsCSConfig.DataModels.FetchDonations.Request(keywords: keywords))
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DonationsViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: DonationHeaderViewCell.preferredHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.padding
    }
}

// MARK: - MKMapViewDelegate
extension DonationsViewController {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: false)
        
        if let donationAnnotation = view.annotation as? DonationAnnotation {
            self.router.routeToDetail(DonationsCSConfig.DataModels.Routing.DonationDetail.Request(id: donationAnnotation.id))
        }
    }
}

// MARK: - UISearchBarDelegate
extension DonationsViewController {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.sendActions(for: .editingChanged)
        } else {
            (searchBar.value(forKey: "_searchField") as? UITextField)?.sendActions(for: .editingChanged)
        }
        
        self.navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItems?.insert(self.searchBarItem, at: 0)
    }
}
