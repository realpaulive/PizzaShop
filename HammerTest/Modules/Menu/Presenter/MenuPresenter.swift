//
//  MenuPresenter.swift
//  HammerTest
//
//  Created by Paul Ive on 03.04.23.
//

import Foundation
import UIKit

protocol MenuViewControllerProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol MenuPresenterProtocol: AnyObject {
    init(view: MenuViewControllerProtocol, networkService: NetworkServiceProtocol)
    func fetchData(forCategory section: Categories)
    
    var pizza: [FoodElement]? { get set }
    var banners: [UIImage] { get }
    var categories: [Categories] { get }
    
    func returnErrorAlert() -> UIAlertController
}


final class MenuPresenter: MenuPresenterProtocol {
    
    weak var view: MenuViewControllerProtocol?
    let networkService: NetworkServiceProtocol!
    
    var pizza: [FoodElement]?
    let banners: [UIImage] = ([UIImage(named: "discount")!, UIImage(named: "gift")!])
    let categories = Categories.allCases
    
    required init(view: MenuViewControllerProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        fetchData(forCategory: .pizza)
    }
    
    func fetchData(forCategory category: Categories) {
        networkService.fetchData(forCategory: category) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let someFood):
                    self.pizza = someFood
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func returnErrorAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Ой, что-то пошло не так!", message: "Возникла ошибка соединения...", preferredStyle: .alert)
        
        let actionRefresh = UIAlertAction(title: "Перезагрузить", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.fetchData(forCategory: .pizza)
        }
        
        let actionCancel = UIAlertAction(title: "Отмена", style: .destructive)
        
        alert.addAction(actionRefresh)
        alert.addAction(actionCancel)
        
        return alert
    }
}
