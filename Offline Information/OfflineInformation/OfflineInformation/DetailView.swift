//
//  DetailView.swift
//  OfflineInformation
//
//  Created by Sharvil Arjunwadkar on 15/01/21.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    let user: User
    let thatUser: FetchedResults<User>
    var body: some View {
        VStack {
            ForEach(0..<user.friendArray.count){ frd in
                NavigationLink(destination: DetailView(moc: _moc, user: friendLink(user.friendArray[frd]), thatUser: thatUser)){
                    Text("\(user.friendArray[frd].name!)")
                }
            }
        }
    }
    
    func friendLink(_ input: Friend) -> User {
        for person in thatUser {
            if person.id == input.id {
                return person
            }
        }
       return user
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: User())
//    }
//}
