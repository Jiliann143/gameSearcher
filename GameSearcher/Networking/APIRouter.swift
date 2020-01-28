//
//  APIRouter.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 1/28/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import Alamofire

public enum APIRouter: URLRequestConvertible {

  enum Constants {
     static let baseUrl = "https://api.rawg.io/api/games"
     static let headers = "TestGameApp"
  }
  
  case searchGames(String, Int)
  case details(Int)
  case screenshots(String)
  
  var method: HTTPMethod {
    return .get
  }
  
  var path: String {
    switch self {
    case .searchGames:
      return "https://api.rawg.io/api/games?page_size=10&"
    case .details(let id):
      return "\(id)"
    case .screenshots(let name):
      return "\(name)/screenshots"
    }
  }
  
  var parameters: [String: Any] {
    switch self {
    case .searchGames(let text, let page):
      return ["search" : text,
              "page"   : page  ] as [String : Any]
    case .details:
        return [:]
    case .screenshots:
        return [:]
    }
  }
  
  public func asURLRequest() throws -> URLRequest {
    let url = try Constants.baseUrl.asURL()
    var finalUrl = url.appendingPathComponent(path)
    
    if path == "https://api.rawg.io/api/games?page_size=10&" {
        finalUrl = try path.asURL()
    }
    
    var request = URLRequest(url: finalUrl)
    request.httpMethod = method.rawValue
    request.addValue(Constants.headers, forHTTPHeaderField: "User-Agent")
    request.timeoutInterval = TimeInterval(10 * 1000)
    return try URLEncoding.default.encode(request, with: parameters)
  }
}


