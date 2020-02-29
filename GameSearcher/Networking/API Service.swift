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
        
    static func fetchAllGames(page: Int, searchText: String, completion: @escaping FetchGamesCompletion) {
            AF.request(APIRouter.searchGames(searchText, page)).responseData { response in
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
        AF.request(APIRouter.details(gameId)).responseData { response in
            handleResponse(response, decode: GameItem.self) { gameItem in
                guard let gameItem = gameItem else {
                    completion(nil)
                    return
                }
                completion(gameItem)
            }
        }
    }
    
    static func getScreenshots(_ gameName: String, completion: @escaping FetchScreensCompletion) {
        AF.request(APIRouter.screenshots(gameName)).responseData { response in
            handleResponse(response, decode: Screenshots.self) { screenshots in
                guard let screenshots = screenshots else {
                    completion(nil)
                    return
                }
                completion(screenshots.results)
            }
        }
    }
    
    
    private static func handleResponse<T: Codable>(_ response: AFDataResponse<Data>, decode: T.Type, completion: @escaping (T?) -> ()) {
        if let error = response.error {
            print(error.localizedDescription)
            return
        }
        guard let data = response.data else { return }
        do {
            let output = try JSONDecoder().decode(decode, from: data)
            completion(output)
        } catch let error {
            print(error.localizedDescription)
            completion(nil)
        }
    }
}
