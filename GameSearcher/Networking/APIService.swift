//
//  API Service.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/15/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Alamofire
import Foundation
import Swiftools

class APIService {
    
    typealias FetchGamesCompletion    = (_ error: String?, [GameItem]?)   -> ()
    typealias FetchDetailsCompletion  = (_ error: String?, GameItem?)     -> ()
    typealias FetchScreensCompletion  = (_ error: String?, [Screenshot]?) -> ()
    typealias FetchTrailersCompletion = (_ error: String?, [Trailer]?)    -> ()
        
    static func fetchAllGames(page: Int, searchText: String, completion: @escaping FetchGamesCompletion) {
        AF.request(APIRouter.searchGames(searchText, page)).responseJSON { response in
            handleResponse(response, decode: SearchResults.self) { searchResult, error in
                guard let results = searchResult else {
                    completion(error, nil)
                    return
                }
                completion(nil, results.results)
            }
        }
    }
    
    static func fetchGameDetails(gameId: Int, completion: @escaping FetchDetailsCompletion) {
        AF.request(APIRouter.details(gameId)).responseJSON { response in
            handleResponse(response, decode: GameItem.self) { gameItem, error in
                guard let gameItem = gameItem else {
                    completion(error, nil)
                    return
                }
                completion(nil, gameItem)
            }
        }
    }
    
    static func getScreenshots(_ gameName: String, completion: @escaping FetchScreensCompletion) {
        AF.request(APIRouter.screenshots(gameName)).responseJSON { response in
            handleResponse(response, decode: ScreenshotResults.self) { screenshots, error in
                guard let screenshots = screenshots else {
                    completion(error, nil)
                    return
                }
                completion(nil, screenshots.results)
            }
        }
    }
    
    static func getSimilarGames(_ page: Int, _ gameId: Int, completion: @escaping FetchGamesCompletion) {
        AF.request(APIRouter.similar(page, gameId)).responseJSON { response in
            handleResponse(response, decode: SearchResults.self) { searchResult, error in
                guard let results = searchResult else {
                    completion(error, nil)
                    return
                }
                completion(nil, results.results)
            }
        }
    }
    
    static func getGameTrailers(_ gameId: Int, completion: @escaping FetchTrailersCompletion) {
        AF.request(APIRouter.trailers(gameId)).responseJSON { response in
     //       Log(response.data?.prettyPrintedJSONString)
            handleResponse(response, decode: TrailerResults.self) { trailers, error in
                guard let trailers = trailers else {
                    completion(error, nil)
                    return
                }
                completion(nil, trailers.results)
            }
        }
    }
    
    
    private static func handleResponse<T: Decodable>(_ response: AFDataResponse<Any>, decode: T.Type, completion: @escaping (T?, String?) -> ()) {
        if let error = response.error {
            completion(nil, error.localizedDescription)
            return
        }
        guard let data = response.data else { return }
        do {
            let output = try JSONDecoder().decode(decode, from: data)
            completion(output, nil)
        } catch let error {
            completion(nil, error.localizedDescription)
        }
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
