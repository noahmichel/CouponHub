//
//  CouponDetailView.swift
//  CouponHub
//
//  Created by Noah Michel on 12/29/23.
//

import SwiftUI
import RealmSwift

struct CouponDetailView: View {
    @ObservedRealmObject var coupon: Coupon
    
    var body: some View {
        List{
            Text(coupon.company)
        }
    }
}

struct CouponDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CouponDetailView(coupon: Coupon())
    }
}
