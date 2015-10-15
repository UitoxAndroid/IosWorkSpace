//
//  ModelCollectionViewCell.swift
//  ASAP
//
//  Created by janet on 2015/9/21.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class ModelCollectionViewCell1: UICollectionViewCell {
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    
}

class ModelCollectionViewCell2: UICollectionViewCell {
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productSalePriceLabel: UILabel!
    @IBOutlet var addCartButton: UIButton!
    
}

class LinkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var linkLabel: UILabel!
    @IBOutlet var verticalBarLabel: UILabel!
    
}