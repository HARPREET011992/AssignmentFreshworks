//
//  RootTabViewController.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-07.
//
import UIKit

class RootTabViewController: UITabBarController {

    // MARK:- variables for the viewController
    override class func description() -> String {
        "RootTabViewController"
    }
    
    // MARK:- lifeCycle for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        self.selectedIndex = 0
    }
    // MARK:- functions for the viewController
    func setupTabs() {
        self.tabBar.tintColor = UIColor.label
        self.tabBar.barStyle = .default
        
        guard let favouriteViewController = storyboard?.instantiateViewController(withIdentifier: FavoriteCollectionViewController.description()) else { return }
        guard let searchViewController = storyboard?.instantiateViewController(withIdentifier: SearchTableViewController.description()) else { return }
        favouriteViewController.tabBarItem = UITabBarItem(title: "Favorite" , image: UIImage(systemName: "star")?.withRenderingMode(.automatic), selectedImage: UIImage(systemName: "star")?.withRenderingMode(.automatic))
        favouriteViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        favouriteViewController.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 2.0)

        searchViewController.tabBarItem = UITabBarItem(title: "Feed" , image: UIImage(systemName: "magnifyingglass")?.withRenderingMode(.automatic), selectedImage: UIImage(named: "magnifyingglass")?.withRenderingMode(.automatic))
        searchViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        searchViewController.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 2.0)
        viewControllers = [searchViewController,favouriteViewController]
    }
    
    
}

