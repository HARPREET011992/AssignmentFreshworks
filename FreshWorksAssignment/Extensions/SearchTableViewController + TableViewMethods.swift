//
//  SearchTableViewController + TableViewMethods.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-12.
//

import Foundation
import UIKit
extension SearchTableViewController : UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    func setupTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 300
   }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayGifs.count
   }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if current_offset <= offset && current_offset <= total_gifcount &&  indexPath.row == displayGifs.count - 1{
            current_offset = current_offset + 50
            getGifDataFromServer(offset: current_offset, refreshGifs: false)
        }

    }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if current_offset < offset  && indexPath.row == displayGifs.count - 1{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDentifiers.SearchTableViewLoadingCell.UserTableviewCellID, for: indexPath) as? SearchTableViewLoadingCell else
            { return UITableViewCell() }
            
            return cell
            
        }else {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIDentifiers.GifSearchTableViewCell.UserTableviewCellID, for: indexPath) as? GifSearchTableViewCell
            {
                cell.setupCell()
                
                if displayGifs.count  > 0
                {
                    let imageURL = displayGifs[indexPath.row]
                   
                    cell.setCellData(_data: imageURL)
                    
                    let arr = favList?.filter({$0.gifUrl == imageURL})
                    
                    if arr?.count ?? 0 > 0 {
                        cell.gifFavButton.isSelected = true
                        cell.gifFavButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    }
                    else{
                        cell.gifFavButton.isSelected = false
                        cell.gifFavButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                        
                    }
                }
                
                cell.favButtonAction = {[unowned self] in
                    buttonTapped(cell.gifFavButton,indexPath.row)
                }
                
                return cell
                
            }
            else  { return UITableViewCell()
                
            }
        }
    }
   
    // MARK:- Method to append and delete favourite gifs into local database

    func buttonTapped( _ sender:UIButton,_ index :Int){
        if (sender.isSelected){
            sender.isSelected = false
            sender.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            if displayGifs.count > 0
            {
                if let favData = favList {
                    for i in 0..<favData.count {
                        if favData[i].isFav && favData[i].gifUrl == displayGifs[index]{
                            favData[i].isFav = false
                            database.delete(object: (favList?[i])!)
                            database.save()
                        }
                    }
                }
            }
            
        }
        
        else {
            sender.isSelected = true
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            
            if displayGifs.count > 0
            {
                guard let favMovies = database.add(GifData.self) else {
                    return
                }
                favMovies.gifUrl = displayGifs[index]
                favMovies.isFav = true
                favList?.append(favMovies)
                database.save()
            }
            
            
        }
    }
}
