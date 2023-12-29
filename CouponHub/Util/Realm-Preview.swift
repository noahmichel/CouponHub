//
//  Realm-Preview.swift
//  CouponHub
//
//  Created by Noah Michel on 12/28/23.
//

import Foundation
import RealmSwift
import SwiftUI

extension PreviewProvider {
    static func emptyRealm() -> Realm {
        
        //config for in-memory Realm
        var conf = Realm.Configuration.defaultConfiguration
        conf.inMemoryIdentifier = "preview"
        
        let realm = try! Realm(configuration: conf)
        return realm
    }
    
    static func realmWithData(realm: Realm = emptyRealm()) -> Realm {
        
        let  existingCoupons = realm.objects(Coupon.self)
        
        if existingCoupons.count == 0 {
            let couponList = CouponList()
            
            for i in 1...5 {
                couponList.CouponList.append(Coupon(_id: ObjectId.generate(), company: "Company \(i)", couponDescription: "description \(i)", date: Date()))
            }
            
            try? realm.write({
                realm.add(couponList)
            })
        }
        return realm
    }
}
