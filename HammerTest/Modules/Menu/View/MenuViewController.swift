//
//  MenuViewController.swift
//  HammerTest
//
//  Created by Paul Ive on 03.04.23.
//

import Foundation
import UIKit
import SnapKit

final class MenuViewController: UIViewController {
    var presenter: MenuPresenterProtocol!
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var cityButton: UINavigationItem {
        return UINavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setUpViews()
        setDelegates()
        view.addSubview(collectionView)
    }
    
    private func setUpViews() {
        let barItem = createCuntomBarButtonItem(city: "Москва", selector: #selector(dosome))
        self.navigationItem.leftBarButtonItem = barItem
    }
    
    @objc func dosome() {
        print("doing some")
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
    }
}

extension MenuViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        ListSections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch ListSections.allCases[section] {
        case .banners:
            return presenter.banners.count
        case .category:
            return presenter.categories.count
        case .mainMenu:
            guard let pizzas = presenter.pizza else { return 0 }
            return pizzas.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch ListSections.allCases[indexPath.section] {
//        case .banners:
//            <#code#>
//        case .category:
//            <#code#>
//        case .mainMenu:
//            return UICollectionViewCell()
//        }
        
        UICollectionViewCell()

    }
    
}




extension MenuViewController: MenuViewControllerProtocol {
    func succes() {
        
    }
    
    func failure(error: Error) {
        showErrorAlert()
    }
}

extension MenuViewController {
    func showErrorAlert() {
        let alert = presenter.returnErrorAlert()
        self.present(alert, animated: true)
    }
}
