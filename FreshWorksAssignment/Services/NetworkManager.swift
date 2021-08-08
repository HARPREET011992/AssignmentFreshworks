////
////  NetworkManager.swift
////  FreshWorksAssignment
////
////  Created by Happy on 2021-08-07.
////
//
//import Foundation
//import UIKit
//import Alamofire
//
//enum APIError:String {
//    case networkError
//    case apiError
//    case decodingError
//}
//
//
//enum APIs: URLRequestConvertible  {
//    case trendingGifs
//    case searchGifs(query:String)
//    
//    static let endpoint = URL(string: "api.giphy.com/v1/gifs")!
//    static let apiKey = "Qvz4B1vkcNUr8V68lMgs5eX8HR7v2Hx1"
//    
//    var path:String {
//        switch self {
//        case .trendingGifs:
//            return "/trending"
//        case .searchGifs(_):
//            return "//search"
//        }
//    }
//    
//    var method: HTTPMethod {
//        return .get
//    }
//    
//    var encoding : URLEncoding {
//        return URLEncoding.init(destination: .queryString, arrayEncoding: .noBrackets)
//    }
//    
//    func addApiHeaders(request :inout URLRequest)  {
//        request.addValue(APIs.apiKey, forHTTPHeaderField: "api_key")
//    }
//    
//    func asURLRequest() throws -> URLRequest {
//        var request = URLRequest(url: APIs.endpoint.appendingPathComponent(path))
//        var parameters = Parameters()
//        
//        switch  self {
//        case .searchGifs(let query):
//            parameters["q"] = query
//        default:
//            break
//        }
//        addApiHeaders(request: &request)
//        request = try encoding.encode(request, with: parameters)
//        return request
//    }
//}
//struct NetworkManager {
//    let jsonDecoder = JSONDecoder()
//    let imageCompressionScale :CGFloat = 0.25
//    
////    func fetchFavGifs(url: URL,completion: @escaping(Welcome?, APIError?) -> ()) {
//        
//        AF.request(URLRequest(url: url)).validate().responseData { res in
//            switch res.result {
//            case .failure:
//                completion(nil, .apiError)
//            case .success(let jsonData):
//                    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonData, options: .sortedKeys)  {
//                        do {
//                            let popularTitles = try self.jsonDecoder.decode([String].self, from: jsonData)
//                            print(popularTitles)
////                            completion(popularTitles.map { $0.components(separatedBy: "/")[2] }, nil)
//                        } catch {
//                            print(error)
//                            completion(nil, .decodingError)
//                        }
//                    } else {
//                        completion(nil, .networkError)
//                    }
//            }
//        }
//    }
//    func fetchSearchGifs(query:String,completion:@escaping(Welcome?,APIError?) -> ()) {
//        AF.request(APIs.searchGifs(query: query)).validate().responseJSON { json in
//            switch json.result {
//            case .failure :
//                completion(nil,.apiError)
//                break
//            case .success:
//            if let jsonData = json.data {
//                let jsonDecoder = JSONDecoder()
//                do {
//                    let gifs = try jsonDecoder.decode(Welcome.self, from: jsonData)
//                    completion(gifs, nil)
//                }catch let error{
//                    
//                    print(error.localizedDescription)
//                    completion(nil,.decodingError)
//                }
//            }
//            else {
//                completion(nil,.networkError)
//            }
//            }
//        }
//    }
//}
