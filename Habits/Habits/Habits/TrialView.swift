//
//  TrialView.swift
//  Habits
//
//  Created by Sharvil Arjunwadkar on 12/01/21.
//

import SwiftUI

struct TrialView: View {
    @EnvironmentObject var habits: Habits
    var index: Int
    var body: some View {
        VStack{
            Text(habits.items[index].name)
                .font(.headline)
            Text(habits.items[index].description)
            
            Text("\(habits.items[index].numberOfTimes)")
        }
    }
}

//struct TrialView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrialView()
//    }
//}
