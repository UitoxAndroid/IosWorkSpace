//
//  CartAdditionTableViewCell.swift
//  ASAP
//
//  Created by janet on 2015/11/3.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

// 購物車清單-購物車加購區
class CartAdditionTableViewCell: UITableViewCell
{
    @IBOutlet var cartAddition: CartAdditionCollection!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// 購物車清單-購物車加購清單
class CartAdditionCollection: UICollectionView
{
    
}