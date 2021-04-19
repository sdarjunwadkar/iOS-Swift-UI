//
//  ContentView.swift
//  MeetUp
//
//  Created by Sharvil Arjunwadkar on 19/01/21.
//

import SwiftUI

struct ContentView: View {
    @State private var photos = [Photo]()
//    @State private var image = [(id: String, image: UIImage)]()
    @State private var showingForm = false
//    @State private var uniqueImage = ""
    var body: some View {
        NavigationView {
            List{
                ForEach(photos.indices, id: \.self) { photo in
                    NavigationLink(destination: DetailView()){
                        HStack {
                            Image(uiImage: findImage(photos[photo].imageId))
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            VStack{
                                Text(photos[photo].name)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("MeetUp")
            .navigationBarItems(trailing:
                Button(action: {
                    showingForm = true
                }){
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingForm, onDismiss: {
                saveData()
                loadData()
            }){
                FormView(photos: $photos)
            }
            .onAppear(perform: loadData)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")

        do {
            let data = try Data(contentsOf: filename)
            photos = try JSONDecoder().decode([Photo].self, from: data)
//            print(photos)
//            for photo in photos {
//                print(photo)
//                let imagePath = getDocumentsDirectory().appendingPathComponent(photo.imageId)
//                print(imagePath)
//                let img = try Data(contentsOf: imagePath)
//                print(img)
//                guard let uiimage = UIImage(data: img) else { return }
//                print(uiimage)
//                if !image.isEmpty {
//                    for element in image {
//                        if element.id != photo.imageId {
//                            image.append((photo.imageId,uiimage))
//                            print(image)
//                        }
//                    }
//                }
//                else{
//                    image.append((photo.imageId,uiimage))
//                }
            }
         catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.photos)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func findImage(_ string: String) -> UIImage {
        let imagePath = getDocumentsDirectory().appendingPathComponent(string)
        do {
            let data = try Data(contentsOf: imagePath)
            return UIImage(data: data) ?? UIImage()
        }
        catch{
            print("Unable to find image")
        }
        return UIImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
