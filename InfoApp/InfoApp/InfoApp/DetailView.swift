//
//  DetailView.swift
//  InfoApp
//
//  Created by Sharvil Arjunwadkar on 13/01/21.
//

import SwiftUI

struct DetailView: View {
    var users: [User]
    @State var user: User
    var body: some View {
        ScrollView {
        VStack(spacing: 20){
                VStack {
                    Text(user.name)
                        .font(.title)
                        .foregroundColor(.secondary)
                        .padding(.top)
                    
                    Text("\(user.age)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Section(header:
                    Text("Contact Details")
                            .font(.title3)
                ){
                    VStack(alignment: .leading){
                        Text("Company: \(user.company)")
                        Text("Email: \(user.email)")
                        Text("Address: \(user.address)")
                    }
                    .padding(.horizontal)
                }
                
                Section(header:
                    Text("About")
                            .font(.title3)
                ){
                    Text(user.about)
                        .padding(.horizontal)
                    Text("Registration Date: \(user.formattedDate)")
                }
            
                Section(header:
                    Text("Tags")
                            .font(.title3)
                ){
                    VStack{
                        ForEach(0..<user.tags.count){ tag in
                            Text("\(user.tags[tag])")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50, alignment: .center)
                                .background(Color.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                .padding(1)
                        }
                        .padding(.horizontal)
                    }
                }
            
                Section(header:
                    Text("Friends")
                            .font(.title3)
                ){
                    ForEach(0..<user.friends.count, id: \.self){ friend in
                        NavigationLink (destination: DetailView(users: users, user: users.first{
                            $0.id == user.friends[friend].id
                        }!)){
                            Text("\(user.friends[friend].name)")
                        }
                    }
                }
                
                
                Spacer()
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(users: [User], user: User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan",email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.", registered: "2015-11-10T01:47:18-00:00", tags: [
//            "cillum",
//            "consequat",
//            "deserunt",
//            "nostrud",
//            "eiusmod",
//            "minim",
//            "tempor"
//        ], friends: [Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"), Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6", name: "Jewel Sexton")]))
//    }
//}
