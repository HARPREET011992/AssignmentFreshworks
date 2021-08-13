//
//  SearchTableViewController.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-07.
//

import UIKit
import SwiftyGif
import SwiftyJSON
class SearchTableViewController: UIViewController {
    // MARK:- outlets for the viewController
    @IBOutlet var searchTableView: UITableView!
    
    let api = NetworkManager()
    var database = DatabaseHandler()
    let searchController = UISearchController(searchResultsController: nil)
    var searchActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
   
    var gifModel: JSON?
    var favList : [GifData]? = []
    var selectedGifModel : JSON?
    var timer = Timer.init()
    var searchGifText = ""
    
    var offset = 50
    var current_offset = 50
    var total_gifcount = 50
    
    let refreshControl = UIRefreshControl()
    var displayGifs: [String]  = Array()
   
    // MARK:- variables for the Request
    var apiKey : String {
        return String("Qvz4B1vkcNUr8V68lMgs5eX8HR7v2Hx1")
    }
    var gifTrendingUrl: URL {
         return URL(string: "http://api.giphy.com/v1/gifs/trending")!
    }
    var gifSearchingUrl: URL {
         return URL(string: "http://api.giphy.com/v1/gifs/search")!
    }
 
    // MARK:- lifeCycle for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        showActivityIndicatory()
        loadGifData()
        clearCoreData()
    }
    // MARK:- variables for the SearchviewController
    override class func description() -> String {
        "SearchViewController"
    }
    override func viewWillAppear(_ animated: Bool) {
        favList = database.fetch(GifData.self)
        searchTableView.reloadData()
    }
    // MARK:- function to show activity indicator while searching for gifs
   
    func showActivityIndicatory() {
        searchActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        searchActivityIndicator.center = self.view.center
        self.view.addSubview(searchActivityIndicator)
    }
    func updateTableContent() {
        getGifDataFromServer(offset: 50,refreshGifs: true)
    }
    // MARK:- function to clear previous favourite gifs from local storage    
    func clearCoreData() {
        if favList?.count ?? 0 > 0 {
            database.clearData(GifData.self)
        }
      
    }
    // MARK:- function to get and referesh data
    func loadGifData() {
    self.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        current_offset = 50
        getGifDataFromServer(offset: 50, refreshGifs: true)
    }
    
    @objc private func refreshData(){
        current_offset = 50
        getGifDataFromServer(offset: 50, refreshGifs: true)
    }
    // MARK:- function to get trending gifs from the server
    func getGifDataFromServer(offset: Int,refreshGifs:Bool = false){
        if refreshGifs {
            refreshControl.beginRefreshing()
        }
        let parm = [URLQueryItem(name: "api_key", value: apiKey),URLQueryItem(name: "offset", value:String(offset))]
        api.getApiData(requestUrl:  gifTrendingUrl.absoluteString, parameters: parm) { [unowned
                                                                                            self] response    in
            DispatchQueue.main.async {
                if refreshGifs {
                    self.displayGifs.removeAll()
                    self.refreshControl.endRefreshing()
                }
         
                self.offset = response["pagination"]["offset"].intValue
                self.total_gifcount = response["pagination"]["total_count"].intValue
            
            for giphyData in response["data"].arrayValue
            {
                
                if  let image = giphyData["images"]["downsized"]["url"].string{
                    self.displayGifs.append(image)
                }
            }
                self.searchTableView.reloadData()
            }
        }
    }
}

