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
    
    static let baseSearchUrl = "https://api.rawg.io/api/games?page_size=10&"
    static let baseUrl       = "https://api.rawg.io/api/games/"
    
    static let headers: HTTPHeaders = [
      "User-Agent": "TestGameApp"
    ]
    
    typealias FetchGamesCompletion   = ([GameItem]) -> ()
    typealias FetchDetailsCompletion = (GameItem) -> ()
        
    static func fetchAllGames(page: Int, searchText: String, completion: @escaping FetchGamesCompletion) {
        let parameters = ["search" : searchText,
                          "page"   : page     ] as [String : Any]
        
        Alamofire.request(baseSearchUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { (response) in
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
    
    static func fetchGameDetails(gameId: Int, completion: @escaping FetchDetailsCompletion) {
        
        Alamofire.request(baseUrl + "\(gameId)", method: .get, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            if let error = response.error {
                print("Failed to contact server", error)
                return
            }
            guard let data = response.data else {return}
            print(data)
            do {
                let searchResult = try JSONDecoder().decode(GameItem.self, from: data)
                completion(searchResult)
            } catch let error {
                print(error)
            }
        }
    }
    
    static func fetchGameScreenshots(gamePk: String, completion: @escaping ([Screenshot]) -> ()) {
        let screenshotUrl = "https://api.rawg.io/api/games/the-last-of-us/screenshots"
        Alamofire.request(screenshotUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            if let error = response.error {
                print("Failed to contact server", error)
                return
            }
            guard let data = response.data else {return}
            do {
                let screenshots = try JSONDecoder().decode(Screenshots.self, from: data)
                completion(screenshots.results)
            } catch let error {
                print(error)
            }
        }
    }
    
}

struct SearchResults: Codable {
    let results: [GameItem]
}

struct Screenshots: Codable {
    let results: [Screenshot]
}

struct Screenshot: Codable {
    let image: String
}
