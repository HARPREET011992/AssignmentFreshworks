//
//  FavoriteCollectionViewController.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-07.
//

import UIKit
import CoreData
import SwiftyGif



class FavoriteCollectionViewController: UIViewController  {
    // MARK:- outlets for the viewController
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    var favList : [GifData]? = []
    let database = DatabaseHandler()
    // MARK:- lifeCycle for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchGifsData()
    }
    // MARK:- function for fetching data from local storage
    func fetchGifsData() {
        favList = database.fetch(GifData.self)
        favouriteCollectionView.reloadData()
    }
    
    func setupCollectionView() {
        favouriteCollectionView.delegate = self
        favouriteCollectionView.dataSource = self
    }
    // MARK:- variables for the FavouriteviewController
    override class func description() -> String {
        "FavViewController"
    }
}
extension FavoriteCollectionViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CellIDentifiers.GifFavoriteCollectionViewCell.UserTableviewCellID, for: indexPath as IndexPath) as! GifFavoriteCollectionViewCell
        cell.setupCell()
        if favList?.count ?? 0 > 0 {
            cell.setCellData(_data: favList![indexPath.item].gifUrl)
            
        }
        cell.gifFavouriteButton.tag = indexPath.row
        cell.unfavButtonAction = {[unowned self] in
            buttonTapped(cell.gifFavouriteButton, indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize = (collectionView.frame.height - (collectionView.contentInset.left + collectionView.contentInset.right)) / 3
        let itemSize1 = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)) / 2.2
        return CGSize(width: itemSize1, height: itemSize)
        
    }
    
    //MARK:-Method to delete unfavourite gifs from the local storage
    func buttonTapped( _ sender:UIButton,_ index :Int){
        if sender.isSelected == true {
            sender.isSelected = false
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            if favList?.count ?? 0 > 0 {
                let selectedimageURL = favList![index].gifUrl
                
                if let favData = favList {
                    for i in 0..<favData.count {
                        if favData[i].isFav && favData[i].gifUrl == selectedimageURL{
                            favData[i].isFav = false
                            database.delete(object:((favList?.remove(at: i))!))
                            database.save()
                            self.favouriteCollectionView.reloadData()
                        }
                    }
                }
                
            }
        }
        else {
            sender.isSelected = true
            sender.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
}
