//
//  MoreToBuyCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/18.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class MoreToBuyCell: UITableViewCell {
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var ckboxIsbuy:Checkbox!
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSpec: UILabel!
    @IBOutlet weak var lblVolume: UILabel!
    
    
    var imageURL:String?
    lazy var placeholderImage: UIImage = {
        let image = UIImage(named: "PlaceholderImage")!
        return image
        }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setImageURL()
    }
    
    
    
    func setImageURL() {
        let URL = NSURL(string: imageURL!)!
        img.kf_setImageWithURL(URL, placeholderImage: placeholderImage, optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)],
            progressBlock: { (receivedSize, totalSize) -> () in
        }) { (image, error, cacheType, imageURL) -> () in
            if error != nil  {
                log.debug(error?.description)
            }
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
