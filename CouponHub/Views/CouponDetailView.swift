//
//  CouponDetailView.swift
//  CouponHub
//
//  Created by Noah Michel on 12/29/23.
//

import SwiftUI
import RealmSwift

struct CouponDetailView: View {
    @ObservedRealmObject var coupon: Coupon = Coupon()
    @ObservedRealmObject var couponList: CouponList = CouponList()
    
    var body: some View {
        Text("Coupon Deatil View")
    }
}

struct CouponDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CouponDetailView()
    }
}
