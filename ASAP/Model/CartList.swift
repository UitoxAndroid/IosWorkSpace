//
//  CartDataSqlite.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/22.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation
import RealmSwift


public class CartList: Object
{
    let cartList = List<CartDetail>()
}

public class CartDetail: Object
{
    dynamic var smSeq = ""
    dynamic var qty = ""
    let comboList = List<CartComboData>()
    let additionList = List<CartAdditionData>()
}

public class CartComboData: Object
{
    dynamic var itno = ""
    dynamic var sno = ""
}

public class CartAdditionData: Object
{
    dynamic var itno = ""
    dynamic var qty = ""
}

