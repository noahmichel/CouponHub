//
//  Home.swift
//  CouponHub
//
//  Created by Noah Michel on 12/20/22.
//

import SwiftUI
import CloudKit
import RealmSwift

struct HomeView: View {
    
    @ObservedRealmObject var couponList: CouponList

    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                safeAreaTop
                header
                addCouponButton
                List {
                    ForEach(couponList.couponList) { coupon in
                        NavigationLink(destination: CouponDetailView(coupon: coupon)) {
                            couponCell(coupon: coupon)
                        }
                    }
                    .onDelete(perform: $couponList.couponList.remove)
                    .onMove(perform: $couponList.couponList.move)
                }
                .navigationBarItems(trailing: EditButton())
                .listStyle(PlainListStyle())
            }
        }
    }
}

extension HomeView {
    
    private var header : some View {
        Text("FirstName LastName's Coupon Hub")
            .frame(width: 400, height: 60)
            .background(Color.gray.opacity(0.6))
            .font(.system(size: 500))
            .fontWeight(.medium)
            .minimumScaleFactor(0.01)
            .foregroundColor(Color.black)
            .cornerRadius(0)
            .padding(.horizontal)
    }
    
    private var safeAreaTop : some View {
        LinearGradient(colors: [.gray], startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.top).opacity(0.6).frame(maxWidth: .infinity, maxHeight: 0)
    }
    
    private var addCouponButton : some View {
        NavigationLink {
            AddCouponView(couponList: couponList)
        } label: {
            Text("Add a Coupon")
                .font(.system(size: 32))
                .font(.headline)
                .fontWeight(.light)
                .foregroundColor(Color.white)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
        }
    }
    
    struct couponCell: View {
        @ObservedRealmObject var coupon: Coupon
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("\(coupon.description)")
            }.padding()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        let realm = realmWithData()
        HomeView(couponList: realm.objects(CouponList.self).first!)
    }
}
