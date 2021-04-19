//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Sharvil Arjunwadkar on 29/01/21.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites
    
    // Method 1
//    @State private var selectedFacility: String?
    // Method 2
    @State private var selectedFacility: Facility?
    
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    VStack {
                        Spacer()
                        Text(resort.imageCredit)
                            .background(Color.black)
                            .foregroundColor(.white)
                    }
                }
                
                Group{
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack {
                                ResortDetailsView(resort: resort)
                            }
                            VStack {
                                SkiDetailsView(resort: resort)
                            }
                            Spacer()
                        }
                        else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    // Method 1: Making String extension conform to identifiable
//                    HStack{
//                        ForEach(resort.facilities, id: \.self){ facility in
//                            Facility.icon(for: facility)
//                                .font(.title)
//                                .onTapGesture {
//                                    self.selectedFacility = facility
//                                }
//                        }
//                    }
//                    .padding(.vertical)
                    
                    // Method 2
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                
                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites"){
                    if self.favorites.contains(self.resort) {
                        self.favorites.remove(self.resort)
                    }
                    else {
                        self.favorites.add(self.resort)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        // Method 1
//        .alert(item: $selectedFacility){ facility in
//            Facility.alert(for: facility)
//        }
        
        // Method 2
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
}

//Method 1
/*
// Adding below extension we make String identifiable and ForEach doesnt require
// to have id: \.self.
extension String: Identifiable {
    public var id: String { self }
}
*/

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
