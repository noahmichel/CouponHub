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
    
    @StateObject var userInfoVM : iCloudUserInfoViewModel
    @ObservedRealmObject var couponList: CouponList
    
    var body: some View {
        VStack (spacing: 0) {
            safeAreaTop
            header
            addCouponButton
            List {
                ForEach(couponList.CouponList) { coupon in
                    couponCell(coupon: coupon)
                }
                .onDelete(perform: $couponList.CouponList.remove)
                .onMove(perform: $couponList.CouponList.move)
            }
            .navigationBarItems(trailing: EditButton())
            .listStyle(PlainListStyle())
        }
    }
}

extension HomeView {
    
    private var header : some View {
        Text("\(userInfoVM.firstName) \(userInfoVM.lastName)'s Coupon Hub")
            .padding(.horizontal, 35.0)
            .frame(width: 400, height: 60)
            .background(Color.gray.opacity(0.6))
            .font(.system(size: 500))
            .fontWeight(.medium)
            .minimumScaleFactor(0.01)
            .foregroundColor(Color.black)
            .cornerRadius(0)
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
        return NavigationView {
            HomeView(userInfoVM: iCloudUserInfoViewModel(), couponList: realm.objects(CouponList.self).first!)
//                .environment(\.realm, realm)
        }
    }
}
