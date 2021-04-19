//
//  ContentView.swift
//  InfoApp
//
//  Created by Sharvil Arjunwadkar on 13/01/21.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    var body: some View {
        NavigationView {
            List(users, id: \.id) { item in
                NavigationLink (destination: DetailView(users: users, user: item)){
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        HStack(spacing: 10){
                            Text("Age: \(item.age)")
                            Text("Company: \(item.company)")
                        }
                        .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle("InfoApp")
            .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decoded = try? JSONDecoder().decode([User].self, from: data){
                    DispatchQueue.main.async {
                        self.users = decoded
                    }
                    return
                }
            }
            
            print("Fetch Failed: \(error?.localizedDescription ?? "Unknown Error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
