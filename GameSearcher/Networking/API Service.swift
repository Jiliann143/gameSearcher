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
    
    typealias FetchGamesCompletion   = ([GameItem]?)   -> ()
    typealias FetchDetailsCompletion = (GameItem?)     -> ()
    typealias FetchScreensCompletion = ([Screenshot]?) -> ()
    
    static let baseSearchUrl = "https://api.rawg.io/api/games?page_size=10&"
    static let baseUrl       = "https://api.rawg.io/api/games/"
    
    static let headers: HTTPHeaders = [
      "User-Agent": "TestGameApp"
    ]
        
    static func fetchAllGames(page: Int, searchText: String, completion: @escaping FetchGamesCompletion) {
        let parameters = ["search" : searchText,
                          "page"   : page     ] as [String : Any]
        
        Alamofire.request(baseSearchUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            handleResponse(response, decode: SearchResults.self) { searchResult in
                guard let results = searchResult else {
                    completion(nil)
                    return
                }
                completion(results.results)
            }
        }
    }
    
    static func fetchGameDetails(gameId: Int, completion: @escaping FetchDetailsCompletion) {
        Alamofire.request(baseUrl + "\(gameId)", method: .get, encoding: URLEncoding.default, headers: headers).responseData { response in
            handleResponse(response, decode: GameItem.self) { gameItem in
                guard let gameItem = gameItem else { completion(nil); return }
                completion(gameItem)
            }
        }
    }
    
    static func fetchGameScreenshots(gameName: String, completion: @escaping FetchScreensCompletion) {
        Alamofire.request(baseUrl + "\(gameName)/screenshots", method: .get, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            handleResponse(response, decode: Screenshots.self) { (screenshots) in
                guard let screenshots = screenshots else {
                    completion(nil)
                    return
                }
                completion(screenshots.results)
            }
        }
    }
    
    
    private static func handleResponse<T: Codable>(_ response: DataResponse<Data>, decode: T.Type, completion: @escaping (T?) -> ()) {
        if let error = response.error {
            print(error.localizedDescription)
            return
        }
        guard let data = response.data else {return}
        do {
            let output = try JSONDecoder().decode(decode, from: data)
            completion(output)
        } catch let error {
            print(error.localizedDescription)
            completion(nil)
        }
    }
}
