//
//  AddCoupon.swift
//  CouponHub
//
//  Created by Noah Michel on 12/21/22.
//

import SwiftUI
import CloudKit
import UIKit
import RealmSwift

func isImageSelected(image: UIImage) -> Bool {
    if image.size.width > 0 && image.size.height > 0 {
        return true
    } else {
        return false
    }
}

struct AddCouponView: View {
    
    @ObservedRealmObject var couponList: CouponList
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var newCompany = ""
    @State var newDiscountCode = ""
    @State var newDescription = ""
    @State var newDate = Date()
    
    var birthDateTxt = ViewController()
    @State var addImage = false
    @State var selectedImage: UIImage = UIImage()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var imageUploaded = false
    
    var body: some View {
        VStack {
            List {
                header
                companyTextField
                discountTextField
                descriptionTextField
                datePicker
                HStack (spacing: 40) {
                    VStack {
                        ZStack {
                            addCouponImage
                        }
                        .sheet(isPresented: $addImage) {
                            ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
                        }
                    }
                }
            }
            Spacer()
            if newCompany.isEmpty || newDiscountCode.isEmpty || newDescription.isEmpty || newDate.description.isEmpty {
                addCouponButton.disabled(true)
            } else {
                addCouponButton.disabled(false)
            }
        }
//        .navigationBarHidden(true)
//        .navigationBarItems(leading: backBarButtonItem)
    }
}

extension AddCouponView {
    
    private var header : some View {
        Text("New Coupon Details")
            .padding(.horizontal, 35.0)
            .frame(width: 400, height: 60)
            .font(.system(size: 500))
            .fontWeight(.light)
            .minimumScaleFactor(0.01)
            .cornerRadius(0)
    }
    
    private var addCouponButton : some View {
        Button {
            if let newCouponList = couponList.thaw(),
               let realm = newCouponList.realm {
                
                try? realm.write {
                    newCouponList.couponList.append(Coupon(_id: ObjectId.generate(), company: newCompany, discountCode: newDiscountCode, couponDescription: newDescription, date: newDate))
                }
                self.presentationMode.wrappedValue.dismiss()
            }

        } label: {
            Text("Save Coupon")
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
    
    private var companyTextField : some View {
        TextField("Company", text: $newCompany)
            .frame(height: 50)
            .padding(.horizontal, 15)
            .background(Color.gray.opacity(0.1))
            .font(.system(size: 24))
            .fontWeight(.light)
            .cornerRadius(10)
    }
    
    private var discountTextField : some View {
        TextField("Discount Code", text: $newDiscountCode)
            .frame(height: 50)
            .padding(.horizontal, 15)
            .background(Color.gray.opacity(0.1))
            .font(.system(size: 24))
            .fontWeight(.light)
            .cornerRadius(10)
    }
    
    private var descriptionTextField : some View {
        TextField("Discount Description", text: $newDescription, axis: .vertical)
            .frame(height: 100, alignment: .top)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1))
            .font(.system(size: 24))
            .fontWeight(.light)
            .cornerRadius(10)
    }
    
    private var datePicker : some View {
        DatePicker("Expiration Date", selection: $newDate, in: Date()..., displayedComponents: .date)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .fontWeight(.medium)
            .font(.system(size: 20))
    }
    
    private var addCouponImage : some View {
        
        Button( action: {
            addImage = true
        }, label: {
            if addImage && isImageSelected(image: selectedImage) {
                Image(uiImage: selectedImage)
                    .resizable()
                    .frame(width: 120, height: 120)
            } else {
                Text("Add Coupon Image")
                    .font(.system(size: 16))
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color.black)
                    .frame(height: 35)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 10)
            }
        })
    }
}


struct AddCoupon_Previews: PreviewProvider {
    static var previews: some View {
        let realm = realmWithData()
        AddCouponView(couponList: realm.objects(CouponList.self).first!)
    }
}
