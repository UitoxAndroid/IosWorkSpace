//
//  CartDiscountTableViewCell.swift
//  ASAP
//
//  Created by janet on 2015/11/3.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

// 購物車清單-購物車折扣
class CartDiscountTableViewCell: UITableViewCell {

    @IBOutlet var freeShipping: UILabel!
    @IBOutlet var deliveryCharge: UILabel!
    @IBOutlet var shoppingDiscount: UILabel!
    @IBOutlet var useShoppingCredits: CheckBox!
    @IBOutlet var shoppingCredits: UILabel!
    @IBOutlet var cartDiscount: CartDiscountCollection!
    @IBOutlet var accordDiscount: UILabel!
    @IBOutlet var notAccordDiscount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// 購物車清單-購物車折扣清單
class CartDiscountCollection: UICollectionView {
    
}