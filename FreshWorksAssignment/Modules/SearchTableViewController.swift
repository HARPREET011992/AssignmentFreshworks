//
//  SearchTableViewController.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-07.
//

import UIKit
import SwiftyGif

class SearchTableViewController: UITableViewController,UISearchControllerDelegate,UISearchResultsUpdating {
//   let network = NetworkManager()
    let api = NetworkManager()
    var root = RootTabViewController()
    var localarray = [String].self
    @IBOutlet var searchTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var gifModel: [AnyObject]?
    var dataModel = [GiphyData]()
    var gifStringArr = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTableContent()
        searchController.searchResultsUpdater = self
           searchController.hidesNavigationBarDuringPresentation = false
           searchController.dimsBackgroundDuringPresentation = false
           searchController.searchBar.sizeToFit()
           self.tableView.tableHeaderView = searchController.searchBar
        
    }
    override class func description() -> String {
        "SearchViewController"
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      
        return gifModel?.count ?? 0
//
     
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GifSearchTableViewCell", for: indexPath) as? GifSearchTableViewCell
        {
            if let imageData = self.gifModel?[indexPath.row]
            {
                if let images = imageData["images"] as? [String:AnyObject]
                {
                    if let downSize = images["downsized"] as? [String:AnyObject]
                    {
                        if let imageURL = downSize["url"] as? String
                        {
                            cell.setCellData(_data: imageURL)
                        }
                    }
                    
                }
            }
            return cell
        }
        else  { return UITableViewCell() }
        
    }
    var moviePosterUrl: URL {
         return URL(string: "http://api.giphy.com/v1/gifs/trending")!
        
    }
    var moviePUrl: URL {
         return URL(string: "http://api.giphy.com/v1/gifs/search")!
        
    }
    var timer = Timer.init()
    var searchText = ""
    func updateSearchResults(for searchController: UISearchController) {
        
        timer.invalidate()
        guard let text = searchController.searchBar.text else { return }
        print(#line,#file)
        searchText = text
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(searchAPI), userInfo: nil, repeats: false)
        
      
    }
    @objc func searchAPI()
    {
        print(searchText)
        if(searchText == "")
        {
            self.getWheatherDataFromServer()
        }
        else{
        let parm = [URLQueryItem(name: "q", value: searchText), URLQueryItem(name: "api_key", value: "Qvz4B1vkcNUr8V68lMgs5eX8HR7v2Hx1")]
            
        api.getApiData(requestUrl: moviePUrl.absoluteString, parameters: parm, result: GiphyModel.self) { res in
            
            DispatchQueue.main.async {
                self.gifModel = res
                self.tableView.reloadData()
            }
        }
        }
    }
    func updateTableContent() {
        getWheatherDataFromServer()
    }
    func getWheatherDataFromServer(){
       // AppInstance.showLoader()
        let parm = [URLQueryItem(name: "api_key", value: "Qvz4B1vkcNUr8V68lMgs5eX8HR7v2Hx1")]
        api.getApiData(requestUrl:  moviePosterUrl.absoluteString, parameters: parm, result: GiphyModel.self) { (response) in
             self.gifModel = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }

}
    func checkData() {
        if root.selectedIndex == 0 {
            
        }else {
            for i in 0...gifModel!.count{
             
            }
        }
    }

}


