//
//  GifFavoriteCollectionViewCell.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-07.
//

import UIKit

class GifFavoriteCollectionViewCell: UICollectionViewCell {
    // MARK:- outlets for the GifFavoriteCollectionViewCell
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var gifFavouriteButton: UIButton!
    var unfavButtonAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    // MARK:- function setup UI for gif image and button
    func setupCell() {
        gifFavouriteButton.isSelected = true
        gifImageView.layer.cornerRadius = 20
        gifImageView.layer.borderWidth = 2
        gifImageView.layer.borderColor =
            UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gifFavouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        let buttonSelect = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        gifFavouriteButton.isUserInteractionEnabled = true
        gifFavouriteButton.addGestureRecognizer(buttonSelect)
    }
    // MARK:- function to set up the data in the image view
    func setCellData(_data: String){
        let url = URL(string: _data)
        let loader = UIActivityIndicatorView(style: .medium)
        guard let img = url else { return  }
        
        DispatchQueue.main.async {
            self.gifImageView.setGifFromURL(img, customLoader: loader)
        }
    }
    // MARK:- function for action of button
    @objc func buttonTapped() {
        unfavButtonAction?()
    }
       

}
