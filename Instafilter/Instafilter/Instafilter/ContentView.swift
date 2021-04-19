//
//  ContentView.swift
//  Instafilter
//
//  Created by Sharvil Arjunwadkar on 14/01/21.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

//class ImageSaver: NSObject{
//    func writeToPhotoAlbum(image: UIImage) {
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
//    }
//
//    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
//        print("Save Finished!")
//    }
//}

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    
    
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var filterName = "Change Filter"
    
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }
                .padding(.vertical)
                
                HStack {
                    Text("Radius")
                    Slider(value: radius)
                }
                .padding(.vertical)
                
                HStack{
                    Button("\(filterName)"){
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save"){
                        guard image != nil else {
                            return print("Error: No image selected")
                        }
                        
                        guard let processedImage = self.processedImage else {
                            return
                        }
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success")
                        }
                        
                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()); filterName = "Crystallize" },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()); filterName = "Edges" },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()); filterName = "Gaussian Blur" },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()); filterName = "Pixellate" },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()); filterName = "Sepia Tone" },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()); filterName = "Unsharp Mask" },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()); filterName = "Vignette" },
                    .cancel()
                ])
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
