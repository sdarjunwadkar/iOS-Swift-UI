//
//  ContentView.swift
//  OfflineInformation
//
//  Created by Sharvil Arjunwadkar on 14/01/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var user: FetchedResults<User>
    @State private var userStructure = [UserStructure]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(user, id: \.self){ person in
                    NavigationLink(destination: DetailView(user: person, thatUser: user)){
                        VStack{
                            Text(person.name ?? "Unknown Name")
                            
                            VStack(spacing: 10){
                                ForEach(0..<person.tags!.count){tag in
                                    Text("\(person.tags![tag])")
                                }
                                ForEach(0..<person.friendArray.count){ frd in
                                    Text("\(person.friendArray[frd].name!)")
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("OfflineInformation")
            .onAppear(perform: loadData)
        }
    }
    func loadData()  {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
//                print(data)
                if let decoded = try? JSONDecoder().decode([UserStructure].self, from: data){
//                    print("decoded")
                    DispatchQueue.main.async {
                        self.userStructure = decoded
                        for item in userStructure {
                            let users = User(context: self.moc)
                            users.id = item.id
                            users.name = item.name
                            users.isActive = item.isActive
                            users.age = Int16(item.age)
                            users.address = item.address
                            users.about = item.about
//                            users.registered = item.registered
                            users.tags = item.tags
                            var tempFriendArray = Array<Friend>()
                            
                            item.friends.forEach { friend in
                                let newFriend = Friend(context: self.moc)
                                newFriend.id = friend.id
                                newFriend.name = friend.name
                                tempFriendArray.append(newFriend)
                            }
                            
                            users.friends = NSSet(array: tempFriendArray)
                        }
                        if moc.hasChanges {
                            try? moc.save()
                        }
                        
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
