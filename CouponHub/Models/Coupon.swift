//
//  Coupon.swift
//  CouponHub
//
//  Created by Noah Michel on 12/28/23.
//

import Foundation
import RealmSwift

class Coupon: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId = ObjectId.generate()
    @Persisted var company: String = ""
    @Persisted var discountCode: String = ""
    @Persisted var couponDescription: String = ""
    @Persisted var date: Date = Date()
    var couponImage: NSData? = nil
    
    convenience init(_id: ObjectId, company: String = "", discountCode: String = "", couponDescription: String = "", date: Date, couponImage: NSData? = nil) {
        self.init()
        self._id = _id
        self.company = company
        self.discountCode = discountCode
        self.couponDescription = couponDescription
        self.date = date
        self.couponImage = couponImage
    }
}
