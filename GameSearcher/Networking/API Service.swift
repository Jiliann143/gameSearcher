//
//  API Service.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/15/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Alamofire
import Foundation

class APIService {
    
    let baseUrl = "https://api.rawg.io/api/games?page_size=10&"
    
    typealias FetchGamesCompletion = ([GameItem]) -> ()
    
    static let shared = APIService()
    
    func fetchGames(page: Int, searchText: String, completion: @escaping FetchGamesCompletion) {
        let parameters = ["search" : searchText,
                          "page"   : page     ] as [String : Any]
        
        Alamofire.request(baseUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            if let error = response.error {
                print("Failed to contact server", error)
                return
            }
            guard let data = response.data else {return}
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completion(searchResult.results)
            } catch let error {
                print(error)
            }
        }
    }
}

struct SearchResults: Codable {
  //  let count: Int
    let results: [GameItem]
}
