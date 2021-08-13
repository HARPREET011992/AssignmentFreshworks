//
//  GifSearchTableViewCell.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-07.
//

import UIKit
import SwiftyGif

class GifSearchTableViewCell: UITableViewCell {
    // MARK:- outlets for the GifSearchTableViewCell
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var gifFavButton: UIButton!
    var urlArr = [String]()
    var favButtonAction : (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK:- setup UI for gif image and button
  
    func setupCell() {
        gifImageView.layer.cornerRadius = 20
        gifImageView.layer.borderWidth = 2
        gifImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        if gifFavButton.isSelected == false{
            gifFavButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }else {
            gifFavButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        gifFavButton.setImage(UIImage(systemName: "heart"), for: .normal)
        let buttonSelect = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        gifFavButton.isUserInteractionEnabled = true
        gifFavButton.addGestureRecognizer(buttonSelect)
    }
    // MARK:- set up the data in the image view
    func setCellData(_data: String){
        let url = URL(string: _data)
        let loader = UIActivityIndicatorView(style: .medium)
        guard let img = url else { return  }
        DispatchQueue.main.async {
        self.gifImageView.setGifFromURL(img, customLoader: loader)
        }
    }
    // MARK:- method for action of button
    @objc func buttonTapped() {
        favButtonAction?()

    }
    
}
