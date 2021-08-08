////
////  NetworkManager.swift
////  FreshWorksAssignment
////
////  Created by Happy on 2021-08-07.
////
//
import UIKit
struct NetworkManager {
  
    func getApiData<T:Decodable>(requestUrl: String,parameters:[URLQueryItem]?, result: T.Type ,completionHandler: @escaping(_ result: [AnyObject]) -> Void) {
        let queryItems = parameters

        var urlComps = URLComponents(string: requestUrl)!
        urlComps.queryItems = queryItems
        let resultURL = urlComps.url!
       print(resultURL)
        URLSession.shared.dataTask(with: resultURL ) { (responseData, httpUrlResponse, error1) in
            
            if error1 == nil && responseData != nil && responseData?.count != 0 {
             
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: responseData!, options: []) as? [String: Any] {
                        // try to read out a string array
                        if let names = json["data"] as? [AnyObject] {
                            _ = completionHandler(names)
                        }
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
//                let decoder = JSONDecoder()
//                do {
//
//
//                   let result = try decoder.decode(T.self, from: responseData!)
//                 _ = completionHandler(result)
//                } catch  {
//
//                    print(error)
//                    print("error occured while decoding = \(error.localizedDescription)")
//                }
            }
        }
        
        .resume()
    }
}

