//
//  Home.swift
//  CouponHub
//
//  Created by Noah Michel on 12/20/22.
//

import SwiftUI
import CloudKit

class HomeViewModel : ObservableObject {
    
    private func saveCoupon(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { returnedRecord, returnedError in
            if let returnedRecord {
                print("Successful Coupon Upload")
            } else {
                print("Error in Coupon Upload")
            }
        }
    }
    
}

struct Home: View {
    
    @StateObject var userInfoVM : iCloudUserInfoViewModel
    @StateObject var homeVM = HomeViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack (spacing: 0) {
                safeAreaTop
                header
                addCouponButton
                List {
                    Text("Coupon 1")
                    Text("Coupon 2")
                    Text("Coupon 3")
                }.listStyle(PlainListStyle())
                    
                Spacer()
            }
        }.navigationBarHidden(true)
    }
}

extension Home {
    
    private var header : some View {
        Text("\(userInfoVM.firstName) \(userInfoVM.lastName)'s Coupon Hub")
//        Text("Noah Michel's Coupon Hub")
            .padding(.horizontal, 35.0)
            .frame(width: 400, height: 60)
            .background(Color.gray.opacity(0.6))
            .font(.system(size: 500))
            .fontWeight(.medium)
            .minimumScaleFactor(0.01)
            .foregroundColor(Color.black)
            .cornerRadius(0)
//            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
    
    private var safeAreaTop : some View {
        LinearGradient(colors: [.gray], startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.top).opacity(0.6).frame(maxWidth: .infinity, maxHeight: 0)
    }
    
    private var addCouponButton : some View {
        NavigationLink {
            AddCoupon(userInfoVM: userInfoVM)
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
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(userInfoVM: iCloudUserInfoViewModel())
            .previewDevice("iPhone 14 Pro")
    }
}
