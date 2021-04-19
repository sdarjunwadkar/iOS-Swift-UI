//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Sharvil Arjunwadkar on 28/01/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)){
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1.0))
                    
                    VStack(alignment: .leading){
                        Text(resort.name)
                            .font(.headline)
                        
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort){
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
My example JSON is mostly fictional, and this includes the photos – these are just generic ski photos taken from Unsplash. Unsplash photos can be used commercially or non-commercially without attribution, but I’ve included the photo credit in the JSON so you can add it later on. As for the text, this is taken from Wikipedia. If you intend to use the text in your own shipping projects, it’s important you give credit to Wikipedia and its authors and make it clear that the work is licensed under CC-BY-SA available from here: https://creativecommons.org/licenses/by-sa/3.0.
 */
