//
//  GifSearchTableViewCell.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-07.
//

import UIKit
import SDWebImage
import SwiftyGif

class GifSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var gifFavButton: UIButton!
    var checked = false
//    var localarray = []
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellData(_data: String){
        gifFavButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        let buttonSelect = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        gifFavButton.isUserInteractionEnabled = true
        gifFavButton.addGestureRecognizer(buttonSelect)
            
        
        let url = URL(string: _data)
        let loader = UIActivityIndicatorView(style: .medium)
        guard let img = url else { return  }
        DispatchQueue.main.async {
            self.gifImageView.setGifFromURL(img, customLoader: loader)
        }
        
       
     
        
    }
    @objc func buttonTapped() {
        if gifFavButton.isSelected == true {
            gifFavButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            checked = false
//            delega
        }else {
            gifFavButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            localarray.append(<#T##newElement: Any##Any#>)
            checked = true
        }
        
    }
    
}
