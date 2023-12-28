//
//  CouponList.swift
//  CouponHub
//
//  Created by Noah Michel on 12/28/23.
//

import Foundation
import RealmSwift

class CouponList: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var CouponList = RealmSwift.List<Coupon>()
}
