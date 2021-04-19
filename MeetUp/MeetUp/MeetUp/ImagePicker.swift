//
//  ImagePicker.swift
//  MeetUp
//
//  Created by Sharvil Arjunwadkar on 19/01/21.
//

import SwiftUI
import UIKit


struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.inputImage = uiImage
                parent.uniqueImage = UUID().uuidString
                let imagePath = getDocumentsDirectory().appendingPathComponent(parent.uniqueImage)

                if let jpegData = parent.inputImage!.jpegData(compressionQuality: 0.8) {
                    print("Hi")
                        try? jpegData.write(to: imagePath)
                }
                print(imagePath)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
    }
    
    @Binding var inputImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @Binding var uniqueImage: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
     
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
         
    }
}
 
