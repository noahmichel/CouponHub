//
//  ImagePicker.swift
//  CouponHub
//
//  Created by Noah Michel on 12/22/22.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePicker : UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage
    @Environment (\.presentationMode) private var presentationMode
    
    //photoLibrary can be changed to camera
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> some UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
           var parent: ImagePicker
        
           init(_ parent: ImagePicker) {
               self.parent = parent
           }
           
       
           func imagePickerController(_ picker: UIImagePickerController, 
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
               if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                   parent.selectedImage = image
               }
        
               parent.presentationMode.wrappedValue.dismiss()
           }
       }
       
       func makeCoordinator() -> Coordinator {
           Coordinator(self)
       }
}
