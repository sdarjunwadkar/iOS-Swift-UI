//
//  FormView.swift
//  MeetUp
//
//  Created by Sharvil Arjunwadkar on 19/01/21.
//

import SwiftUI

struct FormView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var photos: [Photo]
//    @Binding var image: [(id: String, image: UIImage)]
    @State private var imageName = ""
    @State private var imageDescription = ""
    @State var uniqueImage = ""
    @State var inputImage: UIImage?
    @State private var showingImagePicker = false
    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    Circle()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.secondary)
                    
                    if inputImage != nil {
                        Image(uiImage: inputImage!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    }
                }
                Button(action: {
                    self.showingImagePicker = true
                }){
                    Text("Select Image")
                }
            
                Form {
                    Section {
                        TextField("Enter name", text: $imageName)
                        TextField("Enter Description", text: $imageDescription)
                    }
                    Section {
                        Button("Save"){
                            let photo = Photo(name: imageName, description: imageDescription, imageId: uniqueImage)
                            photos.append(photo)
//                            if inputImage != nil {
//                                image.append((uniqueImage,inputImage!))
//                            }
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .navigationBarTitle("Add Details", displayMode: .inline)
            .padding(.vertical)
            .sheet(isPresented: $showingImagePicker){
                ImagePicker(inputImage: $inputImage, uniqueImage: $uniqueImage)
            }
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

//struct FormView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormView()
//    }
//}
