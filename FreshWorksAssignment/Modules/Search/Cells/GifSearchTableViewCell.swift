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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(_data: String){
    
//        print(_data.url?.count)
//        print(_data.bitly_gif_url?.count)
//        print(_data.bitly_url?.count)
//        print(_data.embed_url?.count)
//        print(_data.source_post_url?.count)
//        print(_data.content_url?.count)
      
      //  guard let gifURL = _data else { return  }
//         gifImageView.sd_setImage(with: URL(string: _data))
////        self.gifImageView.sdse
//        let imageURL = UIImage.gifImageWithURL(_data)
//        guard let img = imageURL else { return  }
//        self.gifImageView.image = img
     //   DispatchQueue.main.async {
         //   s
        
       // }
        
        let url = URL(string: _data)
        let loader = UIActivityIndicatorView(style: .medium)
        guard let img = url else { return  }
        gifImageView.setGifFromURL(img, customLoader: loader)
     
        
    }
    
}
