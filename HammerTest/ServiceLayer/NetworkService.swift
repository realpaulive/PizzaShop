//
//  NetworkService.swift
//  HammerTest
//
//  Created by Paul Ive on 03.04.23.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func fetchData(forCategory section: Categories, completion: @escaping (Result<[FoodElement], AFError>) -> ())
}

final class NetworkService: NetworkServiceProtocol {
   
    private func returnURL(section: Categories) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "642ab0a3b11efeb7599fec25.mockapi.io"
        urlComponents.path = "/food/\(section.rawValue.lowercased())"
        return urlComponents.url
    }
    
    func fetchData(forCategory category: Categories, completion: @escaping (Result<[FoodElement], AFError>) -> ()) {
        guard let url = returnURL(section: category) else { return }
        AF.request(url, method: .get).validate().responseDecodable(of: [FoodElement].self, queue: .global(qos: .utility)) { response in
            completion(response.result)
        }
    }
}
