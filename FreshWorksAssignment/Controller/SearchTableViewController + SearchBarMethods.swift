//
//  SearchTableViewController + SearchBarMethods.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-12.
//

import Foundation
import UIKit
extension SearchTableViewController : UISearchControllerDelegate,UISearchResultsUpdating  {
    // MARK:- set up search bar
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        self.searchTableView.tableHeaderView = searchController.searchBar
    }
    // MARK:- update function
    
    func updateSearchResults(for searchController: UISearchController) {
        timer.invalidate()
        guard let text = searchController.searchBar.text else { return }
        searchGifText = text
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchGiphyAPI), userInfo: nil, repeats: false)
    }
    // MARK:- call api to get giphy data from the sever about search text    
    @objc func searchGiphyAPI()
    {
        if(searchGifText == "")
        {
            self.getGifDataFromServer(offset: 50, refreshGifs: true)
        }
        else{
            searchActivityIndicator.startAnimating()
            let parm = [URLQueryItem(name: "q", value: searchGifText), URLQueryItem(name: "api_key", value: apiKey),URLQueryItem(name: "offset", value:String(offset))]
           
            api.getApiData(requestUrl: gifSearchingUrl.absoluteString, parameters: parm) {[unowned self] res  in
                DispatchQueue.main.async {
                    self.searchActivityIndicator.stopAnimating()
                    displayGifs.removeAll()
                    for giphyData in res["data"].arrayValue
                    {
                        if  let image = giphyData["images"]["downsized"]["url"].string {
                            self.displayGifs.append(image)
                        }
                    }
                    self.searchTableView.reloadData()
                }
            }
            
        }
    }
}
