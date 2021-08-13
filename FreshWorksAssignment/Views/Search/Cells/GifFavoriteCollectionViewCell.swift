//
//  GifFavoriteCollectionViewCell.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-07.
//

import UIKit

class GifFavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var gifFavouriteButton: UIButton!
    var unfavButtonAction : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func setupCell() {
        gifFavouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        gifFavouriteButton.isSelected = true
        gifImageView.layer.cornerRadius = 20
        gifImageView.layer.borderWidth = 2
        gifImageView.layer.borderColor =
            UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gifFavouriteButton.isUserInteractionEnabled = true
        gifFavouriteButton.addTarget(self, action: #selector(markFav(_:)), for:
            .touchUpInside)
    }
    func setCellData(_data: String){
        let url = URL(string: _data)
        let loader = UIActivityIndicatorView(style: .medium)
        guard let img = url else { return  }
        DispatchQueue.main.async {
            self.gifImageView.setGifFromURL(img, customLoader: loader)
        }
    }
    @objc func markFav(_ sender: UIButton){
        unfavButtonAction?()
    }
       

}
