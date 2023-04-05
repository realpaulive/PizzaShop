//
//  MenuViewController.swift
//  HammerTest
//
//  Created by Paul Ive on 03.04.23.
//

import Foundation
import UIKit

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
        setDelegates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpViews()
        setContstraints()
    }
    
    private func setUpViews() {
        let barItem = createCuntomBarButtonItem(city: "Москва", selector: #selector(dosome))
        self.navigationItem.leftBarButtonItem = barItem
        
        view.addSubview(collectionView)
        collectionView.register(BannerCellView.self, forCellWithReuseIdentifier: BannerCellView.identifier)
        collectionView.register(CategoryCellView.self, forCellWithReuseIdentifier: CategoryCellView.identifier)
        collectionView.register(MainMenuViewCell.self, forCellWithReuseIdentifier: MainMenuViewCell.identifier)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
    }
}

extension MenuViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, _ in
            switch ListSections.allCases[sectionIndex] {
            case .banners:
                return self.createBannerSection()
            case .category:
                return self.createCategorySection()
            case .mainMenu:
                return self.createMainMenuSection()
            }
        }
        layout.register(RoundedBackgroundView.self, forDecorationViewOfKind: RoundedBackgroundView.identifier)
        return layout
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behaviour: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behaviour
        section.interGroupSpacing = interGroupSpacing
        return section
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8),
                                                                         heightDimension: .absolute(120)), subitems: [item])
        let section = createLayoutSection(group: group, behaviour:  .groupPaging, interGroupSpacing: 10)
        section.contentInsets = .init(top: 10, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(90),
                                                                         heightDimension: .absolute(80)), subitems: [item])
        let section = createLayoutSection(group: group, behaviour: .continuousGroupLeadingBoundary, interGroupSpacing: 8)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)

        return section
    }
    
    private func createMainMenuSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180)), subitems: [item])
        

        let section = NSCollectionLayoutSection(group: group)
        
        section.decorationItems = [
            NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.identifier)
        ]
        section.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
        
        return section
        
        
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
        switch ListSections.allCases[indexPath.section] {
        case .banners:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCellView.identifier, for: indexPath) as? BannerCellView
            else {
                return  UICollectionViewCell()
                
            }
            cell.setUpCell(whithImage: presenter.banners[indexPath.row])
            return cell
        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCellView.identifier, for: indexPath) as? CategoryCellView
            else { return  UICollectionViewCell() }
            cell.configure(presenter.categories[indexPath.row].rawValue)
            return cell
        case .mainMenu:
            guard let pizzas = presenter.pizza,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainMenuViewCell.identifier, for: indexPath) as? MainMenuViewCell
            else { return  UICollectionViewCell() }
            cell.configure(withFood: pizzas[indexPath.row])
            return cell
        }
    }
    
}

extension MenuViewController {
    @objc func dosome() {
        print("doing some")
        collectionView.reloadData()
    }
}

extension MenuViewController: MenuViewControllerProtocol {
    func succes() {
        collectionView.reloadData()
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

extension MenuViewController {
    private func setContstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
