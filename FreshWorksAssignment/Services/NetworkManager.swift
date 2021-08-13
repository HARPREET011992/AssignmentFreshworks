//
//  NetworkManager.swift
//  FreshWorksAssignment
//
//   Created by Happy on 2021-08-07.
//
//
import UIKit
import SwiftyJSON
struct NetworkManager {
  
    func
    getApiData(requestUrl: String,parameters:[URLQueryItem]?,completionHandler: @escaping(_ result: JSON) -> Void) {
        let queryItems = parameters
        var urlComps = URLComponents(string: requestUrl)!
        urlComps.queryItems = queryItems
        let resultURL = urlComps.url!
        URLSession.shared.dataTask(with: resultURL ) { (responseData, httpUrlResponse, error1) in
            if error1 == nil && responseData != nil && responseData?.count != 0 {
                do {
                    let jsonObject = JSON(responseData as Any)
                    _ = completionHandler(jsonObject)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        }
        
        .resume()
    }
}

