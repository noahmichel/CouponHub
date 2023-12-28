//
//  Coupon.swift
//  CouponHub
//
//  Created by Noah Michel on 12/28/23.
//

import Foundation
import RealmSwift

class Coupon: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var company = ""
    @Persisted var discountCode = 0
    @Persisted var couponDescription = ""
    @Persisted var date: Date = Date()
    var couponImage: NSData? = nil
    
    convenience init(_id: ObjectId, company: String = "", discountCode: Int = 0, couponDescription: String = "", date: Date, couponImage: NSData? = nil) {
        self.init()
        self._id = _id
        self.company = company
        self.discountCode = discountCode
        self.couponDescription = couponDescription
        self.date = date
        self.couponImage = couponImage
    }
}
