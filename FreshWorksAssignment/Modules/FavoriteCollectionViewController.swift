//
//  FavoriteCollectionViewController.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-07.
//

import UIKit

private let reuseIdentifier = "Cell"

class FavoriteCollectionViewController: UIViewController {

    @IBOutlet weak var favouriteCollectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        favouriteCollectionView.delegate = self
//        favouriteCollectionView.dataSource = self
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    override class func description() -> String {
        "FavViewController"
    }
  
    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 0
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//        // Configure the cell
//
//        return cell
//    }

    

}
