//
//  ComboTableViewCell.swift
//  ASAP
//
//  Created by janet on 2015/11/3.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

// 購物車清單-組合商品
class ComboTableViewCell: UITableViewCell {
    
    @IBOutlet var productName: UILabel!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var gift: UILabel!
    @IBOutlet var addGift: UILabel!
    @IBOutlet var qty: UILabel!
    
    @IBOutlet var comboProductCollection: ComboProductCollection!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// 購物車清單-組合商品清單
class ComboProductCollection: UICollectionView {
    
}