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
    let http = HttpUtility()
    @IBOutlet var searchTableView: UITableView!
   // @IBOutlet weak var searchBar: UISearchBar!
    let searchController = UISearchController(searchResultsController: nil)
    var gifModel: GiphyModel?
    var dataModel = [GiphyData]()
    var gifStringArr = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTableContent()
//        searchController.searchResultsUpdater = self
//           searchController.hidesNavigationBarDuringPresentation = false
//           searchController.dimsBackgroundDuringPresentation = false
//           searchController.searchBar.sizeToFit()
//           self.tableView.tableHeaderView = searchController.searchBar
////        NetworkManager.fetchTrendingGifs(NetworkManager)
        
    }
    override class func description() -> String {
        "SearchViewController"
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 262
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      
        return 1
//        gifModel?.data?.count ?? 0
     
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GifSearchTableViewCell", for: indexPath) as? GifSearchTableViewCell else  { return UITableViewCell() }
//        if let imageData = gifModel?.data?[indexPath.row].images {
//            if let url = imageData.downsizedSmall?.mp4 {
        
            cell.setCellData(_data: "https://media4.giphy.com/media/spBdrPSTtlfpBuYJFu/giphy.gif?cid=d546f7ceqns0j8n8s8y86w9ze05kshuc6ajf12d9mxe234ci&rid=giphy.gif&ct=g")
//            }
//        }
       
        return cell
    }
    var moviePosterUrl: URL {
         return URL(string: "http://api.giphy.com/v1/gifs/trending?api_key=Qvz4B1vkcNUr8V68lMgs5eX8HR7v2Hx1")!
        
    }
    func updateSearchResults(for searchController: UISearchController) {
//        print(searchController)
    }
    func updateTableContent() {
        getWheatherDataFromServer()
    }
    func getWheatherDataFromServer(){
       // AppInstance.showLoader()
        http.getApiData(requestUrl:  moviePosterUrl, result: GiphyModel.self) { (response) in
             self.gifModel = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }

}



struct HttpUtility {
  
    func getApiData<T:Decodable>(requestUrl: URL, result: T.Type ,completionHandler: @escaping(_ result: T) -> Void) {
       
        URLSession.shared.dataTask(with: requestUrl ) { (responseData, httpUrlResponse, error) in
            
            if error == nil && responseData != nil && responseData?.count != 0 {
              //  AppInstance.hideLoader()
                let decoder = JSONDecoder()
                do {
                   let result = try decoder.decode(T.self, from: responseData!)
                 _ = completionHandler(result)
                } catch let error {
                   // AppInstance.hideLoader()
                    print("error occured while decoding = \(error.localizedDescription)")
                }
            }
        }
        
        .resume()
    }
}
}
