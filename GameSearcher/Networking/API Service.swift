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
    
    typealias FetchGamesCompletion   = ([GameItem])   -> ()
    typealias FetchDetailsCompletion = (GameItem)     -> ()
    typealias FetchScreensCompletion = ([Screenshot]) -> ()
    
    static let baseSearchUrl = "https://api.rawg.io/api/games?page_size=10&"
    static let baseUrl       = "https://api.rawg.io/api/games/"
    
    static let headers: HTTPHeaders = [
      "User-Agent": "TestGameApp"
    ]
        
    static func fetchAllGames(page: Int, searchText: String, completion: @escaping FetchGamesCompletion) {
        let parameters = ["search" : searchText,
                          "page"   : page     ] as [String : Any]
        
        Alamofire.request(baseSearchUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            handleResponse(response, decode: SearchResults.self) { (searchResult) in
                completion(searchResult.results)
            }
        }
    }
    
    static func fetchGameDetails(gameId: Int, completion: @escaping FetchDetailsCompletion) {
        Alamofire.request(baseUrl + "\(gameId)", method: .get, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            handleResponse(response, decode: GameItem.self) { (gameItem) in
                completion(gameItem)
            }
        }
    }
    
    static func fetchGameScreenshots(gameName: String, completion: @escaping FetchScreensCompletion) {
        Alamofire.request(baseUrl + "\(gameName)/screenshots", method: .get, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            handleResponse(response, decode: Screenshots.self) { (screenshots) in
                completion (screenshots.results)
            }
        }
    }
    
    
    private static func handleResponse<T: Codable>(_ response: DataResponse<Data>, decode: T.Type, completion: @escaping (T) -> ()) {
        if let error = response.error {
            print("Failed to contact server", error)
            return
        }
        guard let data = response.data else {return}
        do {
            let output = try JSONDecoder().decode(decode, from: data)
            completion(output)
        } catch let error {
            print(error)
        }
    }
}
